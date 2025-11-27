# Suppress package startup messages
suppressPackageStartupMessages({
  library(shiny)
  library(ggplot2)
  library(dplyr)
  library(DT)
  library(corrplot)
  library(bslib)
  library(bsicons)
  library(thematic)
  library(plotly)
  library(scales)
})

# Suppress specific warnings
options(warn = -1)

# --- 1. DATA LOADING & CLEANING ---
df <- tryCatch({
  data <- read.csv("Mall_Customers.csv", stringsAsFactors = FALSE)
  colnames(data) <- c("CustomerID", "Gender", "Age", "Annual_Income_k", "Spending_Score")
  
  # Data validation and cleaning
  data <- data %>%
    filter(!is.na(Age) & !is.na(Annual_Income_k) & !is.na(Spending_Score)) %>%
    mutate(
      Gender = as.factor(Gender),
      Age_Group = cut(Age, breaks = c(0, 25, 35, 45, 55, 100),
                     labels = c("18-25", "26-35", "36-45", "46-55", "55+"),
                     include.lowest = TRUE),
      Income_Category = cut(Annual_Income_k, breaks = c(0, 40, 70, 100, 200),
                           labels = c("Low", "Medium", "High", "Very High"),
                           include.lowest = TRUE),
      Spending_Category = cut(Spending_Score, breaks = c(0, 33, 66, 100),
                             labels = c("Low Spender", "Medium Spender", "High Spender"),
                             include.lowest = TRUE)
    )
  data
}, error = function(e) {
  # Enhanced fallback data
  set.seed(42)
  data <- data.frame(
    CustomerID = 1:200,
    Gender = sample(c("Male", "Female"), 200, replace = TRUE),
    Age = sample(18:70, 200, replace = TRUE),
    Annual_Income_k = sample(15:137, 200, replace = TRUE),
    Spending_Score = sample(1:100, 200, replace = TRUE)
  )
  data$Age_Group <- cut(data$Age, breaks = c(0, 25, 35, 45, 55, 100),
                       labels = c("18-25", "26-35", "36-45", "46-55", "55+"),
                       include.lowest = TRUE)
  data$Income_Category <- cut(data$Annual_Income_k, breaks = c(0, 40, 70, 100, 200),
                             labels = c("Low", "Medium", "High", "Very High"),
                             include.lowest = TRUE)
  data$Spending_Category <- cut(data$Spending_Score, breaks = c(0, 33, 66, 100),
                               labels = c("Low Spender", "Medium Spender", "High Spender"),
                               include.lowest = TRUE)
  data
})

# Enable thematic for auto-styling plots
thematic_shiny()

# Calculate optimal clusters using elbow method
calculate_optimal_clusters <- function(data, max_k = 10) {
  cluster_data <- data %>% select(Annual_Income_k, Spending_Score)
  wss <- sapply(2:max_k, function(k) {
    kmeans(cluster_data, centers = k, nstart = 25)$tot.withinss
  })
  return(list(wss = wss, optimal = which.min(diff(wss)) + 1))
}

# --- 2. UI SECTION ---
ui <- page_navbar(
  
  # Enhanced modern theme with custom styling
  theme = bs_theme(
    bootswatch = "flatly",
    primary = "#2C3E50",
    success = "#18BC9C",
    info = "#3498DB",
    warning = "#F39C12",
    danger = "#E74C3C",
    base_font = font_google("Poppins"),
    heading_font = font_google("Raleway")
  ),
  
  title = div(
    style = "display: flex; align-items: center; gap: 10px;",
    bs_icon("shop", size = "1.5em"),
    "Customer Intelligence Suite"
  ),
  
  # Main Dashboard Tab
  nav_panel(
    title = "Dashboard",
    icon = bs_icon("speedometer2"),
    
    layout_sidebar(
      sidebar = sidebar(
        title = "Control Panel",
        width = 280,
        
        card(
          card_header(
            class = "bg-primary text-white",
            "Visualization Settings"
          ),
          selectInput(
            "hist_var", 
            "Select Metric:",
            choices = c("Age", "Annual_Income_k", "Spending_Score"),
            selected = "Annual_Income_k"
          ),
          
          selectInput(
            "gender_filter",
            "Filter by Gender:",
            choices = c("All", "Male", "Female"),
            selected = "All"
          ),
          
          sliderInput(
            "age_range",
            "Age Range:",
            min = 18,
            max = 70,
            value = c(18, 70),
            step = 1
          )
        ),
        
        card(
          card_header(
            class = "bg-info text-white",
            "Clustering Settings"
          ),
          sliderInput(
            "clusters", 
            "Number of Segments:",
            min = 2,
            max = 8,
            value = 5,
            step = 1
          ),
          
          checkboxInput(
            "show_centers",
            "Show Cluster Centers",
            value = TRUE
          ),
          
          checkboxInput(
            "show_ellipses",
            "Show Confidence Ellipses",
            value = TRUE
          )
        ),
        
        hr(),
        
        actionButton(
          "refresh_data",
          "Refresh Analysis",
          icon = icon("refresh"),
          class = "btn-success w-100 mb-2"
        ),
        
        downloadButton(
          "download_report",
          "Download Report",
          class = "btn-primary w-100"
        ),
        
        br(), br(),
        
        p(
          class = "text-muted text-center small",
          icon("chart-line"), " Advanced Analytics v3.0",
          br(),
          "Powered by R & Shiny"
        )
      ),
      
      # Main content area
      
      # ROW 1: Enhanced KPI Cards
      layout_columns(
        col_widths = c(3, 3, 3, 3),
        fill = FALSE,
        
        value_box(
          title = "Total Customers",
          value = textOutput("total_customers"),
          showcase = bs_icon("people-fill"),
          theme = "primary",
          p(class = "text-muted small", textOutput("gender_breakdown"))
        ),
        
        value_box(
          title = "Avg Annual Income",
          value = textOutput("avg_income"),
          showcase = bs_icon("cash-coin"),
          theme = "success",
          p(class = "text-muted small", textOutput("income_range"))
        ),
        
        value_box(
          title = "Avg Spending Score",
          value = textOutput("avg_spending"),
          showcase = bs_icon("graph-up"),
          theme = "info",
          p(class = "text-muted small", textOutput("spending_range"))
        ),
        
        value_box(
          title = "Avg Customer Age",
          value = textOutput("avg_age"),
          showcase = bs_icon("person-badge"),
          theme = "warning",
          p(class = "text-muted small", textOutput("age_range_text"))
        )
      ),
      
      br(),
      
      # ROW 2: Main visualizations in tabs
      navset_card_tab(
        height = "600px",
        full_screen = TRUE,
        
        nav_panel(
          "Overview",
          icon = bs_icon("bar-chart"),
          layout_columns(
            col_widths = c(6, 6),
            card(
              card_header("Distribution Analysis"),
              plotlyOutput("dist_plot_interactive", height = "450px")
            ),
            card(
              card_header("Gender Comparison"),
              plotlyOutput("box_plot_interactive", height = "450px")
            )
          )
        ),
        
        nav_panel(
          "Demographics",
          icon = bs_icon("people"),
          layout_columns(
            col_widths = c(6, 6),
            card(
              card_header("Age Group Distribution"),
              plotlyOutput("age_group_plot", height = "450px")
            ),
            card(
              card_header("Income vs Spending by Age"),
              plotlyOutput("age_scatter_plot", height = "450px")
            )
          )
        ),
        
        nav_panel(
          "Segmentation",
          icon = bs_icon("bullseye"),
          layout_columns(
            col_widths = c(7, 5),
            card(
              card_header("Customer Segments (K-Means Clustering)"),
              plotlyOutput("cluster_plot_interactive", height = "500px")
            ),
            card(
              card_header("Segment Insights"),
              br(),
              DTOutput("segment_summary"),
              br(),
              card(
                card_header("Elbow Method"),
                plotOutput("elbow_plot", height = "250px")
              )
            )
          )
        ),
        
        nav_panel(
          "Correlation",
          icon = bs_icon("diagram-3"),
          layout_columns(
            col_widths = c(6, 6),
            card(
              card_header("Correlation Matrix"),
              plotOutput("corr_plot", height = "450px")
            ),
            card(
              card_header("Pairwise Relationships"),
              plotOutput("pairs_plot", height = "450px")
            )
          )
        )
      )
    )
  ),
  
  # Data Explorer Tab
  nav_panel(
    title = "Data Explorer",
    icon = bs_icon("table"),
    
    card(
      card_header(
        class = "d-flex justify-content-between align-items-center",
        "Customer Data Table",
        span(textOutput("filtered_count"), class = "badge bg-primary")
      ),
      
      layout_columns(
        col_widths = c(12),
        card(
          DTOutput("raw_table")
        )
      )
    )
  ),
  
  # Insights Tab
  nav_panel(
    title = "Insights",
    icon = bs_icon("lightbulb"),
    
    layout_columns(
      col_widths = c(4, 4, 4),
      
      card(
        card_header(class = "bg-success text-white", "Top Insights"),
        uiOutput("insights_top")
      ),
      
      card(
        card_header(class = "bg-info text-white", "Customer Profiles"),
        uiOutput("customer_profiles")
      ),
      
      card(
        card_header(class = "bg-warning text-white", "Recommendations"),
        uiOutput("recommendations")
      )
    )
  )
)

# --- 3. SERVER SECTION ---
server <- function(input, output, session) {
  
  # Reactive data filtering
  filtered_data <- reactive({
    data <- df
    
    # Gender filter
    if (input$gender_filter != "All") {
      data <- data %>% filter(Gender == input$gender_filter)
    }
    
    # Age range filter
    data <- data %>% filter(Age >= input$age_range[1] & Age <= input$age_range[2])
    
    return(data)
  })
  
  # Refresh button observer
  observeEvent(input$refresh_data, {
    showNotification("Analysis refreshed!", type = "message", duration = 2)
  })
  
  # === KPI OUTPUTS ===
  
  output$total_customers <- renderText({
    nrow(filtered_data())
  })
  
  output$gender_breakdown <- renderText({
    data <- filtered_data()
    male_pct <- round(sum(data$Gender == "Male") / nrow(data) * 100, 1)
    female_pct <- round(sum(data$Gender == "Female") / nrow(data) * 100, 1)
    paste0(male_pct, "% Male | ", female_pct, "% Female")
  })
  
  output$avg_income <- renderText({
    paste0("$", round(mean(filtered_data()$Annual_Income_k), 1), "k")
  })
  
  output$income_range <- renderText({
    data <- filtered_data()
    paste0("Range: $", min(data$Annual_Income_k), "k - $", max(data$Annual_Income_k), "k")
  })
  
  output$avg_spending <- renderText({
    round(mean(filtered_data()$Spending_Score), 1)
  })
  
  output$spending_range <- renderText({
    data <- filtered_data()
    paste0("Range: ", min(data$Spending_Score), " - ", max(data$Spending_Score))
  })
  
  output$avg_age <- renderText({
    round(mean(filtered_data()$Age), 1)
  })
  
  output$age_range_text <- renderText({
    data <- filtered_data()
    paste0("Range: ", min(data$Age), " - ", max(data$Age), " years")
  })
  
  output$filtered_count <- renderText({
    paste("Showing", nrow(filtered_data()), "of", nrow(df), "customers")
  })
  
  # === DATA TABLE ===
  
  output$raw_table <- renderDT({
    data <- filtered_data() %>%
      select(CustomerID, Gender, Age, Age_Group, Annual_Income_k, 
             Income_Category, Spending_Score, Spending_Category)
    
    datatable(
      data,
      options = list(
        pageLength = 15,
        scrollX = TRUE,
        dom = 'Bfrtip',
        buttons = c('copy', 'csv', 'excel'),
        columnDefs = list(
          list(className = 'dt-center', targets = "_all")
        )
      ),
      style = "bootstrap4",
      class = "table-striped table-hover",
      filter = 'top',
      rownames = FALSE
    ) %>%
      formatStyle(
        'Spending_Score',
        background = styleColorBar(range(data$Spending_Score), '#18BC9C'),
        backgroundSize = '100% 90%',
        backgroundRepeat = 'no-repeat',
        backgroundPosition = 'center'
      )
  })
  
  # === INTERACTIVE PLOTS ===
  
  output$dist_plot_interactive <- renderPlotly({
    data <- filtered_data()
    var_name <- input$hist_var
    
    p <- ggplot(data, aes(x = .data[[var_name]])) +
      geom_histogram(bins = 25, fill = "#3498DB", color = "white", alpha = 0.8) +
      geom_density(aes(y = after_stat(count) * (max(after_stat(count)) / max(after_stat(density)))), 
                   color = "#E74C3C", linewidth = 1.2) +
      labs(
        title = paste("Distribution of", gsub("_", " ", var_name)),
        x = gsub("_", " ", var_name),
        y = "Frequency"
      ) +
      theme_minimal(base_size = 13) +
      theme(plot.title = element_text(face = "bold"))
    
    ggplotly(p, tooltip = c("x", "count")) %>%
      layout(hovermode = "x unified")
  })
  
  output$box_plot_interactive <- renderPlotly({
    data <- filtered_data()
    var_name <- input$hist_var
    
    p <- ggplot(data, aes(x = Gender, y = .data[[var_name]], fill = Gender)) +
      geom_boxplot(alpha = 0.7, outlier.color = "#E74C3C") +
      geom_jitter(width = 0.2, alpha = 0.3, size = 1) +
      scale_fill_manual(values = c("Male" = "#3498DB", "Female" = "#E91E63")) +
      labs(
        title = paste(gsub("_", " ", var_name), "by Gender"),
        x = "",
        y = gsub("_", " ", var_name)
      ) +
      theme_minimal(base_size = 13) +
      theme(
        plot.title = element_text(face = "bold"),
        legend.position = "none"
      )
    
    ggplotly(p, tooltip = c("y", "x"))
  })
  
  output$age_group_plot <- renderPlotly({
    data <- filtered_data() %>%
      group_by(Age_Group, Gender) %>%
      summarise(Count = n(), .groups = "drop")
    
    p <- ggplot(data, aes(x = Age_Group, y = Count, fill = Gender)) +
      geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
      scale_fill_manual(values = c("Male" = "#3498DB", "Female" = "#E91E63")) +
      labs(
        title = "Customer Distribution by Age Group",
        x = "Age Group",
        y = "Number of Customers"
      ) +
      theme_minimal(base_size = 13) +
      theme(plot.title = element_text(face = "bold"))
    
    ggplotly(p, tooltip = c("x", "y", "fill"))
  })
  
  output$age_scatter_plot <- renderPlotly({
    data <- filtered_data()
    
    p <- ggplot(data, aes(x = Age, y = Annual_Income_k, size = Spending_Score, 
                         color = Gender)) +
      geom_point(alpha = 0.6) +
      scale_color_manual(values = c("Male" = "#3498DB", "Female" = "#E91E63")) +
      scale_size_continuous(range = c(2, 10)) +
      labs(
        title = "Income vs Age (sized by Spending Score)",
        x = "Age",
        y = "Annual Income ($k)",
        size = "Spending Score"
      ) +
      theme_minimal(base_size = 13) +
      theme(plot.title = element_text(face = "bold"))
    
    ggplotly(p, tooltip = c("x", "y", "size", "color"))
  })
  
  # Clustering analysis
  cluster_results <- reactive({
    data <- filtered_data() %>% select(Annual_Income_k, Spending_Score)
    set.seed(123)
    kmeans(data, centers = input$clusters, nstart = 25)
  })
  
  output$cluster_plot_interactive <- renderPlotly({
    data <- filtered_data() %>% select(Annual_Income_k, Spending_Score)
    km <- cluster_results()
    
    cluster_df <- data
    cluster_df$Cluster <- as.factor(km$cluster)
    cluster_df$Gender <- filtered_data()$Gender
    
    centers_df <- as.data.frame(km$centers)
    centers_df$Cluster <- as.factor(1:nrow(centers_df))
    
    p <- ggplot(cluster_df, aes(x = Annual_Income_k, y = Spending_Score, 
                                color = Cluster, text = paste("Gender:", Gender))) +
      geom_point(size = 3, alpha = 0.6) +
      labs(
        title = paste("Customer Segments (K =", input$clusters, ")"),
        x = "Annual Income ($k)",
        y = "Spending Score (1-100)"
      ) +
      theme_minimal(base_size = 13) +
      theme(plot.title = element_text(face = "bold"))
    
    if (input$show_centers) {
      p <- p + geom_point(data = centers_df, aes(x = Annual_Income_k, y = Spending_Score),
                         size = 8, shape = 23, fill = "yellow", color = "black", 
                         inherit.aes = FALSE)
    }
    
    if (input$show_ellipses) {
      p <- p + stat_ellipse(aes(fill = Cluster), geom = "polygon", alpha = 0.1, level = 0.95)
    }
    
    ggplotly(p, tooltip = c("x", "y", "color", "text"))
  })
  
  output$segment_summary <- renderDT({
    data <- filtered_data()
    km <- cluster_results()
    
    data$Cluster <- km$cluster
    
    summary_df <- data %>%
      group_by(Cluster) %>%
      summarise(
        Count = n(),
        `Avg Age` = round(mean(Age), 1),
        `Avg Income` = round(mean(Annual_Income_k), 1),
        `Avg Spending` = round(mean(Spending_Score), 1),
        .groups = "drop"
      ) %>%
      arrange(desc(Count))
    
    datatable(
      summary_df,
      options = list(
        pageLength = 10,
        dom = 't',
        columnDefs = list(
          list(className = 'dt-center', targets = "_all")
        )
      ),
      rownames = FALSE,
      style = "bootstrap4",
      class = "table-sm"
    )
  })
  
  output$elbow_plot <- renderPlot({
    optimal_info <- calculate_optimal_clusters(filtered_data())
    
    elbow_df <- data.frame(
      K = 2:10,
      WSS = optimal_info$wss
    )
    
    ggplot(elbow_df, aes(x = K, y = WSS)) +
      geom_line(color = "#3498DB", linewidth = 1.2) +
      geom_point(color = "#E74C3C", size = 3) +
      geom_vline(xintercept = optimal_info$optimal, 
                linetype = "dashed", color = "#18BC9C", linewidth = 1) +
      labs(
        title = "Optimal K Selection",
        x = "Number of Clusters (K)",
        y = "Total WSS"
      ) +
      theme_minimal(base_size = 10) +
      theme(
        plot.title = element_text(face = "bold", size = 11),
        plot.margin = margin(10, 10, 10, 10)
      )
  }, height = 250, res = 96)
  
  output$corr_plot <- renderPlot({
    num_data <- filtered_data() %>% select(Age, Annual_Income_k, Spending_Score)
    M <- cor(num_data)
    
    corrplot(
      M,
      method = "circle",
      type = "upper",
      addCoef.col = "black",
      tl.col = "black",
      tl.srt = 45,
      diag = FALSE,
      col = colorRampPalette(c("#E74C3C", "white", "#3498DB"))(200),
      title = "Correlation Between Variables",
      mar = c(0, 0, 2, 0),
      number.cex = 1.2
    )
  })
  
  output$pairs_plot <- renderPlot({
    num_data <- filtered_data() %>% 
      select(Age, Annual_Income_k, Spending_Score)
    
    pairs(
      num_data,
      col = alpha("#3498DB", 0.5),
      pch = 19,
      main = "Pairwise Scatter Plots",
      gap = 0.5,
      cex = 0.8
    )
  })
  
  # === INSIGHTS ===
  
  output$insights_top <- renderUI({
    data <- filtered_data()
    
    avg_income <- mean(data$Annual_Income_k)
    avg_spending <- mean(data$Spending_Score)
    
    high_value <- data %>% 
      filter(Annual_Income_k > quantile(Annual_Income_k, 0.75) & 
             Spending_Score > quantile(Spending_Score, 0.75)) %>%
      nrow()
    
    tagList(
      tags$div(
        class = "p-3",
        tags$h5(icon("star"), " Key Findings"),
        tags$hr(),
        tags$ul(
          tags$li(
            tags$strong("Average Income: "),
            paste0("$", round(avg_income, 1), "k"),
            tags$br(),
            tags$small(class = "text-muted", "Median annual income of customer base")
          ),
          tags$br(),
          tags$li(
            tags$strong("Spending Score: "),
            round(avg_spending, 1), "/100",
            tags$br(),
            tags$small(class = "text-muted", "Average customer engagement level")
          ),
          tags$br(),
          tags$li(
            tags$strong("High-Value Customers: "),
            high_value, " (", round(high_value/nrow(data)*100, 1), "%)",
            tags$br(),
            tags$small(class = "text-muted", "High income + High spending")
          )
        )
      )
    )
  })
  
  output$customer_profiles <- renderUI({
    data <- filtered_data()
    km <- cluster_results()
    data$Cluster <- km$cluster
    
    # Find the largest cluster
    largest_cluster <- data %>%
      group_by(Cluster) %>%
      summarise(n = n()) %>%
      arrange(desc(n)) %>%
      slice(1) %>%
      pull(Cluster)
    
    cluster_info <- data %>%
      filter(Cluster == largest_cluster) %>%
      summarise(
        avg_age = round(mean(Age), 1),
        avg_income = round(mean(Annual_Income_k), 1),
        avg_spending = round(mean(Spending_Score), 1),
        count = n()
      )
    
    tagList(
      tags$div(
        class = "p-3",
        tags$h5(icon("user-circle"), " Dominant Segment"),
        tags$hr(),
        tags$div(
          class = "alert alert-info",
          tags$strong(paste("Cluster", largest_cluster)),
          tags$br(),
          tags$small(paste(cluster_info$count, "customers"))
        ),
        tags$ul(
          tags$li(tags$strong("Avg Age: "), cluster_info$avg_age, "years"),
          tags$li(tags$strong("Avg Income: "), paste0("$", cluster_info$avg_income, "k")),
          tags$li(tags$strong("Spending: "), cluster_info$avg_spending, "/100")
        ),
        tags$hr(),
        tags$p(
          class = "small text-muted",
          "This represents the largest customer segment in your filtered dataset."
        )
      )
    )
  })
  
  output$recommendations <- renderUI({
    data <- filtered_data()
    
    high_income_low_spending <- data %>%
      filter(Annual_Income_k > quantile(Annual_Income_k, 0.75) &
             Spending_Score < quantile(Spending_Score, 0.25)) %>%
      nrow()
    
    low_income_high_spending <- data %>%
      filter(Annual_Income_k < quantile(Annual_Income_k, 0.25) &
             Spending_Score > quantile(Spending_Score, 0.75)) %>%
      nrow()
    
    tagList(
      tags$div(
        class = "p-3",
        tags$h5(icon("lightbulb"), " Action Items"),
        tags$hr(),
        
        if (high_income_low_spending > 0) {
          tags$div(
            class = "alert alert-warning",
            tags$strong(icon("exclamation-triangle"), " Opportunity Found"),
            tags$p(
              class = "mb-0 small",
              paste(high_income_low_spending, "high-income customers have low spending scores."),
              tags$br(),
              tags$em("Consider premium product offerings or loyalty programs.")
            )
          )
        },
        
        if (low_income_high_spending > 0) {
          tags$div(
            class = "alert alert-success",
            tags$strong(icon("check-circle"), " Engaged Segment"),
            tags$p(
              class = "mb-0 small",
              paste(low_income_high_spending, "customers are highly engaged despite lower income."),
              tags$br(),
              tags$em("Focus on retention and value products.")
            )
          )
        },
        
        tags$div(
          class = "alert alert-info",
          tags$strong(icon("chart-line"), " Growth Strategy"),
          tags$p(
            class = "mb-0 small",
            "Target mid-range income customers (40-70k) with personalized campaigns to increase spending scores."
          )
        )
      )
    )
  })
  
  # Download Report
  output$download_report <- downloadHandler(
    filename = function() {
      paste0("customer_analysis_", Sys.Date(), ".csv")
    },
    content = function(file) {
      data <- filtered_data()
      km <- cluster_results()
      data$Cluster <- km$cluster
      write.csv(data, file, row.names = FALSE)
    }
  )
}

# --- 4. RUN APP ---
shinyApp(ui = ui, server = server)

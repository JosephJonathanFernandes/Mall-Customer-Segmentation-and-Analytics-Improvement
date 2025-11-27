# Customer Intelligence Dashboard

An advanced R Shiny web application for comprehensive customer segmentation and behavioral analysis using machine learning clustering algorithms.

<div align="center">

![R](https://img.shields.io/badge/R-276DC3?style=for-the-badge&logo=r&logoColor=white)
![Shiny](https://img.shields.io/badge/Shiny-4285F4?style=for-the-badge&logo=rstudio&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)
![Version](https://img.shields.io/badge/version-3.0.0-blue?style=for-the-badge)
![Status](https://img.shields.io/badge/status-active-success?style=for-the-badge)

[Features](#-features) •
[Demo](#-demo) •
[Installation](#-installation) •
[Usage](#-usage-guide) •
[Contributing](#-contributing) •
[License](#-license)

</div>

---

## 📊 Overview

This interactive dashboard provides deep insights into customer behavior through advanced data visualization and K-Means clustering analysis. Built with modern UI/UX principles, it helps businesses understand their customer base and make data-driven decisions.

### 🎥 Demo

> **Note**: Screenshots and demo GIF can be added here once the application is deployed or recorded.

### ✨ Key Highlights

- 🎯 **Real-time Analytics** with interactive visualizations
- 🤖 **AI-Powered Insights** for business intelligence
- 📊 **K-Means Clustering** with automatic optimization
- 🎨 **Modern UI/UX** with responsive design
- 📥 **Export Capabilities** for reports and data
- 🔍 **Advanced Filtering** by multiple dimensions

## ✨ Features

### 🎯 Interactive Analytics
- **Real-time KPI Metrics**: Dynamic value boxes showing total customers, average income, spending scores, and age demographics
- **Advanced Filtering**: Filter by gender, age range, and custom parameters
- **Multi-dimensional Visualizations**: Interactive Plotly charts with hover tooltips and zoom capabilities

### 📈 Comprehensive Analysis Tools

#### Dashboard Tab
- **Distribution Analysis**: Interactive histograms with density overlays
- **Gender Comparison**: Box plots with jitter points for detailed comparison
- **Demographics**: Age group distribution and multi-variable scatter plots
- **Customer Segmentation**: K-Means clustering with configurable parameters
- **Correlation Analysis**: Correlation matrices and pairwise relationship plots

#### Data Explorer
- **Interactive Data Table**: Sortable, filterable, and searchable customer data
- **Export Capabilities**: Download filtered data as CSV/Excel
- **Visual Indicators**: Color-coded spending scores

#### Insights Tab
- **AI-Generated Insights**: Automatic identification of key findings
- **Customer Profiling**: Dominant segment analysis
- **Actionable Recommendations**: Business intelligence suggestions based on data patterns

### 🔧 Advanced Features
- **Elbow Method**: Automatic optimal cluster calculation
- **Cluster Centers**: Toggle visualization of segment centroids
- **Confidence Ellipses**: Statistical boundary visualization
- **Report Generation**: One-click CSV export with cluster assignments
- **Responsive Design**: Modern, mobile-friendly interface

## 🛠️ Technology Stack

- **R** (v4.4.1+)
- **Shiny** - Web application framework
- **ggplot2** - Data visualization
- **plotly** - Interactive graphics
- **dplyr** - Data manipulation
- **DT** - Interactive tables
- **corrplot** - Correlation visualization
- **bslib** - Modern Bootstrap theming
- **bsicons** - Icon library
- **thematic** - Plot theming
- **scales** - Scale formatting

## 📦 Installation

### Prerequisites
- R (version 4.4.1 or higher)
- RStudio (recommended)

### Setup Instructions

1. **Clone or download this repository**
```bash
git clone <repository-url>
cd mall_data_analysis_in_R
```

2. **Install required packages**
```r
# Run in R console
install.packages(c(
  "shiny", 
  "ggplot2", 
  "dplyr", 
  "DT", 
  "corrplot", 
  "bslib", 
  "bsicons", 
  "thematic", 
  "plotly", 
  "scales"
))
```

3. **Prepare your data**
   - Place your `Mall_Customers.csv` file in the project directory
   - Expected columns: CustomerID, Gender, Age, Annual Income (k$), Spending Score (1-100)

4. **Run the application**
```r
# Method 1: Using Shiny
shiny::runApp("app.R")

# Method 2: Using RStudio
# Open app.R and click "Run App" button
```

## 📁 Project Structure

```
mall_data_analysis_in_R/
│
├── app.R                    # Main Shiny application
├── Mall_Customers.csv       # Customer dataset
├── README.md               # Project documentation
└── SGS_DA_MINI_PROJECT.pdf # Original project reference
```

## 🎮 Usage Guide

### Navigation
1. **Dashboard Tab**: Main analytics workspace with comprehensive visualizations
2. **Data Explorer Tab**: Browse and export customer data
3. **Insights Tab**: View AI-generated business intelligence

### Controls
- **Distribution Variable**: Select metric to analyze (Age, Income, Spending Score)
- **Gender Filter**: Filter data by customer gender
- **Age Range**: Adjust age range slider to focus on specific demographics
- **Number of Segments**: Set K-Means cluster count (2-8)
- **Visualization Toggles**: Show/hide cluster centers and confidence ellipses
- **Refresh Analysis**: Recalculate all metrics and insights
- **Download Report**: Export analysis results as CSV

### Interpreting Results

#### Customer Segments
- **High Value**: High income + High spending (prime target for premium products)
- **Potential**: High income + Low spending (opportunity for engagement)
- **Loyal**: Low income + High spending (focus on retention)
- **Budget**: Low income + Low spending (value product offerings)

#### Key Metrics
- **Spending Score**: 1-100 scale indicating customer engagement level
- **Annual Income**: Customer purchasing power in thousands ($k)
- **Cluster Analysis**: Groups customers with similar behavioral patterns

## 📊 Sample Insights

The dashboard automatically generates insights such as:
- Percentage of high-value customers
- Gender distribution patterns
- Age group preferences
- Income vs. spending correlations
- Segment-specific recommendations

## 🚀 Advanced Customization

### Modifying Themes
```r
# In app.R, update the theme
theme = bs_theme(
  bootswatch = "flatly",  # Try: "darkly", "minty", "journal"
  primary = "#2C3E50",
  # Add custom colors
)
```

### Adding Custom Metrics
```r
# Add to server function
output$custom_metric <- renderText({
  # Your calculation
})
```

## 📝 Data Format

Your CSV should follow this structure:
```csv
CustomerID,Gender,Age,Annual Income (k$),Spending Score (1-100)
1,Male,19,15,39
2,Female,21,15,81
...
```

## 🤝 Credits & Acknowledgments

**Original Concept & Design**: [Sushant Govind Shetti](https://github.com/SushantGShetti)

This project is an enhanced implementation based on the original customer segmentation analysis by Sushant Govind Shetti. The original work provided the foundational approach to mall customer analysis and segmentation methodology.

### Enhancements in This Version
- Modern multi-tab navigation interface
- Interactive Plotly visualizations
- Advanced filtering and data exploration tools
- AI-generated insights and recommendations
- Elbow method for optimal cluster selection
- Export functionality and report generation
- Enhanced UI/UX with bslib theming
- Responsive design for all screen sizes

## 🌟 Star History

If you find this project useful, please consider giving it a star ⭐

## 📊 Project Stats

![GitHub last commit](https://img.shields.io/github/last-commit/yourusername/mall_data_analysis_in_R)
![GitHub issues](https://img.shields.io/github/issues/yourusername/mall_data_analysis_in_R)
![GitHub pull requests](https://img.shields.io/github/issues-pr/yourusername/mall_data_analysis_in_R)

## 📝 Citation

If you use this project in your research or work, please cite:

```bibtex
@software{customer_intelligence_dashboard,
  title = {Customer Intelligence Dashboard},
  author = {Original: Sushant Govind Shetti, Enhanced: Contributors},
  year = {2025},
  url = {https://github.com/yourusername/mall_data_analysis_in_R}
}
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🐛 Troubleshooting

### Common Issues

**App doesn't start**
- Ensure all packages are installed
- Check R version compatibility
- Verify CSV file is in correct location

**Visualizations not showing**
- Check browser console for errors
- Try different browsers (Chrome recommended)
- Clear browser cache

**Data not loading**
- Verify CSV file format
- Check column names match expected format
- Ensure no missing values in critical columns

## 📬 Contact & Support

For questions, suggestions, or issues:
- Open an issue on GitHub
- Check existing documentation
- Review original project by Sushant Govind Shetti

## 🌟 Contributing

Contributions are welcome! Please read our [Contributing Guidelines](CONTRIBUTING.md) and [Code of Conduct](CODE_OF_CONDUCT.md) before submitting PRs.

### How to Contribute

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## 📋 Roadmap

- [ ] Add user authentication
- [ ] Implement database backend
- [ ] Add more clustering algorithms (DBSCAN, Hierarchical)
- [ ] Export to PDF reports
- [ ] Add time-series analysis
- [ ] Multi-language support
- [ ] Mobile app version
- [ ] API endpoints for integration

## 📞 Support

- 📫 **Issues**: [GitHub Issues](https://github.com/yourusername/mall_data_analysis_in_R/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/yourusername/mall_data_analysis_in_R/discussions)
- 📖 **Documentation**: [Wiki](https://github.com/yourusername/mall_data_analysis_in_R/wiki)

## 🔒 Security

Please review our [Security Policy](SECURITY.md) for reporting vulnerabilities.

---

<div align="center">

**Built with ❤️ using R & Shiny**

*Enhanced and expanded by the community | Original concept by Sushant Govind Shetti*

⭐ **Star this repo if you find it helpful!** ⭐

</div>

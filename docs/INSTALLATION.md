# Installation Guide

Complete step-by-step installation guide for the Customer Intelligence Dashboard.

## Table of Contents
- [System Requirements](#system-requirements)
- [Installing R](#installing-r)
- [Installing RStudio (Optional)](#installing-rstudio-optional)
- [Installing Required Packages](#installing-required-packages)
- [Setting Up the Project](#setting-up-the-project)
- [Running the Application](#running-the-application)
- [Troubleshooting](#troubleshooting)

## System Requirements

### Minimum Requirements
- **OS**: Windows 10/11, macOS 10.14+, or Linux (Ubuntu 18.04+)
- **RAM**: 4 GB minimum (8 GB recommended)
- **Disk Space**: 2 GB free space
- **R Version**: 4.4.1 or higher
- **Internet**: Required for package installation

### Recommended Requirements
- **RAM**: 16 GB
- **Processor**: Quad-core processor
- **Display**: 1920x1080 resolution

## Installing R

### Windows
1. Visit [CRAN](https://cran.r-project.org/bin/windows/base/)
2. Download the latest R installer (R-4.4.1 or newer)
3. Run the installer with administrator privileges
4. Follow the installation wizard (default settings are fine)
5. Verify installation:
   ```powershell
   & "C:\Program Files\R\R-4.4.1\bin\x64\R.exe" --version
   ```

### macOS
1. Visit [CRAN](https://cran.r-project.org/bin/macosx/)
2. Download the latest R package (.pkg file)
3. Open the .pkg file and follow instructions
4. Verify installation:
   ```bash
   R --version
   ```

### Linux (Ubuntu/Debian)
```bash
# Add CRAN repository
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'

# Update and install R
sudo apt update
sudo apt install r-base r-base-dev

# Verify installation
R --version
```

## Installing RStudio (Optional)

RStudio provides a better development environment but is not required.

### All Platforms
1. Visit [RStudio Download](https://posit.co/download/rstudio-desktop/)
2. Download RStudio Desktop (free version)
3. Install following platform-specific instructions
4. Launch RStudio to verify installation

## Installing Required Packages

### Method 1: Automatic Installation (Recommended)

Run this script in R console:

```r
# List of required packages
required_packages <- c(
  "shiny",      # Web application framework
  "ggplot2",    # Data visualization
  "dplyr",      # Data manipulation
  "DT",         # Interactive tables
  "corrplot",   # Correlation plots
  "bslib",      # Bootstrap theming
  "bsicons",    # Bootstrap icons
  "thematic",   # Theming for plots
  "plotly",     # Interactive plots
  "scales"      # Scale functions
)

# Install missing packages
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) {
  install.packages(new_packages, repos = "https://cran.rstudio.com/")
}

# Verify installation
cat("Installed packages:\n")
sapply(required_packages, function(pkg) {
  if(require(pkg, character.only = TRUE, quietly = TRUE)) {
    cat(paste0("✓ ", pkg, " (", packageVersion(pkg), ")\n"))
  } else {
    cat(paste0("✗ ", pkg, " - FAILED\n"))
  }
})
```

### Method 2: Manual Installation

Install packages one by one:

```r
install.packages("shiny")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("DT")
install.packages("corrplot")
install.packages("bslib")
install.packages("bsicons")
install.packages("thematic")
install.packages("plotly")
install.packages("scales")
```

### Verification

Check if all packages are installed:

```r
required_packages <- c("shiny", "ggplot2", "dplyr", "DT", "corrplot", 
                       "bslib", "bsicons", "thematic", "plotly", "scales")
all(required_packages %in% installed.packages()[,"Package"])
```

Should return `TRUE` if all packages are installed.

## Setting Up the Project

### Method 1: Download ZIP

1. Download the repository as ZIP
2. Extract to your desired location
3. Navigate to the project folder

### Method 2: Git Clone

```bash
# Clone the repository
git clone https://github.com/yourusername/mall_data_analysis_in_R.git

# Navigate to project directory
cd mall_data_analysis_in_R
```

### Project Structure

After setup, your directory should look like:

```
mall_data_analysis_in_R/
├── app.R                     # Main application file
├── Mall_Customers.csv        # Sample dataset
├── README.md                 # Documentation
├── LICENSE                   # MIT License
├── CONTRIBUTING.md           # Contribution guidelines
├── CHANGELOG.md              # Version history
├── SECURITY.md              # Security policy
├── .gitignore               # Git ignore rules
└── .github/                 # GitHub templates
    ├── ISSUE_TEMPLATE/
    └── pull_request_template.md
```

## Running the Application

### Option 1: Command Line

#### Windows PowerShell
```powershell
cd C:\path\to\mall_data_analysis_in_R
& "C:\Program Files\R\R-4.4.1\bin\x64\Rscript.exe" -e "shiny::runApp('app.R', launch.browser = TRUE)"
```

#### macOS/Linux Terminal
```bash
cd /path/to/mall_data_analysis_in_R
Rscript -e "shiny::runApp('app.R', launch.browser = TRUE)"
```

### Option 2: RStudio

1. Open RStudio
2. Open `app.R` file
3. Click the "Run App" button in the top-right corner
4. The app will launch in a new window or browser

### Option 3: R Console

```r
# Set working directory
setwd("/path/to/mall_data_analysis_in_R")

# Run the app
shiny::runApp("app.R", launch.browser = TRUE)
```

## Accessing the Application

Once running, the app will be accessible at:
- **Default URL**: http://127.0.0.1:XXXX (port varies)
- The URL will be displayed in the console
- Browser should open automatically

## Troubleshooting

### Issue: R not found

**Solution**: Add R to system PATH

#### Windows
```powershell
$env:Path += ";C:\Program Files\R\R-4.4.1\bin\x64"
```

#### macOS/Linux
```bash
export PATH="/usr/local/bin:$PATH"
```

### Issue: Package installation fails

**Solution 1**: Update R to latest version

**Solution 2**: Install system dependencies (Linux)
```bash
sudo apt-get install libcurl4-openssl-dev libssl-dev libxml2-dev
```

**Solution 3**: Use different CRAN mirror
```r
options(repos = c(CRAN = "https://cloud.r-project.org/"))
```

### Issue: Port already in use

**Solution**: Specify a different port
```r
shiny::runApp("app.R", port = 8080)
```

### Issue: Browser doesn't open automatically

**Solution**: Manually open the URL shown in console
```
Listening on http://127.0.0.1:XXXX
```

### Issue: CSV file not found

**Solution**: Ensure `Mall_Customers.csv` is in the same directory as `app.R`

### Issue: Plots not rendering

**Solution**: Clear browser cache or try a different browser (Chrome recommended)

### Issue: Out of memory error

**Solution**: Increase memory limit
```r
memory.limit(size = 16000)  # Windows only
```

## Performance Optimization

### For Large Datasets

1. **Increase Memory**:
```r
options(shiny.maxRequestSize = 30*1024^2)  # 30 MB max file size
```

2. **Enable Caching**:
```r
# Add to app.R
options(shiny.reactlog = FALSE)
```

3. **Use Data Sampling**:
```r
# Sample large datasets
if(nrow(data) > 10000) {
  data <- data[sample(nrow(data), 10000), ]
}
```

## Next Steps

After successful installation:

1. ✅ Read the [User Guide](../README.md#usage-guide)
2. ✅ Explore sample data with provided CSV
3. ✅ Try uploading your own data
4. ✅ Check out [Contributing Guidelines](../CONTRIBUTING.md)
5. ✅ Report issues on [GitHub](https://github.com/yourusername/mall_data_analysis_in_R/issues)

## Getting Help

- **Documentation**: [README.md](../README.md)
- **Issues**: [GitHub Issues](https://github.com/yourusername/mall_data_analysis_in_R/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/mall_data_analysis_in_R/discussions)

---

*Last updated: November 27, 2025*

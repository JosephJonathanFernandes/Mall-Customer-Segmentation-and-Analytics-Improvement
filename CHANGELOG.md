# Changelog

All notable changes to the Customer Intelligence Dashboard will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2025-11-27

### Added
- Multi-tab navigation interface with Dashboard, Data Explorer, and Insights tabs
- Interactive Plotly visualizations with hover tooltips and zoom capabilities
- Advanced filtering system (gender filter, age range slider)
- AI-generated insights and business recommendations
- Customer segmentation analysis with K-Means clustering
- Elbow method for optimal cluster selection
- Dynamic KPI cards with real-time updates
- Demographics analysis tab with age group distributions
- Correlation analysis with matrix and pairwise plots
- Export functionality for filtered data and analysis results
- Download report feature with cluster assignments
- Segment summary table with detailed statistics
- Responsive design with modern Bootstrap theming
- Custom font integration (Google Fonts: Poppins & Raleway)
- Toggle controls for cluster centers and confidence ellipses
- Interactive data table with search, sort, and filter capabilities

### Changed
- Upgraded from static ggplot2 charts to interactive Plotly visualizations
- Enhanced UI/UX with bslib modern theming
- Improved data processing with automatic categorization
- Optimized clustering algorithm with nstart=25 for better results
- Replaced deprecated `aes_string()` with modern `aes()` syntax
- Updated navbar styling to use current bslib standards
- Improved color scheme for better accessibility

### Fixed
- Plot sizing issues in elbow method visualization
- Deprecated function warnings
- Gender breakdown calculation accuracy
- Data filtering reactivity issues

### Removed
- Deprecated UI parameters (bg, inverse)
- Old static visualization approach
- Unnecessary package startup messages

## [2.0.0] - Original Version by Sushant Govind Shetti

### Added
- Initial customer segmentation dashboard
- Basic K-Means clustering implementation
- Distribution analysis
- Gender-based comparison
- Correlation matrix visualization
- Raw data table view
- CSV data loading with fallback

### Features
- Simple sidebar layout
- Basic histogram and boxplot visualizations
- K-Means clustering with adjustable parameters
- Correlation analysis
- Modern flat design theme

---

## Version History

- **v3.0.0** - Enhanced edition with advanced analytics and modern UI (2025-11-27)
- **v2.0.0** - Original implementation by Sushant Govind Shetti

## Credits

**Original Creator**: Sushant Govind Shetti  
**Enhanced Version**: Community Contributors

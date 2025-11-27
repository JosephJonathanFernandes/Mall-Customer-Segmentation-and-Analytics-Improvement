# Contributing to Customer Intelligence Dashboard

First off, thank you for considering contributing to this project! 🎉

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When you create a bug report, include as many details as possible:

* **Use a clear and descriptive title**
* **Describe the exact steps to reproduce the problem**
* **Provide specific examples**
* **Describe the behavior you observed and what you expected**
* **Include screenshots if relevant**
* **Include your R version and package versions**

### Suggesting Enhancements

Enhancement suggestions are tracked as GitHub issues. When creating an enhancement suggestion:

* **Use a clear and descriptive title**
* **Provide a detailed description of the suggested enhancement**
* **Explain why this enhancement would be useful**
* **List any examples of how this works in other applications**

### Pull Requests

1. Fork the repository
2. Create a new branch (`git checkout -b feature/AmazingFeature`)
3. Make your changes
4. Test your changes thoroughly
5. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
6. Push to the branch (`git push origin feature/AmazingFeature`)
7. Open a Pull Request

#### Pull Request Guidelines

* Follow the existing code style
* Update documentation as needed
* Add comments for complex logic
* Test your changes with different datasets
* Update README.md if you add new features
* Keep pull requests focused on a single feature/fix

### Code Style Guidelines

#### R Code Style

* Use 2 spaces for indentation
* Use `<-` for assignment, not `=`
* Keep lines under 80 characters when possible
* Use meaningful variable names
* Add comments for complex operations
* Follow [tidyverse style guide](https://style.tidyverse.org/)

Example:
```r
# Good
calculate_customer_score <- function(income, spending) {
  score <- (income * 0.3) + (spending * 0.7)
  return(score)
}

# Bad
calc<-function(i,s){return((i*.3)+(s*.7))}
```

#### Shiny UI/UX Guidelines

* Maintain consistent spacing and alignment
* Use meaningful IDs for UI elements
* Keep UI code modular and organized
* Test responsiveness on different screen sizes
* Ensure accessibility (color contrast, screen readers)

### Development Setup

1. Install R (version 4.4.1 or higher)
2. Install required packages:
```r
install.packages(c(
  "shiny", "ggplot2", "dplyr", "DT", 
  "corrplot", "bslib", "bsicons", 
  "thematic", "plotly", "scales"
))
```
3. Clone your fork
4. Create a new branch
5. Start developing!

### Testing

Before submitting a PR:

* Test with the provided Mall_Customers.csv
* Test with your own datasets
* Test all filtering options
* Test all visualization tabs
* Test on different browsers (Chrome, Firefox, Safari)
* Check for console errors
* Verify exports work correctly

### Documentation

* Update README.md for new features
* Add inline comments for complex code
* Update function documentation
* Include examples where appropriate

## Project Structure

```
mall_data_analysis_in_R/
├── app.R                    # Main Shiny application
├── Mall_Customers.csv       # Sample dataset
├── README.md               # Project documentation
├── LICENSE                 # MIT License
├── CODE_OF_CONDUCT.md      # Community guidelines
├── CONTRIBUTING.md         # This file
└── .gitignore             # Git ignore rules
```

## Recognition

Contributors will be recognized in the project README. Significant contributions may result in co-authorship credit.

## Questions?

Feel free to open an issue with your question or reach out to the maintainers.

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing! 🙏

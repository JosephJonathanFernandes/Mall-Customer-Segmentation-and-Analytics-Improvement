# Security Policy

## Supported Versions

We release patches for security vulnerabilities in the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 3.0.x   | :white_check_mark: |
| 2.0.x   | :x:                |
| < 2.0   | :x:                |

## Reporting a Vulnerability

We take the security of the Customer Intelligence Dashboard seriously. If you believe you have found a security vulnerability, please report it to us as described below.

### Please Do Not:
- Open a public GitHub issue for security vulnerabilities
- Disclose the vulnerability publicly before it has been addressed

### Please Do:
1. Email details to the project maintainers (if available)
2. Provide detailed information about the vulnerability:
   - Type of issue (e.g., data exposure, code injection, etc.)
   - Full paths of affected source files
   - Location of the affected source code (tag/branch/commit)
   - Step-by-step instructions to reproduce the issue
   - Proof-of-concept or exploit code (if possible)
   - Impact of the issue

### What to Expect:
- Acknowledgment of your report within 48 hours
- Regular updates on the progress of addressing the vulnerability
- Credit for responsible disclosure (if desired)

## Security Best Practices for Users

### Data Protection
1. **Sensitive Data**: Do not upload customer data containing:
   - Personal Identifiable Information (PII)
   - Financial information
   - Health records
   - Any regulated or confidential data

2. **Data Anonymization**: Always anonymize datasets before analysis:
   - Remove customer names
   - Remove contact information
   - Remove any identifying attributes
   - Use customer IDs instead of real identifiers

### Deployment Security
1. **Local Use Only**: This application is designed for local analysis
2. **Public Deployment**: If deploying publicly:
   - Use authentication (Shiny Server Pro or shinyapps.io)
   - Enable HTTPS/SSL
   - Implement proper access controls
   - Regular security audits

### Code Security
1. **Dependencies**: Keep R packages updated
2. **Input Validation**: Be cautious with user-uploaded CSV files
3. **Code Review**: Review any modifications before deployment

## Known Limitations

### Current Security Considerations:
- No built-in authentication (designed for local use)
- No data encryption at rest
- CSV files are loaded in plaintext
- No audit logging

### Recommendations for Production:
- Deploy with Shiny Server Pro for authentication
- Use reverse proxy with SSL/TLS
- Implement database backend instead of CSV
- Add comprehensive logging
- Regular security assessments

## Security Updates

Security patches will be released as soon as possible after a vulnerability is confirmed. Users are encouraged to:
- Star the repository to receive notifications
- Check for updates regularly
- Subscribe to release notifications

## Compliance

This application is a demonstration/analysis tool and is not certified for:
- HIPAA compliance
- PCI-DSS compliance
- GDPR personal data processing
- SOC 2 compliance

Users must ensure their own compliance requirements are met when using this tool.

## Contact

For security concerns, please reach out through:
- GitHub Issues (for non-sensitive matters)
- Direct email to maintainers (for sensitive security issues)

---

*Last updated: November 27, 2025*

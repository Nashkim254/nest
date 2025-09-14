# Security Guidelines

## 🔒 Files That Should NEVER Be Committed

The following sensitive files are automatically excluded by `.gitignore`:

### Android Signing
- `*.keystore` - Android signing keystores
- `*.jks` - Java keystores
- `android/key.properties` - Keystore configuration
- `android/keystore.properties` - Alternative keystore config

### iOS Signing
- `*.p12` - iOS distribution certificates
- `*.mobileprovision` - iOS provisioning profiles
- `ios/Certificates/` - Certificate directory
- `ios/exportOptions.plist` - Export configuration with team info

### API Keys & Secrets
- `google-services.json` - Firebase Android config
- `GoogleService-Info.plist` - Firebase iOS config
- `service-account*.json` - Google service account keys
- `*-key.json` - Any JSON key files

### Environment Files
- `.env.local`, `.env.production`, `.env.staging` - Environment-specific configs
- `*.env.secret` - Secret environment files
- `secrets/` directory - Any secrets folder

## ✅ Safe Practices

### Local Development
- Use environment variables for sensitive data
- Keep keystores and certificates in a secure location outside the repo
- Never hard-code API keys or passwords in source code

### CI/CD Security
- Store sensitive data as GitHub Secrets (encrypted)
- Use base64 encoding for binary files (keystores, certificates)
- Rotate secrets regularly
- Use least-privilege access for service accounts

### Keystore Management
- **Backup your keystores securely** - losing them means you can't update your app
- Use strong passwords for keystores
- Consider using a password manager for keystore passwords
- Document which keystores are used for which apps/environments

## 🚨 If You Accidentally Commit Secrets

If you accidentally commit sensitive data:

1. **Immediately revoke/rotate the compromised credentials**
2. **Remove from git history:**
   ```bash
   git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch path/to/secret/file' --prune-empty --tag-name-filter cat -- --all
   ```
3. **Force push to update remote:**
   ```bash
   git push --force --all
   ```
4. **Notify team members to re-clone the repository**

## 🔍 Security Checklist

Before every commit:
- [ ] No hardcoded API keys or secrets
- [ ] No keystores or certificates
- [ ] No service account JSON files
- [ ] Environment files use placeholder values
- [ ] Sensitive config files are in `.gitignore`

Before production deployment:
- [ ] All production secrets are in secure environment variables
- [ ] Service accounts use minimal required permissions  
- [ ] API keys are restricted to specific domains/IPs when possible
- [ ] Regular secret rotation schedule is in place
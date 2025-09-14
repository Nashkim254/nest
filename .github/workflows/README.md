# GitHub Actions CI/CD Setup

This repository includes automated deployment to internal testing tracks when pushing to the `master` branch.

## Required GitHub Secrets

### Android Secrets (Google Play Internal Testing)

1. **ANDROID_KEYSTORE_BASE64**: Base64 encoded keystore file
   ```bash
   base64 -i nest-release-key.keystore | pbcopy
   ```

2. **KEY_ALIAS**: `nest-key`

3. **KEYSTORE_PASSWORD**: `nestapp2024`

4. **KEY_PASSWORD**: `nestapp2024`

5. **GOOGLE_PLAY_SERVICE_ACCOUNT_JSON**: Service account JSON for Google Play Console
   - Go to Google Play Console > Setup > API access
   - Create/download service account JSON
   - Copy the entire JSON content

### iOS Secrets (TestFlight)

1. **BUILD_CERTIFICATE_BASE64**: Base64 encoded distribution certificate (.p12)
   ```bash
   base64 -i distribution_certificate.p12 | pbcopy
   ```

2. **P12_PASSWORD**: Password for the .p12 certificate

3. **BUILD_PROVISION_PROFILE_BASE64**: Base64 encoded provisioning profile
   ```bash
   base64 -i provisioning_profile.mobileprovision | pbcopy
   ```

4. **KEYCHAIN_PASSWORD**: Any secure password for temporary keychain

5. **APPLE_ID**: Your Apple Developer account email

6. **APPLE_ID_PASSWORD**: App-specific password for your Apple ID
   - Generate at: https://appleid.apple.com/account/manage

7. **APPLE_TEAM_ID**: Your Apple Developer Team ID

## Setup Instructions

### Android Setup

1. **Google Play Console Setup:**
   - Upload your first APK/AAB manually to create the app listing
   - Set up internal testing track
   - Create service account with "Release Manager" role

2. **Add GitHub Secrets:**
   - Go to your GitHub repo > Settings > Secrets and variables > Actions
   - Add all Android secrets listed above

### iOS Setup

1. **Apple Developer Setup:**
   - Create distribution certificate
   - Create App Store provisioning profile
   - Set up your app in App Store Connect

2. **Generate App-Specific Password:**
   - Go to appleid.apple.com
   - Sign in > App-Specific Passwords > Generate

3. **Add GitHub Secrets:**
   - Add all iOS secrets listed above

## Workflow Triggers

Both workflows trigger on:
- Push to `master` branch
- Manual workflow dispatch (GitHub Actions tab)

## Build Numbers

The workflows automatically use the GitHub run number as the build number, ensuring each build has a unique identifier.

## What Happens on Push

1. **Code Quality Checks:**
   - Run Flutter tests
   - Run Flutter analyze
   - Generate required code

2. **Android Workflow:**
   - Build App Bundle
   - Upload to Google Play Internal Testing
   - Store build artifacts

3. **iOS Workflow:**
   - Build iOS Archive
   - Upload to TestFlight
   - Store build artifacts

## Monitoring

- Check the Actions tab in your GitHub repository
- Android builds appear in Google Play Console > Internal testing
- iOS builds appear in App Store Connect > TestFlight

## Troubleshooting

- Ensure all secrets are properly set
- Check that service accounts have correct permissions
- Verify certificates and provisioning profiles are valid
- Review workflow logs for specific error messages
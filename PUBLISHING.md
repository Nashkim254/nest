# Publishing Guide for Nest App

## Pre-Publishing Checklist ✅

### App Configuration
- [x] Updated app version to 1.0.0+1
- [x] Added proper app description
- [x] Updated Android app label to "Nest"
- [x] Configured app icons and launch screens
- [x] Set up proper permissions (Camera, Location, Storage, etc.)

### Build Configuration
- [x] Android release build configuration with ProGuard
- [x] iOS release configuration ready
- [x] Environment-based signing configuration

## Next Steps for Publishing

### 1. Android Play Store
Before publishing to Google Play Store, you need to:

1. **Create Release Keystore**:
   ```bash
   cd android
   ./create-keystore.sh
   ```
   
2. **Set Environment Variables**:
   ```bash
   export KEYSTORE_PATH=/path/to/nest-release-key.keystore
   export KEY_ALIAS=nest-key
   export KEYSTORE_PASSWORD=your_keystore_password
   export KEY_PASSWORD=your_key_password
   ```

3. **Build Release APK**:
   ```bash
   flutter build apk --release
   ```

4. **Create App Bundle** (Recommended):
   ```bash
   flutter build appbundle --release
   ```

5. **Google Play Console Setup**:
   - Create developer account ($25 fee)
   - Create new app listing
   - Upload app bundle
   - Add store listing details, screenshots
   - Set content rating and pricing

### 2. iOS App Store
Before publishing to Apple App Store:

1. **Apple Developer Account** ($99/year)

2. **Code Signing Setup**:
   - Create Distribution Certificate
   - Create App Store Provisioning Profile
   - Configure Xcode signing

3. **Build iOS App**:
   ```bash
   flutter build ios --release
   ```

4. **Archive and Upload**:
   - Open in Xcode
   - Archive the app
   - Upload to App Store Connect

5. **App Store Connect**:
   - Create app listing
   - Add metadata, screenshots
   - Submit for review

## Important Notes

### Security & Compliance
- App uses camera, location, and file permissions
- Implements deep linking with domain verification
- Uses Stripe for payment processing
- WebSocket connections for real-time chat

### Testing Before Release
1. Test on physical devices
2. Verify all permissions work correctly
3. Test payment flows thoroughly
4. Validate deep links work
5. Test QR code scanning functionality

### Store Requirements
- **Privacy Policy**: Required for both stores
- **Terms of Service**: Recommended
- **Screenshots**: Different sizes for various devices
- **App Description**: Clear, compelling description
- **Keywords**: For app store optimization

### Code Quality Issues to Address
- 338 analysis warnings found (consider fixing critical ones)
- Some tests are failing
- Deprecated API usage warnings
- Missing dependencies in pubspec.yaml

## Automated CI/CD with GitHub Actions 🚀

The repository now includes automated deployment workflows that publish to internal testing when you push to `master`:

### Android Workflow
- Builds App Bundle automatically
- Runs tests and code analysis
- Publishes to Google Play Internal Testing
- Triggered on every push to `master`

### iOS Workflow  
- Builds iOS archive
- Runs tests and code analysis
- Uploads to TestFlight for internal testing
- Triggered on every push to `master`

### Setup Required:
1. **Set GitHub Secrets** (see `.github/workflows/README.md`)
2. **Run the helper script:**
   ```bash
   ./scripts/encode-keystore.sh
   ```
3. **Configure Google Play Console & App Store Connect**

### Manual Deployment
If you prefer manual builds:

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter packages pub run build_runner build --delete-conflicting-outputs

# Analysis
flutter analyze
dart format .

# Testing  
flutter test
flutter test --update-goldens

# Building
flutter build apk --release      # Android APK
flutter build appbundle --release # Android App Bundle (recommended)
flutter build ios --release      # iOS
```

## Environment Configuration
The app uses environment variables for API endpoints. Make sure your production `.env` file has the correct API URLs before building for release.

## Final Steps
1. Create keystore using provided script
2. Build and test release versions
3. Create developer accounts
4. Prepare store listings and assets
5. Submit for review

Good luck with your app launch! 🚀
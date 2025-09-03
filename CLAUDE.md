# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Development Commands
- `flutter run` - Run the app on connected device/emulator
- `flutter build apk` - Build Android APK
- `flutter build ios` - Build iOS app
- `flutter clean` - Clean build cache
- `flutter pub get` - Install dependencies
- `flutter pub deps` - Show dependency tree

### Code Generation
- `flutter packages pub run build_runner build` - Generate code (models, routes, locators)
- `flutter packages pub run build_runner build --delete-conflicting-outputs` - Force regenerate code
- `flutter packages pub run build_runner watch` - Watch and auto-generate code changes

### Testing
- `flutter test` - Run unit tests
- `flutter test --update-goldens` - Run tests and update golden files (screenshots stored in `test/golden/`)

### Linting
- `flutter analyze` - Static code analysis
- `dart format .` - Format all Dart files

## Architecture

### Framework & State Management
- **Flutter** with **Stacked Architecture** (MVVM pattern)
- Uses `stacked` package for ViewModels and dependency injection
- Code generation with `stacked_generator` and `build_runner`

### Project Structure
- `lib/app/app.dart` - Main app configuration with Stacked routes, services, dialogs, and bottom sheets
- `lib/main.dart` - App entry point with service locator setup, Stripe configuration, and deep link initialization
- `lib/ui/views/` - UI screens with corresponding ViewModels
- `lib/services/` - Business logic services (API, Auth, WebSocket, etc.)
- `lib/models/` - Data models
- `lib/utils/` - Utilities and configurations

### Key Services
- **ApiService**: HTTP client with Dio
- **AuthService**: Authentication management
- **WebsocketService**: Real-time messaging
- **DeepLinkService**: Handle app links and deep links
- **StripeService**: Payment processing
- **LocationService**: GPS and location features
- **SharedPreferencesService**: Local storage

### Environment Configuration
- Uses `.env` file for environment variables
- `lib/utils/env_config.dart` - API endpoint configuration for development/production
- Development IP address needs manual configuration for physical device testing
- Automatic emulator/simulator detection

### Key Features
- Social media app with event hosting and ticketing
- Real-time chat and messaging
- Payment processing with Stripe
- QR code ticket generation and scanning
- Location-based features
- Video posts and content sharing
- Deep linking support

### Code Generation Requirements
After modifying:
- Routes in `app.dart` → run build_runner
- Model classes with annotations → run build_runner
- Service dependencies → run build_runner

### Development Notes
- Physical device testing requires updating IP address in `env_config.dart`
- Uses golden tests for UI testing
- Custom fonts (Inter family) included
- Material Design with custom theming
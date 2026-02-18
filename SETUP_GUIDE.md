# Complete Setup Guide for BudgetBuddy Flutter App

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Quick Start](#quick-start)
3. [Detailed Setup](#detailed-setup)
4. [Backend Configuration](#backend-configuration)
5. [Platform-Specific Setup](#platform-specific-setup)
6. [Running the App](#running-the-app)
7. [Building for Production](#building-for-production)
8. [Troubleshooting](#troubleshooting)

---

## Prerequisites

### Required Software
- **Flutter SDK** >= 3.0.0
  - Download from: https://docs.flutter.dev/get-started/install
  - Verify installation: `flutter doctor`

- **Dart SDK** >= 3.0.0 (comes with Flutter)

- **IDE** (choose one):
  - Visual Studio Code with Flutter extension
  - Android Studio with Flutter plugin
  - IntelliJ IDEA with Flutter plugin

### Platform-Specific Requirements

#### For Android Development
- Android Studio
- Android SDK (API level 21 or higher)
- JDK 11 or higher

#### For iOS Development (macOS only)
- Xcode 14.0 or higher
- CocoaPods
- iOS Simulator or physical device

---

## Quick Start

### Automated Setup (Recommended)

#### On macOS/Linux:
```bash
chmod +x setup.sh
./setup.sh
```

#### On Windows:
```cmd
setup.bat
```

The setup script will:
1. Check Flutter installation
2. Install all dependencies
3. Create .env file from template
4. Generate necessary code files
5. Clean and prepare the project

### Manual Setup

If you prefer manual setup or the script fails:

```bash
# 1. Install dependencies
flutter pub get

# 2. Copy environment file
cp .env.example .env

# 3. Generate code (optional, if you modify models)
flutter pub run build_runner build --delete-conflicting-outputs

# 4. Clean and rebuild
flutter clean
flutter pub get
```

---

## Detailed Setup

### Step 1: Clone the Repository
```bash
git clone https://github.com/Rsmk27/Budgetbuddy-app.git
cd Budgetbuddy-app
```

### Step 2: Verify Flutter Installation
```bash
flutter doctor -v
```

Fix any issues reported by `flutter doctor` before proceeding.

### Step 3: Install Dependencies
```bash
flutter pub get
```

This will install all packages listed in `pubspec.yaml`.

### Step 4: Configure Environment Variables

Edit the `.env` file with your configuration:

```env
# Choose your backend type
BACKEND_TYPE=rest  # or 'firebase'

# REST API Configuration (if using REST backend)
API_BASE_URL=https://your-api-url.com/api
API_TIMEOUT=30000

# Firebase Configuration (if using Firebase backend)
FIREBASE_API_KEY=your_firebase_api_key
FIREBASE_APP_ID=your_firebase_app_id
FIREBASE_MESSAGING_SENDER_ID=your_messaging_sender_id
FIREBASE_PROJECT_ID=your_firebase_project_id
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_STORAGE_BUCKET=your_project.appspot.com

# Feature Flags
ENABLE_PUSH_NOTIFICATIONS=false
ENABLE_ANALYTICS=true
ENABLE_OFFLINE_MODE=true
```

---

## Backend Configuration

### Option 1: REST API Backend

1. **Set up your backend server** with the required endpoints (see BACKEND_INTEGRATION.md)

2. **Update .env file:**
   ```env
   BACKEND_TYPE=rest
   API_BASE_URL=https://your-backend-api.com/api
   ```

3. **Ensure your API implements:**
   - POST /auth/login
   - POST /auth/register
   - POST /auth/logout
   - POST /auth/reset-password
   - GET/POST/PUT/DELETE /transactions

4. **Test your API** using tools like Postman or cURL before running the app

### Option 2: Firebase Backend

1. **Create a Firebase Project:**
   - Go to https://console.firebase.google.com
   - Click "Add project"
   - Follow the setup wizard

2. **Enable Authentication:**
   - Navigate to Authentication > Sign-in method
   - Enable "Email/Password"

3. **Create Firestore Database:**
   - Navigate to Firestore Database
   - Click "Create database"
   - Choose "Production mode"

4. **Add Firebase to your Flutter app:**

   **For Android:**
   - In Firebase Console, click "Add app" > Android
   - Register app with package name: `com.budgetbuddy.app`
   - Download `google-services.json`
   - Place it in `android/app/`

   **For iOS:**
   - In Firebase Console, click "Add app" > iOS
   - Register app with bundle ID: `com.budgetbuddy.app`
   - Download `GoogleService-Info.plist`
   - Place it in `ios/Runner/`

5. **Update .env file:**
   ```env
   BACKEND_TYPE=firebase
   FIREBASE_API_KEY=AIza...
   FIREBASE_APP_ID=1:123...
   FIREBASE_MESSAGING_SENDER_ID=123...
   FIREBASE_PROJECT_ID=your-project-id
   FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
   FIREBASE_STORAGE_BUCKET=your-project.appspot.com
   ```

---

## Platform-Specific Setup

### Android Setup

1. **Update package name** (if needed):
   Edit `android/app/build.gradle`:
   ```gradle
   defaultConfig {
       applicationId "com.budgetbuddy.app"
       minSdkVersion 21
       targetSdkVersion 33
   }
   ```

2. **Update app name:**
   Edit `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <application
       android:label="BudgetBuddy"
       ...
   ```

3. **Add internet permission:**
   In `android/app/src/main/AndroidManifest.xml`:
   ```xml
   <uses-permission android:name="android.permission.INTERNET"/>
   ```

### iOS Setup

1. **Update bundle identifier** (if needed):
   - Open `ios/Runner.xcworkspace` in Xcode
   - Select Runner > General
   - Change Bundle Identifier to `com.budgetbuddy.app`

2. **Update app name:**
   - In Xcode, select Runner
   - Under General > Identity, set Display Name to `BudgetBuddy`

3. **Add required permissions:**
   Edit `ios/Runner/Info.plist` and add:
   ```xml
   <key>NSAppTransportSecurity</key>
   <dict>
       <key>NSAllowsArbitraryLoads</key>
       <true/>
   </dict>
   ```

---

## Running the App

### Development Mode

```bash
# List available devices
flutter devices

# Run on connected device
flutter run

# Run on specific device
flutter run -d <device_id>

# Run with hot reload (default)
flutter run

# Run in release mode
flutter run --release
```

### Debugging

```bash
# Run with verbose logging
flutter run -v

# Run with debug banner hidden
flutter run --no-debug-banner

# Run with specific flavor (if configured)
flutter run --flavor development
```

### Using IDE

**VS Code:**
1. Open the project
2. Press F5 or click "Run > Start Debugging"
3. Select target device from bottom bar

**Android Studio:**
1. Open the project
2. Select target device from dropdown
3. Click the green play button

---

## Building for Production

### Android

#### APK (for testing/distribution)
```bash
# Build APK
flutter build apk --release

# Output: build/app/outputs/flutter-apk/app-release.apk
```

#### App Bundle (for Google Play Store)
```bash
# Build App Bundle
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

#### Signing the App

1. Create a keystore:
   ```bash
   keytool -genkey -v -keystore ~/budgetbuddy-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias budgetbuddy
   ```

2. Create `android/key.properties`:
   ```properties
   storePassword=<password>
   keyPassword=<password>
   keyAlias=budgetbuddy
   storeFile=<path-to-keystore>
   ```

3. Update `android/app/build.gradle`:
   ```gradle
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }

   android {
       signingConfigs {
           release {
               keyAlias keystoreProperties['keyAlias']
               keyPassword keystoreProperties['keyPassword']
               storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
               storePassword keystoreProperties['storePassword']
           }
       }
       buildTypes {
           release {
               signingConfig signingConfigs.release
           }
       }
   }
   ```

### iOS

```bash
# Build for iOS
flutter build ios --release

# Build and archive (in Xcode)
# 1. Open ios/Runner.xcworkspace in Xcode
# 2. Select "Any iOS Device" as target
# 3. Product > Archive
# 4. Distribute App
```

#### App Store Requirements
1. Update app version in `pubspec.yaml`
2. Update build number in Xcode
3. Configure app icons and launch screen
4. Set up provisioning profiles
5. Archive and upload via Xcode

---

## Troubleshooting

### Common Issues

#### 1. "Unable to load asset: .env"
**Solution:**
```bash
cp .env.example .env
flutter clean
flutter pub get
```

#### 2. "MissingPluginException"
**Solution:**
```bash
flutter clean
flutter pub get
# For iOS
cd ios && pod install && cd ..
# Then restart the app
```

#### 3. "Build failed" on Android
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
flutter build apk
```

#### 4. "CocoaPods not installed" (iOS)
**Solution:**
```bash
sudo gem install cocoapods
cd ios
pod install
cd ..
```

#### 5. "DioError: Connection refused"
**Solution:**
- Check if backend server is running
- Update API_BASE_URL in .env
- Use `http://10.0.2.2:3000/api` for Android emulator (instead of localhost)
- Use your computer's IP for physical devices

#### 6. Code generation errors
**Solution:**
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Getting Help

1. **Check Documentation:**
   - README.md
   - ARCHITECTURE.md
   - BACKEND_INTEGRATION.md

2. **Flutter Doctor:**
   ```bash
   flutter doctor -v
   ```

3. **Verbose Logging:**
   ```bash
   flutter run -v
   ```

4. **Clear Cache:**
   ```bash
   flutter clean
   flutter pub cache repair
   flutter pub get
   ```

### Performance Tips

1. **Use Release Mode** for testing performance
2. **Enable Skia** for better graphics (iOS)
3. **Profile your app** using Flutter DevTools
4. **Optimize images** and assets
5. **Use const constructors** where possible

---

## Next Steps

After successful setup:

1. ✅ Verify .env configuration
2. ✅ Test authentication with your backend
3. ✅ Add test transactions
4. ✅ Customize theme (lib/core/theme/app_theme.dart)
5. ✅ Configure app icons and splash screen
6. ✅ Set up CI/CD (optional)
7. ✅ Deploy to stores (optional)

---

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Riverpod Documentation](https://riverpod.dev/)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Material Design 3](https://m3.material.io/)

---

**Happy Developing! 🚀**

If you encounter any issues not covered here, please open an issue on GitHub.

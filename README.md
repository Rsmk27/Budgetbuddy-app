# BudgetBuddy Flutter App

A modern, full-featured budget management mobile application built with Flutter that integrates with backend services.

## 🌟 Features

### Authentication
- ✅ Email/Password login and registration
- ✅ Password reset functionality
- ✅ Persistent user sessions with secure storage
- ✅ JWT token-based authentication

### Dashboard
- ✅ Total balance overview
- ✅ Monthly income and expense summary
- ✅ Recent transactions list
- ✅ Quick access to add transactions

### Transaction Management
- ✅ Add new income/expense transactions
- ✅ Edit existing transactions
- ✅ Delete transactions
- ✅ Filter transactions by type (income/expense/all)
- ✅ Category-based organization
- ✅ Date selection for transactions
- ✅ Notes/descriptions support

### Analytics
- ✅ Monthly income vs expense charts
- ✅ Category-wise spending breakdown
- ✅ Visual data representation with charts

### Profile & Settings
- ✅ User profile information
- ✅ Dark/Light theme toggle
- ✅ Logout functionality
- ✅ App version and info

### Data Management
- ✅ Offline data caching with Hive
- ✅ Automatic data sync
- ✅ Network error handling
- ✅ Graceful fallback to cached data

## 🏗️ Architecture

This app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── core/
│   ├── config/           # App configuration (environment variables)
│   ├── constants/        # App-wide constants
│   ├── routes/           # Navigation and routing
│   ├── theme/            # Material 3 theme configuration
│   └── utils/            # Helper functions and utilities
├── services/
│   ├── auth/             # Authentication service
│   ├── api/              # API client and services
│   └── storage/          # Local and secure storage
├── models/               # Data models
├── repositories/         # Data access layer
├── features/             # Feature-based modules
│   ├── auth/
│   │   └── presentation/
│   │       └── screens/
│   ├── dashboard/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   ├── transactions/
│   │   └── presentation/
│   │       ├── screens/
│   │       └── widgets/
│   ├── analytics/
│   └── profile/
└── main.dart             # App entry point
```

## 🔧 Backend Integration

The app supports **two backend types**, configurable via environment variables:

### 1. REST API Backend
- Token-based authentication
- RESTful endpoints for all operations
- Dio HTTP client with interceptors
- Automatic token injection in requests

### 2. Firebase Backend
- Firebase Authentication
- Cloud Firestore for data storage
- Real-time data synchronization
- Firebase Cloud Messaging (optional)

## 📦 Dependencies

### State Management
- `flutter_riverpod` - Modern reactive state management

### UI/UX
- `google_fonts` - Custom typography
- `fl_chart` - Beautiful charts and graphs
- `go_router` - Declarative routing

### Storage
- `hive` - Fast local NoSQL database
- `flutter_secure_storage` - Secure token storage
- `shared_preferences` - Simple key-value storage

### Networking
- `dio` - Powerful HTTP client
- `retrofit` - Type-safe REST client

### Utilities
- `intl` - Internationalization and date formatting
- `logger` - Advanced logging
- `uuid` - Unique ID generation

## 🚀 Setup Instructions

### Prerequisites
- Flutter SDK >= 3.0.0
- Dart SDK >= 3.0.0
- Android Studio / Xcode (for mobile development)
- A backend server or Firebase project

### Installation Steps

1. **Clone the repository**
   ```bash
   git clone https://github.com/Rsmk27/Budgetbuddy-app.git
   cd Budgetbuddy-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure environment variables**
   
   Copy the example environment file:
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` with your configuration:
   ```env
   # Backend Configuration
   BACKEND_TYPE=rest  # or 'firebase'
   
   # REST API Configuration
   API_BASE_URL=https://your-api-url.com/api
   API_TIMEOUT=30000
   
   # Firebase Configuration (if using Firebase)
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

4. **Generate code (optional, if you modify models)**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

5. **Run the app**
   ```bash
   # Development
   flutter run
   
   # Release mode
   flutter run --release
   ```

### Building for Production

#### Android APK
```bash
flutter build apk --release
```
Output: `build/app/outputs/flutter-apk/app-release.apk`

#### Android App Bundle (for Play Store)
```bash
flutter build appbundle --release
```
Output: `build/app/outputs/bundle/release/app-release.aab`

#### iOS
```bash
flutter build ios --release
```

## 🔌 Backend Integration Guide

### REST API Backend

Your backend should implement the following endpoints:

#### Authentication
```
POST /api/auth/login
Body: { "email": "user@example.com", "password": "password" }
Response: { "token": "jwt_token", "user": { ... } }

POST /api/auth/register
Body: { "name": "John Doe", "email": "user@example.com", "password": "password" }
Response: { "token": "jwt_token", "user": { ... } }

POST /api/auth/logout
Headers: { "Authorization": "Bearer jwt_token" }

POST /api/auth/reset-password
Body: { "email": "user@example.com" }
```

#### Transactions
```
GET /api/transactions
Headers: { "Authorization": "Bearer jwt_token" }
Query: ?limit=20&offset=0&type=expense&category=Food

POST /api/transactions
Headers: { "Authorization": "Bearer jwt_token" }
Body: { "title": "...", "amount": 100, "type": "expense", ... }

PUT /api/transactions/:id
Headers: { "Authorization": "Bearer jwt_token" }
Body: { "title": "...", "amount": 100, ... }

DELETE /api/transactions/:id
Headers: { "Authorization": "Bearer jwt_token" }
```

### Data Models

#### User
```json
{
  "id": "string",
  "email": "string",
  "name": "string",
  "photoUrl": "string?",
  "createdAt": "ISO8601 datetime",
  "updatedAt": "ISO8601 datetime?"
}
```

#### Transaction
```json
{
  "id": "string",
  "userId": "string",
  "title": "string",
  "description": "string?",
  "amount": "number",
  "type": "income | expense",
  "category": "string",
  "date": "ISO8601 datetime",
  "createdAt": "ISO8601 datetime",
  "updatedAt": "ISO8601 datetime?"
}
```

### Firebase Backend

If using Firebase:

1. **Create a Firebase project** at https://console.firebase.google.com

2. **Enable Authentication**
   - Go to Authentication > Sign-in method
   - Enable Email/Password

3. **Create Firestore Database**
   - Go to Firestore Database
   - Create database in production mode
   - Set up the following collections:
     - `users` - User profiles
     - `transactions` - User transactions
     - `categories` - Transaction categories

4. **Security Rules** (example)
   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       match /users/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
       match /transactions/{transactionId} {
         allow read, write: if request.auth != null && 
           resource.data.userId == request.auth.uid;
       }
     }
   }
   ```

5. **Download configuration files**
   - Android: `google-services.json` → `android/app/`
   - iOS: `GoogleService-Info.plist` → `ios/Runner/`

## 🎨 Customization

### Theme
Edit `lib/core/theme/app_theme.dart` to customize:
- Colors
- Typography
- Component styles

### Categories
Edit `lib/core/constants/app_constants.dart` to modify:
- Default expense categories
- Default income categories

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# View coverage report
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For issues and questions:
- Open an issue on GitHub

## 🗺️ Roadmap

- [ ] Push notifications
- [ ] Email alerts for budget limits
- [ ] Export transactions as CSV/PDF
- [ ] Biometric authentication
- [ ] Multi-currency support
- [ ] Budget goals and alerts
- [ ] Recurring transactions
- [ ] Cloud backup and sync
- [ ] Family/shared accounts

---

Built with ❤️ using Flutter
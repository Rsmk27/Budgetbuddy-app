# BudgetBuddy Architecture Documentation

## Overview

BudgetBuddy follows Clean Architecture principles combined with feature-based modularization. This ensures:
- Separation of concerns
- Testability
- Maintainability
- Scalability

## Architecture Layers

### 1. Core Layer (`lib/core/`)

Contains cross-cutting concerns and shared resources:

#### Configuration (`config/`)
- **app_config.dart**: Environment-based configuration
  - Backend type selection (Firebase/REST)
  - API endpoints
  - Feature flags
  - Firebase configuration

#### Constants (`constants/`)
- **app_constants.dart**: Application-wide constants
  - API endpoints
  - Storage keys
  - Default categories
  - Validation rules
  - Date formats

#### Theme (`theme/`)
- **app_theme.dart**: Material 3 theme configuration
  - Color schemes (light/dark)
  - Typography
  - Component themes
  - Custom widgets styling

#### Routes (`routes/`)
- **app_router.dart**: Navigation configuration using GoRouter
  - Route definitions
  - Navigation guards
  - Deep linking support
  - Theme mode provider

#### Utils (`utils/`)
- **helpers.dart**: Utility functions
  - Date/time formatting
  - Currency formatting
  - Validation helpers

### 2. Services Layer (`lib/services/`)

Handles external dependencies and infrastructure:

#### Authentication (`auth/`)
- **auth_service.dart**: Authentication logic
  - REST API authentication
  - Firebase authentication (placeholder)
  - Factory pattern for backend selection

#### API (`api/`)
- **api_client.dart**: HTTP client wrapper
  - Dio configuration
  - Request/response interceptors
  - Error handling
  - Token injection

- **transaction_service.dart**: Transaction API operations
  - CRUD operations
  - Caching logic
  - Query parameters handling

#### Storage (`storage/`)
- **secure_storage_service.dart**: Encrypted storage
  - Token management
  - User data storage
  - Credentials storage

- **local_storage_service.dart**: Local database
  - Hive initialization
  - Box management
  - Offline caching

### 3. Models Layer (`lib/models/`)

Data models and entities:

- **user_model.dart**: User entity
- **transaction_model.dart**: Transaction entity with type enum
- **category_model.dart**: Category entity
- **dashboard_summary.dart**: Dashboard aggregated data

All models include:
- JSON serialization/deserialization
- Equatable for value comparison
- copyWith methods for immutability

### 4. Repository Layer (`lib/repositories/`)

Data access abstraction:

#### auth_repository.dart
- Abstracts authentication service
- Manages auth state
- Provides Riverpod state notifier

#### transaction_repository.dart
- Abstracts transaction service
- Handles offline fallback
- Provides data providers

### 5. Features Layer (`lib/features/`)

Feature-based modules following vertical slice architecture:

#### Auth Feature (`features/auth/`)
```
auth/
└── presentation/
    └── screens/
        ├── login_screen.dart
        ├── register_screen.dart
        └── forgot_password_screen.dart
```

#### Dashboard Feature (`features/dashboard/`)
```
dashboard/
└── presentation/
    ├── screens/
    │   ├── main_screen.dart
    │   ├── dashboard_tab.dart
    │   ├── transactions_tab.dart
    │   ├── analytics_tab.dart
    │   └── profile_tab.dart
    └── widgets/
        ├── balance_card.dart
        └── recent_transactions_list.dart
```

#### Transactions Feature (`features/transactions/`)
```
transactions/
└── presentation/
    ├── screens/
    │   ├── add_transaction_screen.dart
    │   └── edit_transaction_screen.dart
    └── widgets/
        └── transaction_filter_bar.dart
```

## State Management

### Riverpod Architecture

The app uses Riverpod for state management with the following patterns:

#### Providers
- **Provider**: Immutable dependencies (services, repositories)
- **StateNotifierProvider**: Mutable state (auth state)
- **FutureProvider**: Async data (transactions)
- **StateProvider**: Simple state (theme mode)

#### Example Flow
```
UI Layer (ConsumerWidget)
    ↓ watches
Provider (transactionsProvider)
    ↓ uses
Repository (TransactionRepository)
    ↓ uses
Service (TransactionService)
    ↓ calls
API Client (Dio)
```

## Data Flow

### Authentication Flow
```
1. User enters credentials
2. LoginScreen calls authStateProvider.notifier.login()
3. AuthNotifier calls AuthRepository.login()
4. AuthRepository calls AuthService.login()
5. AuthService calls API/Firebase
6. Token stored in SecureStorage
7. User data cached
8. Auth state updated
9. UI redirects to Dashboard
```

### Transaction CRUD Flow
```
1. User creates transaction
2. AddTransactionScreen calls repository.createTransaction()
3. Repository calls service.createTransaction()
4. Service sends POST request
5. Response cached locally (Hive)
6. Provider refreshed
7. UI updated automatically
```

### Offline-First Flow
```
1. User has no internet
2. Repository catches network error
3. Returns cached data from Hive
4. UI shows cached data
5. Background sync when online (future enhancement)
```

## Backend Integration Patterns

### REST API Pattern
```dart
// 1. Configure in .env
BACKEND_TYPE=rest
API_BASE_URL=https://api.example.com

// 2. API Client auto-injects token
class ApiClient {
  _setupInterceptors() {
    // Add Bearer token to all requests
  }
}

// 3. Service makes requests
class TransactionService {
  Future<Transaction> createTransaction() {
    return _apiClient.post('/transactions', data: {...});
  }
}
```

### Firebase Pattern (Future Implementation)
```dart
// 1. Configure in .env
BACKEND_TYPE=firebase
FIREBASE_PROJECT_ID=...

// 2. Service uses Firebase SDK
class FirebaseAuthService implements AuthService {
  Future<User> login() {
    return _firebaseAuth.signInWithEmailAndPassword();
  }
}
```

## Error Handling

### Layered Error Handling
1. **Service Layer**: Catches HTTP/Firebase errors
2. **Repository Layer**: Handles offline fallback
3. **UI Layer**: Shows user-friendly messages

### Example
```dart
try {
  await service.getTransactions();
} catch (e) {
  // Fallback to cache
  return await getCachedTransactions();
}
```

## Security Considerations

1. **Token Storage**: Uses FlutterSecureStorage
2. **API Communication**: HTTPS only
3. **Input Validation**: Client-side validation
4. **Auth Guards**: Route-level protection
5. **Error Messages**: No sensitive info exposed

## Testing Strategy

### Unit Tests
- Models: Serialization/deserialization
- Services: API calls with mocks
- Repositories: Data access logic
- Validators: Input validation

### Widget Tests
- Screens: UI rendering
- Widgets: Interactions
- Forms: Validation

### Integration Tests
- End-to-end flows
- Navigation
- State management

## Future Enhancements

1. **Domain Layer**: Add business logic layer
2. **Use Cases**: Implement interactors
3. **Repository Interfaces**: Abstract data sources
4. **Dependency Injection**: Use Riverpod DI fully
5. **Error Handling**: Custom exception hierarchy
6. **Logging**: Structured logging system

## Conventions

### Naming
- Files: `snake_case.dart`
- Classes: `PascalCase`
- Variables: `camelCase`
- Constants: `UPPER_SNAKE_CASE`

### File Organization
- One class per file
- Organize imports (dart, flutter, packages, relative)
- Group related files in folders

### Code Style
- Use const constructors
- Prefer final over var
- Use named parameters
- Document public APIs

## Scalability

The architecture supports:
- Adding new features without affecting existing ones
- Swapping backend implementations
- Adding new data sources
- Implementing caching strategies
- Multi-platform support (Web, Desktop)

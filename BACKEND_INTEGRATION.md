# Backend Integration Guide for BudgetBuddy

This guide helps backend developers integrate their API with the BudgetBuddy Flutter app.

## Table of Contents
1. [REST API Integration](#rest-api-integration)
2. [Firebase Integration](#firebase-integration)
3. [API Specifications](#api-specifications)
4. [Data Models](#data-models)
5. [Authentication Flow](#authentication-flow)
6. [Error Handling](#error-handling)

---

## REST API Integration

### Configuration

1. Set backend type in `.env`:
   ```env
   BACKEND_TYPE=rest
   API_BASE_URL=https://your-api.com/api
   API_TIMEOUT=30000
   ```

2. Ensure your API supports:
   - JSON request/response
   - JWT token authentication
   - CORS (for web version)

### Required Endpoints

#### 1. Authentication Endpoints

##### Login
```http
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

**Success Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user_123",
    "email": "user@example.com",
    "name": "John Doe",
    "photoUrl": "https://example.com/photo.jpg",
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  }
}
```

**Error Response (401 Unauthorized):**
```json
{
  "error": "Invalid credentials"
}
```

##### Register
```http
POST /auth/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123"
}
```

**Success Response (201 Created):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "user_123",
    "email": "user@example.com",
    "name": "John Doe",
    "photoUrl": null,
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": null
  }
}
```

##### Logout
```http
POST /auth/logout
Authorization: Bearer {token}
```

**Success Response (200 OK):**
```json
{
  "message": "Logged out successfully"
}
```

##### Password Reset
```http
POST /auth/reset-password
Content-Type: application/json

{
  "email": "user@example.com"
}
```

**Success Response (200 OK):**
```json
{
  "message": "Password reset email sent"
}
```

#### 2. Transaction Endpoints

##### Get Transactions (with filters)
```http
GET /transactions?limit=20&offset=0&type=expense&category=Food&startDate=2024-01-01&endDate=2024-01-31
Authorization: Bearer {token}
```

**Query Parameters:**
- `limit` (optional, default: 20): Number of results
- `offset` (optional, default: 0): Pagination offset
- `type` (optional): Filter by 'income' or 'expense'
- `category` (optional): Filter by category name
- `startDate` (optional): ISO8601 date string
- `endDate` (optional): ISO8601 date string

**Success Response (200 OK):**
```json
{
  "transactions": [
    {
      "id": "txn_123",
      "userId": "user_123",
      "title": "Grocery Shopping",
      "description": "Weekly groceries",
      "amount": 125.50,
      "type": "expense",
      "category": "Food & Dining",
      "date": "2024-01-15T00:00:00Z",
      "createdAt": "2024-01-15T10:30:00Z",
      "updatedAt": null
    }
  ],
  "total": 150,
  "limit": 20,
  "offset": 0
}
```

##### Get Single Transaction
```http
GET /transactions/{id}
Authorization: Bearer {token}
```

**Success Response (200 OK):**
```json
{
  "id": "txn_123",
  "userId": "user_123",
  "title": "Grocery Shopping",
  "description": "Weekly groceries",
  "amount": 125.50,
  "type": "expense",
  "category": "Food & Dining",
  "date": "2024-01-15T00:00:00Z",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": null
}
```

##### Create Transaction
```http
POST /transactions
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "Salary",
  "description": "Monthly salary",
  "amount": 5000.00,
  "type": "income",
  "category": "Salary",
  "date": "2024-01-01T00:00:00Z"
}
```

**Success Response (201 Created):**
```json
{
  "id": "txn_456",
  "userId": "user_123",
  "title": "Salary",
  "description": "Monthly salary",
  "amount": 5000.00,
  "type": "income",
  "category": "Salary",
  "date": "2024-01-01T00:00:00Z",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": null
}
```

##### Update Transaction
```http
PUT /transactions/{id}
Authorization: Bearer {token}
Content-Type: application/json

{
  "title": "Updated Title",
  "description": "Updated description",
  "amount": 150.00,
  "type": "expense",
  "category": "Shopping",
  "date": "2024-01-16T00:00:00Z"
}
```

**Success Response (200 OK):**
```json
{
  "id": "txn_123",
  "userId": "user_123",
  "title": "Updated Title",
  "description": "Updated description",
  "amount": 150.00,
  "type": "expense",
  "category": "Shopping",
  "date": "2024-01-16T00:00:00Z",
  "createdAt": "2024-01-15T10:30:00Z",
  "updatedAt": "2024-01-16T14:20:00Z"
}
```

##### Delete Transaction
```http
DELETE /transactions/{id}
Authorization: Bearer {token}
```

**Success Response (200 OK):**
```json
{
  "message": "Transaction deleted successfully"
}
```

#### 3. User Endpoint (Optional)

##### Get User Profile
```http
GET /user
Authorization: Bearer {token}
```

**Success Response (200 OK):**
```json
{
  "id": "user_123",
  "email": "user@example.com",
  "name": "John Doe",
  "photoUrl": "https://example.com/photo.jpg",
  "createdAt": "2024-01-01T00:00:00Z",
  "updatedAt": "2024-01-15T10:30:00Z"
}
```

### Authentication

The app uses **Bearer Token** authentication:

1. After login/register, your API returns a JWT token
2. App stores token securely using FlutterSecureStorage
3. All subsequent requests include: `Authorization: Bearer {token}`
4. Implement token expiry and refresh if needed

### Security Requirements

1. **HTTPS Only**: All API calls must use HTTPS
2. **Token Validation**: Validate JWT on every authenticated request
3. **User Authorization**: Ensure users can only access their own data
4. **Input Validation**: Validate all inputs on the backend
5. **Rate Limiting**: Implement rate limiting to prevent abuse

### CORS Configuration

For web version, configure CORS headers:

```javascript
// Example (Express.js)
app.use(cors({
  origin: ['https://your-app.com', 'http://localhost:3000'],
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
```

---

## Firebase Integration

### Setup Steps

1. **Create Firebase Project**
   - Go to https://console.firebase.google.com
   - Create new project
   - Enable Google Analytics (optional)

2. **Enable Authentication**
   ```
   Authentication → Sign-in method → Email/Password → Enable
   ```

3. **Create Firestore Database**
   ```
   Firestore Database → Create database → Production mode
   ```

4. **Set Up Collections**

   **users collection:**
   ```
   users/{userId}
   - email: string
   - name: string
   - photoUrl: string | null
   - createdAt: timestamp
   - updatedAt: timestamp | null
   ```

   **transactions collection:**
   ```
   transactions/{transactionId}
   - userId: string
   - title: string
   - description: string | null
   - amount: number
   - type: string ('income' | 'expense')
   - category: string
   - date: timestamp
   - createdAt: timestamp
   - updatedAt: timestamp | null
   ```

5. **Configure Security Rules**

   ```javascript
   rules_version = '2';
   service cloud.firestore {
     match /databases/{database}/documents {
       // User document rules
       match /users/{userId} {
         allow read, write: if request.auth != null && request.auth.uid == userId;
       }
       
       // Transaction rules
       match /transactions/{transactionId} {
         allow read, write: if request.auth != null && 
           resource.data.userId == request.auth.uid;
         allow create: if request.auth != null && 
           request.resource.data.userId == request.auth.uid;
       }
     }
   }
   ```

6. **Download Config Files**
   - **Android**: Download `google-services.json` → place in `android/app/`
   - **iOS**: Download `GoogleService-Info.plist` → place in `ios/Runner/`

7. **Update .env**
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

## Data Models

### User Model
```typescript
interface User {
  id: string;
  email: string;
  name: string;
  photoUrl?: string;
  createdAt: string; // ISO8601
  updatedAt?: string; // ISO8601
}
```

### Transaction Model
```typescript
interface Transaction {
  id: string;
  userId: string;
  title: string;
  description?: string;
  amount: number;
  type: 'income' | 'expense';
  category: string;
  date: string; // ISO8601
  createdAt: string; // ISO8601
  updatedAt?: string; // ISO8601
}
```

### Category Model
```typescript
interface Category {
  id: string;
  name: string;
  type: 'income' | 'expense';
  icon?: string;
  color?: string;
  isDefault: boolean;
}
```

---

## Authentication Flow

```
1. User enters email/password
   ↓
2. App → POST /auth/login
   ↓
3. Backend validates credentials
   ↓
4. Backend generates JWT token
   ↓
5. Backend ← Returns { token, user }
   ↓
6. App stores token securely
   ↓
7. App stores user data
   ↓
8. App redirects to dashboard
   ↓
9. Future requests include: Authorization: Bearer {token}
```

---

## Error Handling

### Standard Error Response Format

```json
{
  "error": "Error message",
  "code": "ERROR_CODE",
  "details": {}
}
```

### HTTP Status Codes

- `200 OK`: Successful GET, PUT, DELETE
- `201 Created`: Successful POST
- `400 Bad Request`: Invalid input
- `401 Unauthorized`: Missing or invalid token
- `403 Forbidden`: Valid token but insufficient permissions
- `404 Not Found`: Resource not found
- `500 Internal Server Error`: Server error

### Example Error Responses

**Invalid Credentials:**
```json
{
  "error": "Invalid email or password",
  "code": "INVALID_CREDENTIALS"
}
```

**Validation Error:**
```json
{
  "error": "Validation failed",
  "code": "VALIDATION_ERROR",
  "details": {
    "email": "Invalid email format",
    "password": "Password must be at least 6 characters"
  }
}
```

**Unauthorized:**
```json
{
  "error": "Unauthorized. Please login again.",
  "code": "UNAUTHORIZED"
}
```

---

## Testing Your Integration

### Using cURL

```bash
# Login
curl -X POST https://your-api.com/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@example.com","password":"password123"}'

# Get transactions
curl -X GET https://your-api.com/api/transactions \
  -H "Authorization: Bearer YOUR_TOKEN"

# Create transaction
curl -X POST https://your-api.com/api/transactions \
  -H "Authorization: Bearer YOUR_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Test",
    "amount": 100,
    "type": "expense",
    "category": "Food",
    "date": "2024-01-15T00:00:00Z"
  }'
```

### Using Postman

Import this collection to test your API: [Link to Postman collection]

---

## Support

For questions or issues:
- Create an issue on GitHub
- Email: dev@budgetbuddy.com

---

## Checklist for Backend Developers

- [ ] All endpoints implemented
- [ ] JWT authentication working
- [ ] CORS configured for web
- [ ] HTTPS enabled
- [ ] Input validation implemented
- [ ] Error responses standardized
- [ ] Rate limiting configured
- [ ] Database migrations completed
- [ ] Security rules configured (Firebase)
- [ ] API documentation updated
- [ ] Integration tested with Flutter app

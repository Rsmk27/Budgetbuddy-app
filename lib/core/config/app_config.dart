import 'package:flutter_dotenv/flutter_dotenv.dart';

enum BackendType { firebase, rest }

class AppConfig {
  static BackendType get backendType {
    final type = dotenv.env['BACKEND_TYPE'] ?? 'rest';
    return type.toLowerCase() == 'firebase' 
        ? BackendType.firebase 
        : BackendType.rest;
  }
  
  // REST API Configuration
  static String get apiBaseUrl => 
      dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000/api';
  
  static int get apiTimeout => 
      int.tryParse(dotenv.env['API_TIMEOUT'] ?? '30000') ?? 30000;
  
  // Firebase Configuration
  static String get firebaseApiKey => 
      dotenv.env['FIREBASE_API_KEY'] ?? '';
  
  static String get firebaseAppId => 
      dotenv.env['FIREBASE_APP_ID'] ?? '';
  
  static String get firebaseMessagingSenderId => 
      dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
  
  static String get firebaseProjectId => 
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
  
  static String get firebaseAuthDomain => 
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';
  
  static String get firebaseStorageBucket => 
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
  
  // Feature Flags
  static bool get enablePushNotifications => 
      dotenv.env['ENABLE_PUSH_NOTIFICATIONS']?.toLowerCase() == 'true';
  
  static bool get enableAnalytics => 
      dotenv.env['ENABLE_ANALYTICS']?.toLowerCase() == 'true';
  
  static bool get enableOfflineMode => 
      dotenv.env['ENABLE_OFFLINE_MODE']?.toLowerCase() != 'false';
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/constants/app_constants.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();
  
  // Token Management
  static Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.tokenKey, value: token);
  }
  
  static Future<String?> getToken() async {
    return await _storage.read(key: AppConstants.tokenKey);
  }
  
  static Future<void> deleteToken() async {
    await _storage.delete(key: AppConstants.tokenKey);
  }
  
  // User Data
  static Future<void> saveUserData(String userData) async {
    await _storage.write(key: AppConstants.userKey, value: userData);
  }
  
  static Future<String?> getUserData() async {
    return await _storage.read(key: AppConstants.userKey);
  }
  
  static Future<void> deleteUserData() async {
    await _storage.delete(key: AppConstants.userKey);
  }
  
  // Clear All
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}

class PreferencesService {
  static SharedPreferences? _prefs;
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  static SharedPreferences get instance {
    if (_prefs == null) {
      throw Exception('PreferencesService not initialized');
    }
    return _prefs!;
  }
  
  // Theme
  static Future<void> saveThemeMode(String mode) async {
    await instance.setString(AppConstants.themeKey, mode);
  }
  
  static String? getThemeMode() {
    return instance.getString(AppConstants.themeKey);
  }
  
  // Onboarding
  static Future<void> setOnboardingCompleted(bool completed) async {
    await instance.setBool(AppConstants.onboardingKey, completed);
  }
  
  static bool getOnboardingCompleted() {
    return instance.getBool(AppConstants.onboardingKey) ?? false;
  }
}

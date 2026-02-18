import 'dart:convert';
import '../../core/config/app_config.dart';
import '../../core/constants/app_constants.dart';
import '../../models/user_model.dart';
import '../api/api_client.dart';
import '../storage/secure_storage_service.dart';
import '../storage/local_storage_service.dart';

abstract class AuthService {
  Future<User> login(String email, String password);
  Future<User> register(String name, String email, String password);
  Future<void> logout();
  Future<void> resetPassword(String email);
  Future<User?> getCurrentUser();
  Future<bool> isAuthenticated();
}

class RestAuthService implements AuthService {
  final ApiClient _apiClient;
  
  RestAuthService(this._apiClient);
  
  @override
  Future<User> login(String email, String password) async {
    final response = await _apiClient.post(
      AppConstants.loginEndpoint,
      data: {
        'email': email,
        'password': password,
      },
    );
    
    final token = response.data['token'] as String;
    final userData = response.data['user'] as Map<String, dynamic>;
    
    await SecureStorageService.saveToken(token);
    await SecureStorageService.saveUserData(jsonEncode(userData));
    
    return User.fromJson(userData);
  }
  
  @override
  Future<User> register(String name, String email, String password) async {
    final response = await _apiClient.post(
      AppConstants.registerEndpoint,
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    
    final token = response.data['token'] as String;
    final userData = response.data['user'] as Map<String, dynamic>;
    
    await SecureStorageService.saveToken(token);
    await SecureStorageService.saveUserData(jsonEncode(userData));
    
    return User.fromJson(userData);
  }
  
  @override
  Future<void> logout() async {
    try {
      await _apiClient.post(AppConstants.logoutEndpoint);
    } catch (e) {
      // Continue with local logout even if API call fails
    }
    
    await SecureStorageService.clearAll();
    await LocalStorageService.clearAll();
  }
  
  @override
  Future<void> resetPassword(String email) async {
    await _apiClient.post(
      AppConstants.resetPasswordEndpoint,
      data: {'email': email},
    );
  }
  
  @override
  Future<User?> getCurrentUser() async {
    final userData = await SecureStorageService.getUserData();
    if (userData == null) return null;
    
    try {
      return User.fromJson(jsonDecode(userData));
    } catch (e) {
      return null;
    }
  }
  
  @override
  Future<bool> isAuthenticated() async {
    final token = await SecureStorageService.getToken();
    return token != null;
  }
}

class FirebaseAuthService implements AuthService {
  // Firebase implementation would go here
  // Using Firebase Auth SDK
  
  @override
  Future<User> login(String email, String password) async {
    // TODO: Implement Firebase login
    throw UnimplementedError('Firebase auth not yet implemented');
  }
  
  @override
  Future<User> register(String name, String email, String password) async {
    // TODO: Implement Firebase register
    throw UnimplementedError('Firebase auth not yet implemented');
  }
  
  @override
  Future<void> logout() async {
    // TODO: Implement Firebase logout
    throw UnimplementedError('Firebase auth not yet implemented');
  }
  
  @override
  Future<void> resetPassword(String email) async {
    // TODO: Implement Firebase password reset
    throw UnimplementedError('Firebase auth not yet implemented');
  }
  
  @override
  Future<User?> getCurrentUser() async {
    // TODO: Implement Firebase get current user
    throw UnimplementedError('Firebase auth not yet implemented');
  }
  
  @override
  Future<bool> isAuthenticated() async {
    // TODO: Implement Firebase auth check
    throw UnimplementedError('Firebase auth not yet implemented');
  }
}

// Factory to get the appropriate auth service
AuthService getAuthService(ApiClient apiClient) {
  if (AppConfig.backendType == BackendType.firebase) {
    return FirebaseAuthService();
  } else {
    return RestAuthService(apiClient);
  }
}

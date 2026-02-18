import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth/auth_service.dart';
import '../services/api/api_client.dart';

class AuthRepository {
  final AuthService _authService;
  
  AuthRepository(this._authService);
  
  Future<User> login(String email, String password) async {
    return await _authService.login(email, password);
  }
  
  Future<User> register(String name, String email, String password) async {
    return await _authService.register(name, email, password);
  }
  
  Future<void> logout() async {
    await _authService.logout();
  }
  
  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }
  
  Future<User?> getCurrentUser() async {
    return await _authService.getCurrentUser();
  }
  
  Future<bool> isAuthenticated() async {
    return await _authService.isAuthenticated();
  }
}

// Providers
final apiClientProvider = Provider<ApiClient>((ref) => ApiClient());

final authServiceProvider = Provider<AuthService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return getAuthService(apiClient);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthRepository(authService);
});

// Auth state provider
final authStateProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthRepository _repository;
  
  AuthNotifier(this._repository) : super(const AsyncValue.loading()) {
    _checkAuth();
  }
  
  Future<void> _checkAuth() async {
    try {
      final user = await _repository.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.login(email, password);
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> register(String name, String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _repository.register(name, email, password);
      state = AsyncValue.data(user);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> logout() async {
    try {
      await _repository.logout();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
  
  Future<void> resetPassword(String email) async {
    await _repository.resetPassword(email);
  }
}

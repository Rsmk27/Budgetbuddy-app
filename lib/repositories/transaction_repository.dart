import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction_model.dart';
import '../services/api/transaction_service.dart';
import 'auth_repository.dart';

class TransactionRepository {
  final TransactionService _transactionService;
  
  TransactionRepository(this._transactionService);
  
  Future<List<Transaction>> getTransactions({
    int? limit,
    int? offset,
    String? type,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      return await _transactionService.getTransactions(
        limit: limit,
        offset: offset,
        type: type,
        category: category,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      // If network fails, return cached data
      return await _transactionService.getCachedTransactions();
    }
  }
  
  Future<Transaction> getTransaction(String id) async {
    return await _transactionService.getTransaction(id);
  }
  
  Future<Transaction> createTransaction(Transaction transaction) async {
    return await _transactionService.createTransaction(transaction);
  }
  
  Future<Transaction> updateTransaction(
    String id,
    Transaction transaction,
  ) async {
    return await _transactionService.updateTransaction(id, transaction);
  }
  
  Future<void> deleteTransaction(String id) async {
    await _transactionService.deleteTransaction(id);
  }
  
  Future<List<Transaction>> getCachedTransactions() async {
    return await _transactionService.getCachedTransactions();
  }
}

// Provider
final transactionServiceProvider = Provider<TransactionService>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return TransactionService(apiClient);
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  final service = ref.watch(transactionServiceProvider);
  return TransactionRepository(service);
});

// Transactions list provider
final transactionsProvider = FutureProvider.autoDispose<List<Transaction>>((ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  return await repository.getTransactions();
});

// Recent transactions provider (last 10)
final recentTransactionsProvider = FutureProvider.autoDispose<List<Transaction>>((ref) async {
  final repository = ref.watch(transactionRepositoryProvider);
  final transactions = await repository.getTransactions(limit: 10);
  return transactions;
});

import 'dart:convert';
import '../../core/constants/app_constants.dart';
import '../../models/transaction_model.dart';
import '../api/api_client.dart';
import '../storage/local_storage_service.dart';

class TransactionService {
  final ApiClient _apiClient;
  
  TransactionService(this._apiClient);
  
  Future<List<Transaction>> getTransactions({
    int? limit,
    int? offset,
    String? type,
    String? category,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final queryParams = <String, dynamic>{
      if (limit != null) 'limit': limit,
      if (offset != null) 'offset': offset,
      if (type != null) 'type': type,
      if (category != null) 'category': category,
      if (startDate != null) 'startDate': startDate.toIso8601String(),
      if (endDate != null) 'endDate': endDate.toIso8601String(),
    };
    
    final response = await _apiClient.get(
      AppConstants.transactionsEndpoint,
      queryParameters: queryParams,
    );
    
    final transactions = (response.data['transactions'] as List)
        .map((json) => Transaction.fromJson(json))
        .toList();
    
    // Cache transactions locally
    await _cacheTransactions(transactions);
    
    return transactions;
  }
  
  Future<Transaction> getTransaction(String id) async {
    final response = await _apiClient.get(
      '${AppConstants.transactionsEndpoint}/$id',
    );
    
    return Transaction.fromJson(response.data);
  }
  
  Future<Transaction> createTransaction(Transaction transaction) async {
    final response = await _apiClient.post(
      AppConstants.transactionsEndpoint,
      data: transaction.toJson(),
    );
    
    final newTransaction = Transaction.fromJson(response.data);
    
    // Cache locally
    await _cacheTransaction(newTransaction);
    
    return newTransaction;
  }
  
  Future<Transaction> updateTransaction(
    String id,
    Transaction transaction,
  ) async {
    final response = await _apiClient.put(
      '${AppConstants.transactionsEndpoint}/$id',
      data: transaction.toJson(),
    );
    
    final updatedTransaction = Transaction.fromJson(response.data);
    
    // Update cache
    await _cacheTransaction(updatedTransaction);
    
    return updatedTransaction;
  }
  
  Future<void> deleteTransaction(String id) async {
    await _apiClient.delete(
      '${AppConstants.transactionsEndpoint}/$id',
    );
    
    // Remove from cache
    await LocalStorageService.transactionsBox.delete(id);
  }
  
  Future<List<Transaction>> getCachedTransactions() async {
    final box = LocalStorageService.transactionsBox;
    final transactions = <Transaction>[];
    
    for (var key in box.keys) {
      try {
        final json = jsonDecode(box.get(key) as String);
        transactions.add(Transaction.fromJson(json));
      } catch (e) {
        // Skip invalid entries
      }
    }
    
    return transactions;
  }
  
  Future<void> _cacheTransaction(Transaction transaction) async {
    await LocalStorageService.transactionsBox.put(
      transaction.id,
      jsonEncode(transaction.toJson()),
    );
  }
  
  Future<void> _cacheTransactions(List<Transaction> transactions) async {
    for (var transaction in transactions) {
      await _cacheTransaction(transaction);
    }
  }
}

import 'package:flutter_test/flutter_test.dart';
import 'package:budgetbuddy/models/transaction_model.dart';

void main() {
  group('Transaction Model Tests', () {
    test('Transaction can be created from JSON', () {
      final json = {
        'id': 'txn_123',
        'userId': 'user_123',
        'title': 'Grocery Shopping',
        'description': 'Weekly groceries',
        'amount': 125.50,
        'type': 'expense',
        'category': 'Food & Dining',
        'date': '2024-01-15T00:00:00.000Z',
        'createdAt': '2024-01-15T10:30:00.000Z',
      };

      final transaction = Transaction.fromJson(json);

      expect(transaction.id, 'txn_123');
      expect(transaction.title, 'Grocery Shopping');
      expect(transaction.amount, 125.50);
      expect(transaction.type, TransactionType.expense);
      expect(transaction.category, 'Food & Dining');
    });

    test('Transaction can be converted to JSON', () {
      final transaction = Transaction(
        id: 'txn_123',
        userId: 'user_123',
        title: 'Salary',
        amount: 5000.00,
        type: TransactionType.income,
        category: 'Salary',
        date: DateTime.parse('2024-01-01T00:00:00.000Z'),
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
      );

      final json = transaction.toJson();

      expect(json['id'], 'txn_123');
      expect(json['title'], 'Salary');
      expect(json['amount'], 5000.00);
      expect(json['type'], 'income');
      expect(json['category'], 'Salary');
    });

    test('Transaction copyWith works correctly', () {
      final transaction = Transaction(
        id: 'txn_123',
        userId: 'user_123',
        title: 'Original',
        amount: 100.00,
        type: TransactionType.expense,
        category: 'Food',
        date: DateTime.now(),
        createdAt: DateTime.now(),
      );

      final updated = transaction.copyWith(
        title: 'Updated',
        amount: 150.00,
      );

      expect(updated.title, 'Updated');
      expect(updated.amount, 150.00);
      expect(updated.category, 'Food');
      expect(updated.id, 'txn_123');
    });
  });
}

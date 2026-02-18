import 'package:flutter_test/flutter_test.dart';
import 'package:budgetbuddy/core/utils/helpers.dart';

void main() {
  group('DateTimeUtils Tests', () {
    test('formatDate formats correctly', () {
      final date = DateTime(2024, 1, 15);
      final formatted = DateTimeUtils.formatDate(date);
      expect(formatted, 'Jan 15, 2024');
    });

    test('formatCurrency formats correctly', () {
      expect(DateTimeUtils.formatCurrency(100.0), '\$100.00');
      expect(DateTimeUtils.formatCurrency(1234.56), '\$1234.56');
      expect(DateTimeUtils.formatCurrency(0.99), '\$0.99');
    });

    test('isSameDay works correctly', () {
      final date1 = DateTime(2024, 1, 15, 10, 30);
      final date2 = DateTime(2024, 1, 15, 14, 45);
      final date3 = DateTime(2024, 1, 16, 10, 30);

      expect(DateTimeUtils.isSameDay(date1, date2), true);
      expect(DateTimeUtils.isSameDay(date1, date3), false);
    });

    test('startOfMonth and endOfMonth work correctly', () {
      final date = DateTime(2024, 3, 15);
      final start = DateTimeUtils.startOfMonth(date);
      final end = DateTimeUtils.endOfMonth(date);

      expect(start.day, 1);
      expect(start.month, 3);
      expect(end.day, 31);
      expect(end.month, 3);
    });
  });

  group('ValidationUtils Tests', () {
    test('validateEmail validates correctly', () {
      expect(ValidationUtils.isValidEmail('test@example.com'), true);
      expect(ValidationUtils.isValidEmail('invalid.email'), false);
      expect(ValidationUtils.isValidEmail('test@'), false);
    });

    test('validatePassword validates correctly', () {
      expect(ValidationUtils.isValidPassword('password123'), true);
      expect(ValidationUtils.isValidPassword('pass'), false);
      expect(ValidationUtils.isValidPassword(''), false);
    });

    test('validateAmount returns error for invalid amounts', () {
      expect(ValidationUtils.validateAmount('100'), null);
      expect(ValidationUtils.validateAmount(''), 'Amount is required');
      expect(ValidationUtils.validateAmount('abc'), 'Please enter a valid number');
      expect(ValidationUtils.validateAmount('-50'), 'Amount must be greater than 0');
      expect(ValidationUtils.validateAmount('0'), 'Amount must be greater than 0');
    });
  });
}

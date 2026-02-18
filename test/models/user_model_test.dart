import 'package:flutter_test/flutter_test.dart';
import 'package:budgetbuddy/models/user_model.dart';

void main() {
  group('User Model Tests', () {
    test('User can be created from JSON', () {
      final json = {
        'id': 'user_123',
        'email': 'test@example.com',
        'name': 'Test User',
        'photoUrl': 'https://example.com/photo.jpg',
        'createdAt': '2024-01-01T00:00:00.000Z',
      };

      final user = User.fromJson(json);

      expect(user.id, 'user_123');
      expect(user.email, 'test@example.com');
      expect(user.name, 'Test User');
      expect(user.photoUrl, 'https://example.com/photo.jpg');
    });

    test('User can be converted to JSON', () {
      final user = User(
        id: 'user_123',
        email: 'test@example.com',
        name: 'Test User',
        photoUrl: 'https://example.com/photo.jpg',
        createdAt: DateTime.parse('2024-01-01T00:00:00.000Z'),
      );

      final json = user.toJson();

      expect(json['id'], 'user_123');
      expect(json['email'], 'test@example.com');
      expect(json['name'], 'Test User');
      expect(json['photoUrl'], 'https://example.com/photo.jpg');
    });

    test('User copyWith works correctly', () {
      final user = User(
        id: 'user_123',
        email: 'test@example.com',
        name: 'Test User',
        createdAt: DateTime.now(),
      );

      final updated = user.copyWith(name: 'Updated Name');

      expect(updated.name, 'Updated Name');
      expect(updated.email, 'test@example.com');
      expect(updated.id, 'user_123');
    });
  });
}

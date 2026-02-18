import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

enum TransactionType {
  @JsonValue('income')
  income,
  @JsonValue('expense')
  expense,
}

@JsonSerializable()
class Transaction extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final double amount;
  final TransactionType type;
  final String category;
  final DateTime date;
  final DateTime createdAt;
  final DateTime? updatedAt;
  
  const Transaction({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.amount,
    required this.type,
    required this.category,
    required this.date,
    required this.createdAt,
    this.updatedAt,
  });
  
  factory Transaction.fromJson(Map<String, dynamic> json) => 
      _$TransactionFromJson(json);
  
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
  
  Transaction copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    double? amount,
    TransactionType? type,
    String? category,
    DateTime? date,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Transaction(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
  
  @override
  List<Object?> get props => [
    id, userId, title, description, amount, type, category, date, 
    createdAt, updatedAt
  ];
}

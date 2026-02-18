import 'package:equatable/equatable.dart';

class DashboardSummary extends Equatable {
  final double totalBalance;
  final double totalIncome;
  final double totalExpense;
  final double monthlyIncome;
  final double monthlyExpense;
  final List<CategoryExpense> topCategories;
  
  const DashboardSummary({
    required this.totalBalance,
    required this.totalIncome,
    required this.totalExpense,
    required this.monthlyIncome,
    required this.monthlyExpense,
    required this.topCategories,
  });
  
  @override
  List<Object?> get props => [
    totalBalance, 
    totalIncome, 
    totalExpense, 
    monthlyIncome, 
    monthlyExpense, 
    topCategories
  ];
}

class CategoryExpense extends Equatable {
  final String category;
  final double amount;
  final double percentage;
  
  const CategoryExpense({
    required this.category,
    required this.amount,
    required this.percentage,
  });
  
  @override
  List<Object?> get props => [category, amount, percentage];
}

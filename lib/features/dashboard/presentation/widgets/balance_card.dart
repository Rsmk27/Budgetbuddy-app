import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/helpers.dart';

// Mock data provider - replace with actual implementation
final balanceProvider = Provider<Map<String, double>>((ref) {
  return {
    'balance': 0.0,
    'income': 0.0,
    'expense': 0.0,
  };
});

class BalanceCard extends ConsumerWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balance = ref.watch(balanceProvider);
    final totalBalance = balance['balance'] ?? 0.0;
    final totalIncome = balance['income'] ?? 0.0;
    final totalExpense = balance['expense'] ?? 0.0;

    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [AppColors.primary, AppColors.primaryDark],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Balance',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white.withOpacity(0.9),
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              DateTimeUtils.formatCurrency(totalBalance),
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Income',
                    totalIncome,
                    Icons.arrow_downward,
                    AppColors.success,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Expense',
                    totalExpense,
                    Icons.arrow_upward,
                    AppColors.error,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    double amount,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 16),
              const SizedBox(width: 4),
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            DateTimeUtils.formatCurrency(amount),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}

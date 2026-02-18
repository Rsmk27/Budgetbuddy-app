import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../models/transaction_model.dart';

class RecentTransactionsList extends StatelessWidget {
  final List<Transaction> transactions;

  const RecentTransactionsList({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return _TransactionListItem(transaction: transaction);
      },
    );
  }
}

class _TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const _TransactionListItem({required this.transaction});

  @override
  Widget build(BuildContext context) {
    final isIncome = transaction.type == TransactionType.income;
    final color = isIncome ? AppColors.income : AppColors.expense;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            isIncome ? Icons.arrow_downward : Icons.arrow_upward,
            color: color,
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(transaction.category),
            const SizedBox(height: 2),
            Text(
              DateTimeUtils.formatDate(transaction.date),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        trailing: Text(
          '${isIncome ? '+' : '-'}${DateTimeUtils.formatCurrency(transaction.amount)}',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        onTap: () {
          // TODO: Navigate to transaction details
        },
      ),
    );
  }
}

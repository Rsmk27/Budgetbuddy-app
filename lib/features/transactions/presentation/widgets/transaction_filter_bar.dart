import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TransactionFilterBar extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const TransactionFilterBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _FilterChip(
            label: 'All',
            isSelected: selectedFilter == 'all',
            onTap: () => onFilterChanged('all'),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Income',
            isSelected: selectedFilter == 'income',
            onTap: () => onFilterChanged('income'),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: 'Expense',
            isSelected: selectedFilter == 'expense',
            onTap: () => onFilterChanged('expense'),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.lightBorder,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSelected ? Colors.white : null,
                fontWeight: isSelected ? FontWeight.w600 : null,
              ),
        ),
      ),
    );
  }
}

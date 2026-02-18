import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../repositories/transaction_repository.dart';
import '../widgets/transaction_filter_bar.dart';
import '../../../dashboard/presentation/widgets/recent_transactions_list.dart';

class TransactionsTab extends ConsumerStatefulWidget {
  const TransactionsTab({super.key});

  @override
  ConsumerState<TransactionsTab> createState() => _TransactionsTabState();
}

class _TransactionsTabState extends ConsumerState<TransactionsTab> {
  String _filterType = 'all';

  @override
  Widget build(BuildContext context) {
    final transactionsAsync = ref.watch(transactionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // TODO: Show filter dialog
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TransactionFilterBar(
            selectedFilter: _filterType,
            onFilterChanged: (filter) {
              setState(() => _filterType = filter);
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(transactionsProvider);
              },
              child: transactionsAsync.when(
                data: (transactions) {
                  final filtered = _filterType == 'all'
                      ? transactions
                      : transactions
                          .where((t) => t.type.name == _filterType)
                          .toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: AppColors.lightTextSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No transactions found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      RecentTransactionsList(transactions: filtered),
                    ],
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Center(
                  child: Text(
                    error.toString(),
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

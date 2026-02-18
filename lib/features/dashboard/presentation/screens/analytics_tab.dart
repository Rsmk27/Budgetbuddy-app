import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/theme/app_theme.dart';

class AnalyticsTab extends ConsumerWidget {
  const AnalyticsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Overview',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: _MonthlyChart(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Spending by Category',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  height: 200,
                  child: _CategoryPieChart(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MonthlyChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 2000,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                if (value.toInt() < months.length) {
                  return Text(
                    months[value.toInt()],
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const Text('');
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          _makeBarGroup(0, 800, 1200),
          _makeBarGroup(1, 1000, 1400),
          _makeBarGroup(2, 1200, 1600),
          _makeBarGroup(3, 900, 1300),
          _makeBarGroup(4, 1100, 1500),
          _makeBarGroup(5, 1300, 1700),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double income, double expense) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: income,
          color: AppColors.income,
          width: 12,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
        BarChartRodData(
          toY: expense,
          color: AppColors.expense,
          width: 12,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
        ),
      ],
    );
  }
}

class _CategoryPieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sectionsSpace: 0,
        centerSpaceRadius: 40,
        sections: [
          PieChartSectionData(
            value: 30,
            title: '30%',
            color: AppColors.chartColors[0],
            radius: 50,
          ),
          PieChartSectionData(
            value: 25,
            title: '25%',
            color: AppColors.chartColors[1],
            radius: 50,
          ),
          PieChartSectionData(
            value: 20,
            title: '20%',
            color: AppColors.chartColors[2],
            radius: 50,
          ),
          PieChartSectionData(
            value: 15,
            title: '15%',
            color: AppColors.chartColors[3],
            radius: 50,
          ),
          PieChartSectionData(
            value: 10,
            title: '10%',
            color: AppColors.chartColors[4],
            radius: 50,
          ),
        ],
      ),
    );
  }
}

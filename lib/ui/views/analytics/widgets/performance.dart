// widgets/performance_trends_widget.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nest/ui/common/app_colors.dart';
import '../../../../models/organization_analytics.dart';
import '../analytics_viewmodel.dart';

class PerformanceTrendsWidget extends StatelessWidget {
  final AnalyticsViewModel viewModel;

  const PerformanceTrendsWidget({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Performance Trends',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildChartCard(
          'Revenue Over Time',
          viewModel.revenueChartData,
          const Color(0xFF4CAF50), // Green for revenue
          'KES',
        ),
        const SizedBox(height: 16),
        _buildChartCard(
          'Ticket Sales Over Time',
          viewModel.ticketSalesChartData,
          const Color(0xFF2196F3), // Blue for tickets
          'Tickets',
        ),
        const SizedBox(height: 16),
        _buildChartCard(
          'Events Over Time',
          viewModel.eventChartData,
          const Color(0xFFFF6B35), // Orange for events
          'Events',
        ),
      ],
    );
  }

  Widget _buildChartCard(
    String title,
    List<ChartDataPoint> data,
    Color lineColor,
    String valueUnit,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: kcDarkGreyColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: kcContainerBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: 160,
            child: data.isEmpty
                ? const Center(
                    child: Text(
                      'No data available',
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 14,
                      ),
                    ),
                  )
                : _buildLineChart(data, lineColor, valueUnit),
          ),
        ],
      ),
    );
  }

  Widget _buildLineChart(
    List<ChartDataPoint> data,
    Color lineColor,
    String valueUnit,
  ) {
    // Filter out zero values for better visualization
    final nonZeroData = data.where((point) => point.value > 0).toList();
    final hasNonZeroData = nonZeroData.isNotEmpty;

    // If all values are zero, show a different message
    if (!hasNonZeroData) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.trending_flat,
              color: Colors.white38,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'No $valueUnit yet',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    // Create spots for the chart
    final spots = <FlSpot>[];
    final maxValue = data.map((e) => e.value).reduce((a, b) => a > b ? a : b);

    for (int i = 0; i < data.length; i++) {
      spots.add(FlSpot(i.toDouble(), data[i].value));
    }

    return Padding(
      padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawHorizontalLine: true,
            drawVerticalLine: false,
            horizontalInterval: maxValue > 0 ? maxValue / 4 : 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.white.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            show: true,
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 32,
                interval: 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < data.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        data[index].label,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }
                  return const Text('');
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: maxValue > 0 ? maxValue / 4 : 1,
                getTitlesWidget: (double value, TitleMeta meta) {
                  if (value == 0) return const Text('');
                  return Text(
                    _formatValue(value, valueUnit),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            show: true,
            border: Border(
              bottom: BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              left: BorderSide(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
            ),
          ),
          minX: 0,
          maxX: (data.length - 1).toDouble(),
          minY: 0,
          maxY: maxValue * 1.2, // Add 20% padding to top
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: lineColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true,
                getDotPainter: (spot, percent, barData, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: lineColor,
                    strokeWidth: 2,
                    strokeColor: Colors.white,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                color: lineColor.withOpacity(0.1),
              ),
              shadow: Shadow(
                color: lineColor.withOpacity(0.3),
                offset: const Offset(0, 2),
                blurRadius: 4,
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              tooltipBorderRadius: BorderRadius.circular(8),
              tooltipPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                return touchedBarSpots.map((barSpot) {
                  final index = barSpot.x.toInt();
                  if (index >= 0 && index < data.length) {
                    return LineTooltipItem(
                      '${data[index].label}\n${_formatValue(barSpot.y, valueUnit)}',
                      const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  }
                  return null;
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  String _formatValue(double value, String unit) {
    if (unit == 'KES') {
      if (value >= 1000) {
        return '${(value / 1000).toStringAsFixed(1)}K';
      }
      return value.toInt().toString();
    }
    return value.toInt().toString();
  }
}

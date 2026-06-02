import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../screens/kpi/kpi_detail_screen.dart';

class Kpi1Saturacion extends StatelessWidget {
  const Kpi1Saturacion({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const KpiDetailScreen(title: "KPI 1: Saturación", kpiId: 1),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(toY: 15420, color: Colors.red, width: 15),
                    ],
                  ),
                  BarChartGroupData(
                    x: 1,
                    barRods: [
                      BarChartRodData(
                        toY: 12050,
                        color: Colors.orange,
                        width: 15,
                      ),
                    ],
                  ),
                ],
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(value.toInt() == 0 ? 'CDMX' : 'Jalisco');
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return const Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Text(
        'KPI 1: Saturación Nacional',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../screens/kpi/kpi_detail_screen.dart';

class Kpi2Tendencia extends StatelessWidget {
  const Kpi2Tendencia({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const KpiDetailScreen(
              title: "KPI 2: Tendencia Histórica",
              kpiId: 2,
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: const [FlSpot(0, 14), FlSpot(1, 24)],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                  ),
                  LineChartBarData(
                    spots: const [FlSpot(0, 2), FlSpot(1, 1)],
                    isCurved: true,
                    color: Colors.red,
                    barWidth: 3,
                  ),
                ],
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
        'KPI 2: Tendencia Histórica',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

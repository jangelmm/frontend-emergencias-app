import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../screens/kpi/kpi_detail_screen.dart';

class Kpi3Proporcion extends StatelessWidget {
  const Kpi3Proporcion({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const KpiDetailScreen(
              title: "KPI 3: Proporción Nacional",
              kpiId: 3,
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
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 65.5,
                    title: '65.5%\nViales',
                    color: Colors.blue,
                    radius: 60,
                  ),
                  PieChartSectionData(
                    value: 34.5,
                    title: '34.5%\nDelitos',
                    color: Colors.redAccent,
                    radius: 60,
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
        'KPI 3: Proporción Nacional',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

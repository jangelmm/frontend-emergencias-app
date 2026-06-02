import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../screens/kpi/kpi_detail_screen.dart';

class Kpi5Chart extends StatelessWidget {
  final List<dynamic> data;

  const Kpi5Chart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>
                const KpiDetailScreen(title: "KPI 5: Días críticos", kpiId: 5),
          ),
        );
      },
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _title(),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: item["totalEmergencias"].toDouble(),
                          width: 15,
                          color: Colors.blue,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _title() {
  return const Padding(
    padding: EdgeInsets.only(bottom: 16),
    child: Text(
      'KPI 5: Dias criticos',
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

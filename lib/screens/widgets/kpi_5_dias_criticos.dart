import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Kpi5Chart extends StatelessWidget {
  final List<dynamic> data;

  const Kpi5Chart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
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

          titlesData: FlTitlesData(
            leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final dia = data[value.toInt()]["dia"];
                  return Text(dia.substring(0, 3));
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

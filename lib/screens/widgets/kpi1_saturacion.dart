import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../kpi/kpi_detail_screen.dart';

class Kpi1Saturacion extends StatelessWidget {
  final Map<String, dynamic> data;
  final String estado, anio, trimestre;
  final bool isDetail;

  const Kpi1Saturacion({super.key, required this.data, required this.estado, required this.anio, required this.trimestre, this.isDetail = false});

  @override
  Widget build(BuildContext context) {
    final items = data['data'] as List<dynamic>? ?? [];
    Widget chart = SizedBox(
      height: isDetail ? double.infinity : 200,
      child: BarChart(BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: items.asMap().entries.map((e) => BarChartGroupData(x: e.key, barRods: [
          BarChartRodData(toY: (e.value['totalEmergencias'] as num).toDouble(), color: e.value['nivelAlerta'] == 'ROJO' ? Colors.red : Colors.orange, width: 15)
        ])).toList(),
        titlesData: FlTitlesData(bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) => Text(items[v.toInt()]['estado'].toString().substring(0,3))))),
      )),
    );

    if (isDetail) return chart;
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KpiDetailScreen(title: "KPI 1: Saturación", kpiId: 1, data: data, estado: estado, anio: anio, trimestre: trimestre))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('KPI 1: Saturación', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 10), chart]),
    );
  }
}

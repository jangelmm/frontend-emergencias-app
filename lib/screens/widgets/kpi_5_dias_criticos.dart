import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../kpi/kpi_detail_screen.dart';

class Kpi5Chart extends StatelessWidget {
  final Map<String, dynamic> data;
  final String estado, anio, trimestre;
  final bool isDetail;

  const Kpi5Chart({super.key, required this.data, required this.estado, required this.anio, required this.trimestre, this.isDetail = false});

  @override
  Widget build(BuildContext context) {
    final items = data['data'] as List<dynamic>? ?? [];
    Widget chart = SizedBox(
      height: isDetail ? double.infinity : 200,
      child: BarChart(BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barGroups: items.asMap().entries.map((e) => BarChartGroupData(x: e.key, barRods: [BarChartRodData(toY: (e.value['totalEmergencias'] as num).toDouble(), color: Colors.indigo, width: 15)])).toList(),
        titlesData: FlTitlesData(bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, m) => Text(items[v.toInt()]['dia'].toString().substring(0,3))))),
      )),
    );

    if (isDetail) return chart;
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KpiDetailScreen(title: "KPI 5: Días Críticos", kpiId: 5, data: data, estado: estado, anio: anio, trimestre: trimestre))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('KPI 5: Mapa Operativo (Días)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 10), chart]),
    );
  }
}

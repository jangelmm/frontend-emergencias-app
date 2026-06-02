import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../kpi/kpi_detail_screen.dart';

class Kpi2Tendencia extends StatelessWidget {
  final Map<String, dynamic> data;
  final String estado, anio, trimestre;
  final bool isDetail;

  const Kpi2Tendencia({super.key, required this.data, required this.estado, required this.anio, required this.trimestre, this.isDetail = false});

  @override
  Widget build(BuildContext context) {
    final items = data['data'] as List<dynamic>? ?? [];
    Widget chart = SizedBox(
      height: isDetail ? double.infinity : 200,
      child: LineChart(LineChartData(
        lineBarsData: [
          LineChartBarData(spots: items.asMap().entries.map((e) => FlSpot(e.key.toDouble(), (e.value['accidentesViales'] as num).toDouble())).toList(), color: Colors.blue, isCurved: true),
          LineChartBarData(spots: items.asMap().entries.map((e) => FlSpot(e.key.toDouble(), (e.value['delitosRegistrados'] as num).toDouble())).toList(), color: Colors.red, isCurved: true),
        ],
      )),
    );

    if (isDetail) return chart;
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KpiDetailScreen(title: "KPI 2: Tendencia", kpiId: 2, data: data, estado: estado, anio: anio, trimestre: trimestre))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('KPI 2: Tendencia Histórica', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 10), chart]),
    );
  }
}

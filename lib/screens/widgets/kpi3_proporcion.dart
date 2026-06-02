import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../kpi/kpi_detail_screen.dart';

class Kpi3Proporcion extends StatelessWidget {
  final Map<String, dynamic> data;
  final String estado, anio, trimestre;
  final bool isDetail;

  const Kpi3Proporcion({super.key, required this.data, required this.estado, required this.anio, required this.trimestre, this.isDetail = false});

  @override
  Widget build(BuildContext context) {
    final items = data['data'] as List<dynamic>? ?? [];
    Widget chart = SizedBox(
      height: isDetail ? double.infinity : 200,
      child: PieChart(PieChartData(
        sections: items.map((e) => PieChartSectionData(value: (e['porcentaje'] as num).toDouble(), title: '${e['porcentaje']}%\n${e['tipo'].toString().substring(0,6)}', color: e['tipo'].toString().contains('Vial') ? Colors.blue : Colors.red, radius: 60)).toList(),
      )),
    );

    if (isDetail) return chart;
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KpiDetailScreen(title: "KPI 3: Proporción", kpiId: 3, data: data, estado: estado, anio: anio, trimestre: trimestre))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('KPI 3: Proporción', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 10), chart]),
    );
  }
}

import 'package:flutter/material.dart';
import '../kpi/kpi_detail_screen.dart';

class Kpi4Card extends StatelessWidget {
  final Map<String, dynamic> data;
  final String estado, anio, trimestre;
  final bool isDetail;

  const Kpi4Card({super.key, required this.data, required this.estado, required this.anio, required this.trimestre, this.isDetail = false});

  @override
  Widget build(BuildContext context) {
    final item = data["data"] ?? {};
    final bool isUp = item["tendencia"] == "ALZA";

    Widget card = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Año actual: ${item['anioActual']} → ${item['totalActual']}", style: const TextStyle(fontSize: 16)),
        Text("Año anterior: ${item['anioAnterior']} → ${item['totalAnterior']}", style: const TextStyle(fontSize: 16)),
        Row(
          children: [
            Icon(isUp ? Icons.arrow_upward : Icons.arrow_downward, color: isUp ? Colors.red : Colors.green, size: 40),
            Text("${item['porcentajeCambio']}%", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: isUp ? Colors.red : Colors.green)),
          ],
        ),
      ],
    );

    if (isDetail) return card;
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => KpiDetailScreen(title: "KPI 4: Comparativa", kpiId: 4, data: data, estado: estado, anio: anio, trimestre: trimestre))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text('KPI 4: Comparativa Interanual', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), const SizedBox(height: 10), card]),
    );
  }
}

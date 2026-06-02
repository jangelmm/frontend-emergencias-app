import 'package:flutter/material.dart';
import '../../screens/kpi/kpi_detail_screen.dart';

class Kpi4Card extends StatelessWidget {
  final Map<String, dynamic> data;

  const Kpi4Card({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isUp = data["tendencia"] == "ALZA";

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
          Text(
            data["kpi"],
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text("Estado: ${data["estado"]}"),
          Text("Año actual: ${data["anioActual"]} → ${data["totalActual"]}"),
          Text(
            "Año anterior: ${data["anioAnterior"]} → ${data["totalAnterior"]}",
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              Icon(
                isUp ? Icons.arrow_upward : Icons.arrow_downward,
                color: isUp ? Colors.red : Colors.green,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                "${data["porcentajeCambio"]}%",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isUp ? Colors.red : Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: 5),

          Text(isUp ? "Incremento interanual" : "Disminución interanual"),
        ],
      ),
    );
  }
}

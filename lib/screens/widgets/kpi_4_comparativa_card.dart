import 'package:flutter/material.dart';
import '../../screens/kpi/kpi_detail_screen.dart';

class Kpi4Card extends StatelessWidget {
  final Map<String, dynamic> data;

  const Kpi4Card({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final String kpi = (data["kpi"] ?? "").toString();
    final String estado = (data["estado"] ?? "").toString();

    final int anioActual = (data["anioActual"] ?? 0);
    final int totalActual = (data["totalActual"] ?? 0);
    final int anioAnterior = (data["anioAnterior"] ?? 0);
    final int totalAnterior = (data["totalAnterior"] ?? 0);

    final double porcentaje =
        (data["porcentajeCambio"] as num?)?.toDouble() ?? 0.0;

    final bool isUp = data["tendencia"] == "ALZA";

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => KpiDetailScreen(
              title: kpi,
              kpiId: 4, // 🔥 FIX IMPORTANTE: no uses data["kpiId"] si no existe
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            kpi,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          Text("Estado: $estado"),
          Text("Año actual: $anioActual → $totalActual"),
          Text("Año anterior: $anioAnterior → $totalAnterior"),

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
                "$porcentaje%",
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

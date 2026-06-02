import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../data/mock/kpi_4_data.dart';
import '../../data/mock/kpi_5_data.dart';

class KpiDetailScreen extends StatelessWidget {
  final String title;
  final int kpiId;

  const KpiDetailScreen({super.key, required this.title, required this.kpiId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (kpiId) {
      case 1:
        return _kpiSaturacion();
      case 2:
        return _kpiTendencia();
      case 3:
        return _kpiProporcion();
      case 4:
        return _kpiCard(context);
      case 5:
        return _kpiChart();
      default:
        return const Text("KPI no encontrado");
    }
  }

  Widget _kpiSaturacion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Análisis de Saturación Nacional",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        SizedBox(
          height: 250,
          child: BarChart(
            BarChartData(
              barGroups: [
                BarChartGroupData(
                  x: 0,
                  barRods: [BarChartRodData(toY: 15420, color: Colors.red)],
                ),
                BarChartGroupData(
                  x: 1,
                  barRods: [BarChartRodData(toY: 12050, color: Colors.orange)],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Interpretación:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const Text(
          "Ciudad de México presenta mayor saturación comparado con Jalisco, lo que indica mayor carga operativa en emergencias.",
        ),
      ],
    );
  }

  Widget _kpiTendencia() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tendencia Histórica",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  spots: const [FlSpot(0, 14), FlSpot(1, 24)],
                  isCurved: true,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Interpretación:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const Text(
          "Se observa un incremento en accidentes viales, lo que sugiere tendencia al alza en incidentes diarios.",
        ),
      ],
    );
  }

  Widget _kpiProporcion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Proporción Nacional",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        SizedBox(
          height: 250,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  value: 65.5,
                  title: "Viales",
                  color: Colors.blue,
                  radius: 60,
                ),
                PieChartSectionData(
                  value: 34.5,
                  title: "Delitos",
                  color: Colors.red,
                  radius: 60,
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Text(
          "Interpretación:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        const Text(
          "La mayoría de los incidentes corresponden a accidentes viales, representando más del 60% del total.",
        ),
      ],
    );
  }

  Widget _kpiCard(BuildContext context) {
    final kpi = (kpi4["kpi"] ?? "").toString();
    final estado = (kpi4["estado"] ?? "").toString();
    final anioActual = (kpi4["anioActual"] ?? 0);
    final totalActual = (kpi4["totalActual"] ?? 0);
    final anioAnterior = (kpi4["anioAnterior"] ?? 0);
    final totalAnterior = (kpi4["totalAnterior"] ?? 0);
    final porcentaje = (kpi4["porcentajeCambio"] ?? 0);
    final tendencia = (kpi4["tendencia"] ?? "").toString();

    final isUp = tendencia == "ALZA";

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => KpiDetailScreen(title: kpi, kpiId: 4),
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
      ),
    );
  }

  Widget _kpiChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 16),
          child: Text(
            'KPI 5: Días críticos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 200,
          width: double.infinity,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,

              barGroups: kpi5.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: (item["totalEmergencias"] as num).toDouble(),
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
                      final dia = kpi5[value.toInt()]["dia"] as String?;
                      final label = (dia != null && dia.length >= 3)
                          ? dia.substring(0, 3)
                          : (dia ?? '');
                      return Text(label);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

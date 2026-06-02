import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class KpiDetailScreen extends StatelessWidget {
  final String title;
  final int kpiId;

  const KpiDetailScreen({super.key, required this.title, required this.kpiId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(padding: const EdgeInsets.all(16), child: _buildContent()),
    );
  }

  Widget _buildContent() {
    switch (kpiId) {
      case 1:
        return _kpiSaturacion();
      case 2:
        return _kpiTendencia();
      case 3:
        return _kpiProporcion();
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
}

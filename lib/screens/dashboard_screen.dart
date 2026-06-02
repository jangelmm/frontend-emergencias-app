import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/mock_api.dart';
import 'kpi/kpi_detail_screen.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final mapSaturacion = MockApi.getSaturacion();
  final mapTendencia = MockApi.getTendencia();
  final mapProporcion = MockApi.getProporcion();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        InkWell(
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
              _buildCardTitle('KPI 1: Saturación Nacional'),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: 15420,
                            color: Colors.red,
                            width: 15,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: 12050,
                            color: Colors.orange,
                            width: 15,
                          ),
                        ],
                      ),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            return Text(
                              value.toInt() == 0 ? 'CDMX' : 'Jalisco',
                              style: const TextStyle(fontSize: 12),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const Divider(height: 40),

        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const KpiDetailScreen(title: "KPI 2: Tendencia Histórica", kpiId: 2),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardTitle('KPI 2: Tendencia Histórica'),
              SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [FlSpot(0, 14), FlSpot(1, 24)],
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                      ),
                      LineChartBarData(
                        spots: const [FlSpot(0, 2), FlSpot(1, 1)],
                        isCurved: true,
                        color: Colors.red,
                        barWidth: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 40),

        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    const KpiDetailScreen(title: "KPI 3: Proporción Nacional", kpiId: 3),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCardTitle('KPI 3: Proporción Nacional'),
              SizedBox(
                height: 200,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 65.5,
                        title: '65.5%\nViales',
                        color: Colors.blue,
                        radius: 60,
                      ),
                      PieChartSectionData(
                        value: 34.5,
                        title: '34.5%\nDelitos',
                        color: Colors.redAccent,
                        radius: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCardTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

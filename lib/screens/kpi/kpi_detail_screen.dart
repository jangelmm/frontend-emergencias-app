import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/kpi1_saturacion.dart';
import '../widgets/kpi2_tendencia.dart';
import '../widgets/kpi3_proporcion.dart';
import '../widgets/kpi_4_comparativa_card.dart';
import '../widgets/kpi_5_dias_criticos.dart';

class KpiDetailScreen extends StatelessWidget {
  final String title;
  final int kpiId;
  final Map<String, dynamic> data;
  final String estado;
  final String anio;
  final String trimestre;

  const KpiDetailScreen({
    super.key, required this.title, required this.kpiId,
    required this.data, required this.estado, required this.anio, required this.trimestre
  });

  Future<void> _descargarReporte(BuildContext context) async {
    final url = Uri.parse('https://google.com/search?q=reporte+kpi=$kpiId&estado=$estado&anio=$anio&trimestre=$trimestre');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Simulación: Solicitando PDF al servidor...')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: _buildChart()),
            const SizedBox(height: 20),
            const Text("Análisis de Inteligencia", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("El indicador muestra el comportamiento de la incidencia operativa bajo los filtros seleccionados. Los datos procesados respaldan la asignación táctica de recursos en las zonas y horarios vulnerables."),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _descargarReporte(context),
        icon: const Icon(Icons.download),
        label: const Text('Descargar Reporte'),
      ),
    );
  }

  Widget _buildChart() {
    switch (kpiId) {
      case 1: return Kpi1Saturacion(data: data, estado: estado, anio: anio, trimestre: trimestre, isDetail: true);
      case 2: return Kpi2Tendencia(data: data, estado: estado, anio: anio, trimestre: trimestre, isDetail: true);
      case 3: return Kpi3Proporcion(data: data, estado: estado, anio: anio, trimestre: trimestre, isDetail: true);
      case 4: return Kpi4Card(data: data, estado: estado, anio: anio, trimestre: trimestre, isDetail: true);
      case 5: return Kpi5Chart(data: data, estado: estado, anio: anio, trimestre: trimestre, isDetail: true);
      default: return const Text("No visual available");
    }
  }
}

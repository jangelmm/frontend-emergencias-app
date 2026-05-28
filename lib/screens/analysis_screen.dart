import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text(
          'Reporte Ejecutivo de Inteligencia',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blueGrey),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        _buildSectionCard(
          title: 'Introducción',
          icon: Icons.info_outline,
          iconColor: Colors.blue,
          content: 'El presente documento detalla los Indicadores Clave de Rendimiento (KPIs) desarrollados para la plataforma de toma de decisiones del sistema de seguridad nacional. Estos indicadores son el resultado visual de un flujo de trabajo ETL que consolidó datos masivos de incidencia delictiva y hechos de tránsito a nivel nacional. El objetivo es proveer una interfaz gerencial que traduzca millones de registros crudos en inteligencia accionable, permitiendo identificar patrones de emergencias y aportar valor a la optimización de recursos.',
        ),
        _buildKpiCard(
          kpiTitle: 'KPI 1: Índice de Saturación Geoespacial',
          visual: 'Gráfica de Barras (Ranking Top/Bottom).',
          justification: 'Responde a la necesidad de identificar zonas críticas de manera inmediata. Permite a los centros de mando determinar qué estados presentan la mayor carga de trabajo simultánea por choques y actos delictivos. Con esta información, los directivos pueden reasignar presupuestos o priorizar el envío de apoyos federales.',
          technical: 'Se alimenta procesando la tabla consolidada emergencias_nacionales_consolidado. El motor agrupa los registros por estado (GROUP BY) y suma sus emergencias (SUM).',
          icon: Icons.bar_chart,
        ),
        _buildKpiCard(
          kpiTitle: 'KPI 2: Tendencia de Carga Operativa',
          visual: 'Gráfica de Líneas (Series de Tiempo).',
          justification: 'La gestión de emergencias requiere previsión. Busca simular un entorno de respuesta rápida basado en la evidencia histórica. Al visualizar picos y valles, se proveen datos precisos para que el sistema 911 pueda asignar patrullas y ambulancias estratégicamente.',
          technical: 'Desglosa las emergencias por estado, año y mes. Utiliza funciones de extracción de fechas en formato ISO 8601, agrupando los incidentes temporalmente para renderizar la evolución y tendencias.',
          icon: Icons.show_chart,
        ),
        _buildKpiCard(
          kpiTitle: 'KPI 3: Proporción Global de Incidentes',
          visual: 'Gráfica de Pastel / Anillo (Distribución Porcentual).',
          justification: 'Ofrece una fotografía macroscópica de la naturaleza de las emergencias. Conocer la proporción exacta ayuda a dimensionar si la infraestructura pública requiere más inversión en seguridad ciudadana (prevención del delito) o en vialidad y control de tránsito (prevención de accidentes).',
          technical: 'Se logró mediante un INNER JOIN entre ambas fuentes para consolidar el conteo. Suma los totales nacionales absolutos de seguridad y del catálogo del INEGI, calculando la distribución porcentual exacta.',
          icon: Icons.pie_chart,
        ),
        _buildSectionCard(
          title: 'Conclusión Estratégica',
          icon: Icons.lightbulb_outline,
          iconColor: Colors.amber,
          content: 'La implementación de estos tres KPIs transforma un repositorio estático de datos en un entorno de Business Intelligence (Inteligencia de Negocios). La plataforma garantiza que las decisiones logísticas y tácticas de seguridad pública no se basen en estimaciones, sino en el análisis algorítmico y matemático de los registros nacionales consolidados.',
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildSectionCard({required String title, required IconData icon, required Color iconColor, required String content}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: iconColor, size: 28),
                const SizedBox(width: 8),
                Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 12),
            Text(content, style: const TextStyle(fontSize: 14, height: 1.5)),
          ],
        ),
      ),
    );
  }

  Widget _buildKpiCard({required String kpiTitle, required String visual, required String justification, required String technical, required IconData icon}) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueGrey, size: 28),
                const SizedBox(width: 8),
                Expanded(child: Text(kpiTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              ],
            ),
            const Divider(height: 24),
            _buildDetailRow('Representación:', visual),
            const SizedBox(height: 8),
            _buildDetailRow('Justificación:', justification),
            const SizedBox(height: 8),
            _buildDetailRow('Implementación:', technical),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 14, color: Colors.black87, height: 1.5),
        children: [
          TextSpan(text: '$label ', style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

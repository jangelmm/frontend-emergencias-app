import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PdfPreview(
      build: (format) => _generatePdf(format),
      allowPrinting: true,
      allowSharing: true,
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: format,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text('Reporte Ejecutivo: Indicadores Clave de Rendimiento (KPIs)', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            ),
            pw.Text('Plataforma de Inteligencia de Emergencias Nacionales', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold, color: PdfColors.blueGrey700)),
            pw.SizedBox(height: 20),

            _buildPdfSection(
              title: 'Introducción',
              content: 'El presente documento detalla los Indicadores Clave de Rendimiento (KPIs) desarrollados para la plataforma de toma de decisiones del sistema de seguridad nacional. Estos indicadores son el resultado visual de un flujo de trabajo ETL que consolidó datos masivos de incidencia delictiva y hechos de tránsito a nivel nacional. El objetivo es proveer una interfaz gerencial que traduzca millones de registros crudos en inteligencia accionable, permitiendo identificar patrones de emergencias y aportar valor a la optimización de recursos.',
            ),

            _buildPdfKpi(
              title: 'KPI 1: Índice de Saturación Geoespacial (Volumen por Estado)',
              visual: 'Gráfica de Barras (Ranking Top/Bottom).',
              justification: 'Este indicador responde a la necesidad de identificar zonas críticas de manera inmediata. Permite a los centros de mando determinar qué estados presentan la mayor carga de trabajo simultánea por choques y actos delictivos. Con esta información, los directivos pueden reasignar presupuestos o priorizar el envío de apoyos federales a las entidades con mayor colapso operativo.',
              technical: 'A nivel de base de datos, este indicador se alimenta procesando la tabla consolidada emergencias_nacionales_consolidado. El motor de base de datos agrupa todos los registros por estado y suma sus emergencias. La API REST extrae este cálculo mediante una función de agregación (SUM) y un agrupamiento (GROUP BY), entregando un ranking ordenado de mayor a menor carga operativa.',
            ),

            _buildPdfKpi(
              title: 'KPI 2: Tendencia de Carga Operativa (Histórico Temporal)',
              visual: 'Gráfica de Líneas (Series de Tiempo).',
              justification: 'La gestión de emergencias requiere previsión. Este indicador busca simular un entorno de respuesta rápida basado en la evidencia histórica de emergencias nacionales. Al visualizar los picos y valles a lo largo del tiempo, se busca proveer datos precisos para que el sistema 911 pueda asignar patrullas y ambulancias de manera estratégica en los días y horas de mayor saturación.',
              technical: 'Para construir esta gráfica, el sistema desglosa las emergencias por estado, año y mes para identificar tendencias mensuales. Utilizando funciones de extracción de fechas estandarizadas en formato ISO 8601, el backend agrupa los incidentes temporalmente y los expone al frontend, permitiendo renderizar la evolución y descubrir si la incidencia muestra una tendencia decreciente o se estabiliza en el tiempo.',
            ),

            _buildPdfKpi(
              title: 'KPI 3: Proporción Global de Incidentes (Delitos vs. Accidentes)',
              visual: 'Gráfica de Pastel / Anillo (Distribución Porcentual).',
              justification: 'Este KPI ofrece una fotografía macroscópica de la naturaleza de las emergencias que enfrenta el país. Los datos muestran que las emergencias representan la principal carga operativa, con una alta correlación con accidentes. Conocer la proporción exacta ayuda a dimensionar si la infraestructura pública requiere más inversión en seguridad ciudadana (prevención del delito) o en vialidad y control de tránsito (prevención de accidentes).',
              technical: 'Técnicamente, este indicador demuestra el éxito del proceso de transformación. Se logró mediante la ejecución de un INNER JOIN entre ambas fuentes para consolidar el conteo de incidentes por zona geográfica. Al cruzar por estado y fecha para unir ambas métricas, el sistema suma los totales nacionales absolutos de la base de datos de seguridad y del catálogo del INEGI, calculando la distribución porcentual exacta que consume el cliente móvil.',
            ),

            _buildPdfSection(
              title: 'Conclusión Estratégica',
              content: 'La implementación de estos tres KPIs transforma un repositorio estático de datos en un entorno de Business Intelligence (Inteligencia de Negocios). La plataforma garantiza que las decisiones logísticas y tácticas de seguridad pública no se basen en estimaciones, sino en el análisis algorítmico y matemático de los registros nacionales consolidados.',
            ),
          ];
        },
      ),
    );

    return pdf.save();
  }

  pw.Widget _buildPdfSection({required String title, required String content}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 5),
        pw.Text(content, textAlign: pw.TextAlign.justify),
        pw.SizedBox(height: 15),
      ],
    );
  }

  pw.Widget _buildPdfKpi({required String title, required String visual, required String justification, required String technical}) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold, color: PdfColors.blue800)),
        pw.SizedBox(height: 5),
        _buildPdfRichText('Representación Visual:', visual),
        _buildPdfRichText('Justificación de Negocio:', justification),
        _buildPdfRichText('Implementación Técnica:', technical),
        pw.SizedBox(height: 15),
      ],
    );
  }

  pw.Widget _buildPdfRichText(String boldText, String normalText) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 4),
      child: pw.RichText(
        text: pw.TextSpan(
          style: const pw.TextStyle(fontSize: 12),
          children: [
            pw.TextSpan(text: '$boldText ', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.TextSpan(text: normalText),
          ],
        ),
        textAlign: pw.TextAlign.justify,
      ),
    );
  }
}

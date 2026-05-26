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
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                level: 0,
                child: pw.Text('Reporte Ejecutivo de Emergencias', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
              pw.SizedBox(height: 20),
              pw.Text('Resumen de Análisis Estratégico', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text('Problema: Puntos Ciegos de Cobertura.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('La concentración de patrullas en accidentes viales deja zonas periféricas vulnerables a picos delictivos.'),
              pw.SizedBox(height: 10),
              pw.Text('Solución: Despacho Dinámico Inteligente.', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('Retención estratégica del 20% de unidades en zonas rojas mediante monitoreo en tiempo real.'),
              pw.SizedBox(height: 30),
              pw.Divider(),
              pw.Text('Datos listos para la integración con los gráficos generados en el Dashboard.'),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}

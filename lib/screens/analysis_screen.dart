import 'package:flutter/material.dart';

class AnalysisScreen extends StatelessWidget {
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: const [
        Text(
          'Propuesta de Valor',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blueGrey),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
                    SizedBox(width: 8),
                    Text('Problema: Puntos Ciegos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'La concentración de patrullas en accidentes viales deja zonas periféricas vulnerables a picos delictivos.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline, color: Colors.green, size: 28),
                    SizedBox(width: 8),
                    Text('Solución: Despacho Dinámico', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Retención estratégica del 20% de unidades en zonas rojas mediante monitoreo en tiempo real.',
                  style: TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

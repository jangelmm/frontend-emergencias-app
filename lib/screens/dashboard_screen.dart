import 'package:flutter/material.dart';
import 'widgets/kpi1_saturacion.dart';
import 'widgets/kpi2_tendencia.dart';
import 'widgets/kpi3_proporcion.dart';
import 'widgets/kpi_4_comparativa_card.dart';
import 'widgets/kpi_5_dias_criticos.dart';

import '../data/mock/kpi_4_data.dart';
import '../data/mock/kpi_5_data.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Kpi1Saturacion(),
        const Divider(height: 40),

        const Kpi2Tendencia(),
        const Divider(height: 40),

        const Kpi3Proporcion(),
        const SizedBox(height: 20),

        //Kpi4Card(data: kpi4),
        //const SizedBox(height: 20),
        Kpi5Chart(data: kpi5),
        const SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'widgets/kpi1_saturacion.dart';
import 'widgets/kpi2_tendencia.dart';
import 'widgets/kpi3_proporcion.dart';
import 'widgets/kpi_4_comparativa_card.dart';
import 'widgets/kpi_5_dias_criticos.dart';

import '../data/mock/kpi_4_data.dart';
import '../data/mock/kpi_5_data.dart';
import '../services/mock_api.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  String selectedYear = '2024';
  String selectedQuarter = 'Todos';
  String selectedState = 'Nacional';

  final List<String> years = [
    '2020',
    '2021',
    '2022',
    '2023',
    '2024',
    '2025',
  ];

  final List<String> quarters = [
    'Todos',
    'T1',
    'T2',
    'T3',
    'T4',
  ];

  late List<String> states;

  void updateFilters() {
    setState(() {

    });

    // Aquí después se dispararán nuevamente
    // las peticiones a la API
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [

        // BARRA DE FILTROS GLOBALES
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 20,
              runSpacing: 10,
              alignment: WrapAlignment.start,
              children: [

                // FILTRO AÑO
                DropdownButton<String>(
                  value: selectedYear,
                  items: years.map((year) {
                    return DropdownMenuItem(
                      value: year,
                      child: Text(year),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedYear = value!;
                    updateFilters();
                  },
                ),

                // FILTRO TRIMESTRE
                DropdownButton<String>(
                  value: selectedQuarter,
                  items: quarters.map((quarter) {
                    return DropdownMenuItem(
                      value: quarter,
                      child: Text(quarter),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedQuarter = value!;
                    updateFilters();
                  },
                ),

                // FILTRO ESTADO
                DropdownButton<String>(
                  value: selectedState,
                  items: states.map((state) {
                    return DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedState = value!;
                    updateFilters();
                  },
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 20),

        const Kpi1Saturacion(),
        const Divider(height: 40),

        const Kpi2Tendencia(),
        const Divider(height: 40),

        const Kpi3Proporcion(),
        const SizedBox(height: 20),

        Kpi4Card(data: kpi4),
        const SizedBox(height: 20),

        Kpi5Chart(data: kpi5),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    states = MockApi.getEstados();
  }
}
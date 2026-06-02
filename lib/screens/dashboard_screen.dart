import 'package:flutter/material.dart';
import '../services/mock_api.dart';
import 'widgets/kpi1_saturacion.dart';
import 'widgets/kpi2_tendencia.dart';
import 'widgets/kpi3_proporcion.dart';
import 'widgets/kpi_4_comparativa_card.dart';
import 'widgets/kpi_5_dias_criticos.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String selectedYear = '2024';
  String selectedQuarter = 'Todos';
  String selectedState = 'Nacional';

  final List<String> years = ['2020', '2021', '2022', '2023', '2024', '2025'];
  final List<String> quarters = ['Todos', 'T1', 'T2', 'T3', 'T4'];
  late List<String> states;

  Map<String, dynamic> dataKpi1 = {};
  Map<String, dynamic> dataKpi2 = {};
  Map<String, dynamic> dataKpi3 = {};
  Map<String, dynamic> dataKpi4 = {};
  Map<String, dynamic> dataKpi5 = {};

  @override
  void initState() {
    super.initState();
    states = MockApi.getEstados();
    updateFilters();
  }

  void updateFilters() {
    setState(() {
      dataKpi1 = MockApi.getSaturacion(estado: selectedState, anio: selectedYear, trimestre: selectedQuarter);
      dataKpi2 = MockApi.getTendencia(estado: selectedState, anio: selectedYear, trimestre: selectedQuarter);
      dataKpi3 = MockApi.getProporcion(estado: selectedState, anio: selectedYear, trimestre: selectedQuarter);
      dataKpi4 = MockApi.getComparativa(estado: selectedState, anio: selectedYear, trimestre: selectedQuarter);
      dataKpi5 = MockApi.getDiasCriticos(estado: selectedState, anio: selectedYear, trimestre: selectedQuarter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Centro de Mando - BI')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Wrap(
                spacing: 15,
                runSpacing: 10,
                children: [
                  _buildDropdown(years, selectedYear, (v) { selectedYear = v!; updateFilters(); }),
                  _buildDropdown(quarters, selectedQuarter, (v) { selectedQuarter = v!; updateFilters(); }),
                  _buildDropdown(states, selectedState, (v) { selectedState = v!; updateFilters(); }),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Kpi1Saturacion(data: dataKpi1, estado: selectedState, anio: selectedYear, trimestre: selectedQuarter),
          const Divider(height: 40),
          Kpi2Tendencia(data: dataKpi2, estado: selectedState, anio: selectedYear, trimestre: selectedQuarter),
          const Divider(height: 40),
          Kpi3Proporcion(data: dataKpi3, estado: selectedState, anio: selectedYear, trimestre: selectedQuarter),
          const Divider(height: 40),
          Kpi4Card(data: dataKpi4, estado: selectedState, anio: selectedYear, trimestre: selectedQuarter),
          const Divider(height: 40),
          Kpi5Chart(data: dataKpi5, estado: selectedState, anio: selectedYear, trimestre: selectedQuarter),
        ],
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String currentValue, Function(String?) onChanged) {
    return DropdownButton<String>(
      value: currentValue,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: onChanged,
    );
  }
}

import 'dart:convert';

class MockApi {
  // Endpoint 1: Saturación
  static Map<String, dynamic> getSaturacion() {
    const String response = '''
    {
      "status": "success",
      "data": [
        { "estado": "Ciudad de Mexico", "totalEmergencias": 15420, "nivelAlerta": "ROJO" },
        { "estado": "Jalisco", "totalEmergencias": 12050, "nivelAlerta": "NARANJA" }
      ]
    }
    ''';
    return jsonDecode(response);
  }

  // Endpoint 2: Tendencia Histórica
  static Map<String, dynamic> getTendencia() {
    const String response = '''
    {
      "status": "success",
      "data": [
        { "fecha": "2024-01-01", "accidentesViales": 14, "delitosRegistrados": 2 },
        { "fecha": "2024-01-02", "accidentesViales": 24, "delitosRegistrados": 1 }
      ]
    }
    ''';
    return jsonDecode(response);
  }

  // Endpoint 3: Proporción
  static Map<String, dynamic> getProporcion() {
    const String response = '''
    {
      "status": "success",
      "data": [
        { "tipo": "Accidentes Viales", "porcentaje": 65.5 },
        { "tipo": "Delitos Operativos", "porcentaje": 34.5 }
      ]
    }
    ''';
    return jsonDecode(response);
  }
}

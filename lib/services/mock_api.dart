import 'dart:convert';

class MockApi {
  static Map<String, dynamic> getSaturacion({String? estado, String? anio, String? trimestre}) {
    final url = '/saturacion?estado=$estado&anio=$anio&trimestre=$trimestre';
    print("GET: $url");
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

  static Map<String, dynamic> getTendencia({String? estado, String? anio, String? trimestre}) {
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

  static Map<String, dynamic> getProporcion({String? estado, String? anio, String? trimestre}) {
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

  static Map<String, dynamic> getComparativa({String? estado, String? anio, String? trimestre}) {
    const String response = '''
    {
      "status": "success",
      "data": {
        "kpi": "Crecimiento Interanual",
        "estado": "Nacional",
        "anioActual": 2024,
        "totalActual": 6061,
        "anioAnterior": 2023,
        "totalAnterior": 5800,
        "tendencia": "ALZA",
        "porcentajeCambio": 4.5
      }
    }
    ''';
    return jsonDecode(response);
  }

  static Map<String, dynamic> getDiasCriticos({String? estado, String? anio, String? trimestre}) {
    const String response = '''
    {
      "status": "success",
      "data": [
        { "dia": "Lunes", "totalEmergencias": 850 },
        { "dia": "Martes", "totalEmergencias": 720 },
        { "dia": "Miércoles", "totalEmergencias": 710 },
        { "dia": "Jueves", "totalEmergencias": 890 },
        { "dia": "Viernes", "totalEmergencias": 1200 },
        { "dia": "Sábado", "totalEmergencias": 1500 },
        { "dia": "Domingo", "totalEmergencias": 1400 }
      ]
    }
    ''';
    return jsonDecode(response);
  }

  static List<String> getEstados() {
    return ['Nacional', 'Ciudad de Mexico', 'Jalisco', 'Nuevo León', 'Chihuahua'];
  }
}

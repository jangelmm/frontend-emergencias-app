import 'dart:convert';

class MockApi {
  // Endpoint 1: Saturación
  static Map<String, dynamic> getSaturacion({
    String? estado,
    String? anio,
    String? trimestre,
  }) {

    final url =
        '/saturacion?estado=$estado&anio=$anio&trimestre=$trimestre';

    print(url);

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
  static Map<String, dynamic> getTendencia({
    String? estado,
    String? anio,
    String? trimestre,
  }) {

    final url =
        '/tendencia?estado=$estado&anio=$anio&trimestre=$trimestre';

    print(url);

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
  static Map<String, dynamic> getProporcion({
    String? estado,
    String? anio,
    String? trimestre,
  }) {

    final url =
        '/proporcion?estado=$estado&anio=$anio&trimestre=$trimestre';

    print(url);

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

  static List<String> getEstados() {

    final data = getSaturacion();

    final estados = data['data']
        .map<String>((item) => item['estado'].toString())
        .toSet()
        .toList();

    estados.sort();

    estados.insert(0, 'Nacional');

    return estados;
  }
}

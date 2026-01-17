import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCuaca {
  static const Map<String, Map<String, double>> cities = {
    'Bandung': {'lat': -6.9147, 'lon': 107.6098},
    'Tasikmalaya': {'lat': -7.3274, 'lon': 108.2207},
    'Jakarta': {'lat': -6.2088, 'lon': 106.8456},
    'Garut': {'lat': -7.2279, 'lon': 107.9087},
    'Sumedang': {'lat': -6.8594, 'lon': 107.9239},
  };

  // Data Cuaca
  static Future<Map<String, dynamic>> fetchCurrent(String city) async {
    final coord = cities[city]!;
    final url =
        'https://api.open-meteo.com/v1/forecast?latitude=${coord['lat']}&longitude=${coord['lon']}&current_weather=true&hourly=relativehumidity_2m';

    final res = await http.get(Uri.parse(url));
    final data = json.decode(res.body);

    final current = data['current_weather'];
    final humidity = data['hourly']['relativehumidity_2m'][0];

    return {
      'temp': current['temperature'],
      'wind': current['windspeed'],
      'code': current['weathercode'],
      'humidity': humidity,
    };
  }

  // Forecasting
  static Future<List<double>> fetchHourlyTemp(String city) async {
    final coord = cities[city]!;
    final url =
      'https://api.open-meteo.com/v1/forecast'
      '?latitude=${coord['lat']}'
      '&longitude=${coord['lon']}'
      '&hourly=temperature_2m'
      '&forecast_days=1';

    final res = await http.get(Uri.parse(url));
    final data = json.decode(res.body);

    final List temps = data['hourly']['temperature_2m'];

    return temps
        .take(24)
        .map((e) => (e as num).toDouble())
        .toList();
  }

  static String weatherLabel(int code) {
    if (code == 0) return 'Cerah';
    if (code <= 3) return 'Berawan';
    if (code >= 61 && code <= 65) return 'Hujan';
    if (code >= 80) return 'Hujan Lebat';
    return 'Lainnya';
  }
}


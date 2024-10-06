import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class NetWorkHelper {
  String baseUrl;
  NetWorkHelper(this.baseUrl);
  // Remplace par ta clé API

  Future getWeatherWithCityName(String appKey, String cityName) async {
    var url = Uri.parse("$baseUrl/weather?q=$cityName&appid=$appKey");
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future getWeatherData() async {
    // Remplace par ta clé API
    var url = Uri.parse(baseUrl);

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // var weatherData = jsonDecode(response.body);

        return jsonDecode(response.body);
      } else {
        print(
            'Erreur lors de la récupération des données météo: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de l\'appel API: $e');
    }
  }
}

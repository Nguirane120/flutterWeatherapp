import 'package:climat/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

const apiKey = '';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? longitude;
  double? latitude;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLocation();
  }

  void getUserLocation() async {
    Location position = Location();
    await position.getcurrentLocation();
    latitude = position.latitude;
    longitude = position.longitude;

    getWeatherData(latitude!, longitude!);
  }

  void getWeatherData(double latitude, double longitude) async {
    String apiKey = dotenv.env['API_KEY'] ?? '';
    String baseUrl = dotenv.env['BASE_URL'] ?? '';
    // Remplace par ta clé API
    var url = Uri.parse(
        '$baseUrl/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        // var weatherData = jsonDecode(response.body);
        print(response.statusCode);
      } else {
        print(
            'Erreur lors de la récupération des données météo: ${response.statusCode}');
      }
    } catch (e) {
      print('Erreur lors de l\'appel API: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              // getUserLocation();
            },
            child: Text("GET LOCATION")),
      ),
    );
  }
}

import 'dart:convert';
import 'package:climat/locationscreen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:climat/location.dart';
import 'package:climat/network.dart';
import 'package:flutter/material.dart';

String apiKey = dotenv.env['API_KEY'] ?? '';
String baseUrl = dotenv.env['BASE_URL'] ?? '';

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
    getUserLocationData();
  }

  void getUserLocationData() async {
    Location position = Location();
    await position.getcurrentLocation();
    latitude = position.latitude;
    longitude = position.longitude;

    // Remplace par ta clé API

    NetWorkHelper netWorkHelper = NetWorkHelper(
        '$baseUrl/weather?lat=$latitude&lon=$longitude&appid=$apiKey');

    var weatherData = await netWorkHelper.getWeatherData();
    // double temperature = decodeData['main']['temp'];
    // int condition = jsonDecode('weather')[0]['id'];
    // String cityName = jsonEncode('name');

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Locationscreen(weatherLocation: weatherData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitWaveSpinner(
        color: Colors.green,
        size: 100.0,
      ),
    ));
  }
}

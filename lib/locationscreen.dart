import 'package:climat/cityscreen.dart';
import 'package:climat/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String apiKey = dotenv.env['API_KEY'] ?? '';
String baseUrl = dotenv.env['BASE_URL'] ?? '';

class Locationscreen extends StatefulWidget {
  const Locationscreen({this.weatherLocation});
  final weatherLocation;
  @override
  State<Locationscreen> createState() => _LocationscreenState();
}

class _LocationscreenState extends State<Locationscreen> {
  late int temperature;
  late int condition;
  late String cityName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUi(widget.weatherLocation);
  }

  void updateUi(dynamic weatherdata) {
    setState(() {
      double temp = weatherdata['main']['temp'];
      temperature = temp.toInt();
      condition = weatherdata['weather'][0]['id'];
      cityName = weatherdata['name'];
    });
    print(weatherdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () async {
                  var typedName = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return Cityscreen();
                  }));
                  if (typedName != null) {
                    var weatherdata = await NetWorkHelper(baseUrl)
                        .getWeatherWithCityName(apiKey, typedName);
                    updateUi(weatherdata);
                  }
                },
                child: Icon(Icons.location_city))
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Temperature:",
                    ),
                    Text(temperature.toString()),
                    Text(
                      "City:",
                    ),
                    Text(cityName)
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

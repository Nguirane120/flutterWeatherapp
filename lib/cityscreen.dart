import 'package:flutter/material.dart';

class Cityscreen extends StatefulWidget {
  const Cityscreen({super.key});

  @override
  State<Cityscreen> createState() => _CityscreenState();
}

class _CityscreenState extends State<Cityscreen> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.all(20.0),
        padding: EdgeInsets.only(top: 5.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                cityName = value;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.location_city_rounded),
                filled: true,
                fillColor: Colors.black,
                hintText: "Enter CityName",
                hintStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
              ),
            ),
            ElevatedButton(
              child: Text("GET WEATHER"),
              onPressed: () {
                Navigator.pop(context, cityName);
              },
            )
          ],
        ),
      ),
    );
  }
}

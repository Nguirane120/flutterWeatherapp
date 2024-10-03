import 'package:geolocator/geolocator.dart';

class Location {
  double? longitude;
  double? latitude;

  Future<void> getcurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Les services de localisation sont désactivés.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('La permission de localisation a été refusée.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'La permission de localisation a été refusée définitivement.');
    }

    try {
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      );

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: locationSettings);

      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      throw e.toString();
    }
  }
}

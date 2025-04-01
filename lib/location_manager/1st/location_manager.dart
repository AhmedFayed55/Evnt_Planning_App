import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      var result =
          await Geolocator.openLocationSettings(); // todo : open location
      //todo: or use Permission handler package
      return Future.error('Location services are disabled.');
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var location = await Geolocator.getCurrentPosition();
    List<Placemark> placemarks =
        await placemarkFromCoordinates(location.latitude, location.longitude);
    if (placemarks.isNotEmpty) {
      log("Country => ${placemarks[0].country}");
      log("Street => ${placemarks[0].street}");
      log("Postal Code => ${placemarks[0].postalCode}");
      log("Locality => ${placemarks[0].locality}");
      log("SubLocality => ${placemarks[0].subLocality}");
    }
    print(
        "==================>>>>>>>>${location.toString()}<<<<<<<<<<<<<<<================");
    return location;
  }
}

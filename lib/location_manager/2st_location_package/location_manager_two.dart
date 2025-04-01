import 'package:location/location.dart';

class LocationManagerTwo {
  Location location = Location();

  bool _serviceEnabled = false;

  PermissionStatus _permissionGranted = PermissionStatus.denied;
  LocationData? _locationData;

  Future<bool> isLocationServiceEnabled() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    }
    return _serviceEnabled;
  }

  Future<bool> isLocationPermissionGranted() async {
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
    }
    return _permissionGranted == PermissionStatus.granted;
  }

  Future<bool> canGetLocation() async {
    final serviceEnabled = await isLocationServiceEnabled();
    final permissionGranted = await isLocationPermissionGranted();
    return serviceEnabled && permissionGranted;
  }

  Future<LocationData> getUserLocation() async {
    _locationData = await location.getLocation();
    return location.getLocation();
  }

  Stream<LocationData> trackLocation() {
    return location.onLocationChanged;
  }
}

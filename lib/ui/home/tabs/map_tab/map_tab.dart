import 'dart:async';

import 'package:evnt_planning_app/location_manager/2st_location_package/location_manager_two.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  LocationManagerTwo locationManagerTwo = LocationManagerTwo();

  // LocationData? userLocationData;

  getUserLocation() async {
    bool canGetLocation = await locationManagerTwo.canGetLocation();
    if (!canGetLocation) {
      return;
    }
    var locationData = await locationManagerTwo.getUserLocation();
    userLocation = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 14.4746,
    );
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
  }

  static const String userLocationId = "user";
  Set<Marker> markers = {
    Marker(
        markerId: MarkerId(userLocationId),
        position:
            LatLng(userLocation.target.latitude, userLocation.target.longitude))
  };

  GoogleMapController? _controller;

  static CameraPosition userLocation = CameraPosition(
    target: LatLng(31.2150913, 29.935676),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: userLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
        markers: markers,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: trackLocation,
        label: const Text('Track Location'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  StreamSubscription<LocationData>? subscription;

  trackLocation() async {
    locationManagerTwo.location.changeSettings(
        accuracy: LocationAccuracy.high, interval: 1000, distanceFilter: 5);
    subscription = locationManagerTwo.trackLocation().listen((locationData) {
      print(locationData.latitude);
      userLocation = CameraPosition(
          target:
              LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
          zoom: 14.4746);
      markers.add(Marker(
          markerId: MarkerId(userLocationId), position: userLocation.target));
      _controller?.animateCamera(CameraUpdate.newCameraPosition(userLocation));
      setState(() {});
    });
  }

  @override
  void dispose() {
    //todo : it works when screen get closed
    // TODO: implement dispose
    super.dispose();
    subscription?.cancel();
  }
}

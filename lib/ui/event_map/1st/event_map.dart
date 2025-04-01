import 'package:evnt_planning_app/location_manager/1st/location_manager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMap extends StatefulWidget {
  const EventMap({super.key});

  @override
  State<EventMap> createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  var initialCameraPosition =
      const CameraPosition(zoom: 16, target: LatLng(30.12, 35.2));
  late GoogleMapController _controller;
  Marker currentLocationMarker =
      Marker(markerId: MarkerId("1"), position: LatLng(30.12, 35.2));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          onMapCreated: (controller) {
            _controller = controller;
          },
          markers: {currentLocationMarker},
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          zoomControlsEnabled: false,
          key: UniqueKey(),
          initialCameraPosition: initialCameraPosition),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          var location = await LocationManager.getCurrentLocation();
          _listenOnLocationChanged();
          initialCameraPosition = CameraPosition(
              zoom: 16, target: LatLng(location.latitude, location.longitude));
          currentLocationMarker = Marker(
              markerId: MarkerId("1"),
              position: LatLng(location.latitude, location.longitude));
          _controller.animateCamera(
              CameraUpdate.newLatLngZoom(initialCameraPosition.target, 14));
          setState(() {});
        },
        child: const Icon(
          Icons.location_searching_rounded,
        ),
      ),
    );
  }

  _listenOnLocationChanged() {
    var stream = Geolocator.getPositionStream(
        locationSettings: LocationSettings(
      timeLimit: Duration(seconds: 5),
    ));
    stream.listen(
      (Position newLocation) {
        print(newLocation);
        var newLatLng = LatLng(newLocation.latitude, newLocation.longitude);
        _controller.animateCamera(CameraUpdate.newLatLngZoom(newLatLng, 15));
        currentLocationMarker =
            Marker(markerId: MarkerId("1"), position: newLatLng);
        setState(() {});
      },
    );
  }
}

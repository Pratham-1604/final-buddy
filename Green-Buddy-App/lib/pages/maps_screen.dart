import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/place.dart';

class MapScreen extends StatelessWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  static const routeName = '/mapScreen';

  MapScreen({
    this.initialLocation = const PlaceLocation(
      latitude: 19.12363486868719,
      longitude: 72.83601543890362,
    ),
    this.isSelecting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            initialLocation.latitude,
            initialLocation.latitude,
          ),
          zoom: 5,
        ),
        markers: {
          Marker(
            markerId: MarkerId('m1'),
            position: LatLng(
              initialLocation.latitude,
              initialLocation.longitude,
            ),
          ),
        },
      ),
    );
  }
}

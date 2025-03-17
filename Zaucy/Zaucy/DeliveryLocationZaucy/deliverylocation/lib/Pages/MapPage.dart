import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

BitmapDescriptor logo = BitmapDescriptor.defaultMarker;

class Mappage extends StatefulWidget {
  const Mappage({super.key});

  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  void _getCustomMarker() async {
    logo = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)), // Adjust size
      "assets/logo.png", // Your image file in assets
    );
    setState(() {});
  }

  void _getvalue() {
    _getCustomMarker();
  }

  void initState() {
    super.initState();
    _getvalue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 400, // Set your preferred height
            width: double.infinity, // Take full width
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(18.5204, 73.8567), // Example: Mumbai
                  zoom: 10),
              mapType: MapType.normal, // Standad Map
              myLocationEnabled: true, // Show user location
              zoomControlsEnabled: true,
              markers: {
                Marker(
                    markerId: MarkerId("pinpoint"),
                    position: LatLng(18.5193636, 73.9325621),
                    infoWindow: InfoWindow(title: "Exact Location"),
                    icon: logo),
              }, // Show zoom buttons
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:deliverylocation/Models/Deliverylocation.dart';
import 'package:deliverylocation/Services/Apiservices.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool isTracking = false; // To track if location updates are running
  Timer? locationTimer;
  int? idfull = 0;
  void initState() {
    super.initState();
    createInitialLocation();
  }

  void createInitialLocation() async {
    DeliveryBoyLocation location = DeliveryBoyLocation(
      latitude: 0.0,
      longitude: 0.0,
    );

    idfull = await DeliveryBoyService.createLocation(location);
    if (idfull != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('horaha')),
      );
      print("Initial location created successfully.");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nhi horaha')),
      );
      print("Failed to create initial location.");
    }
  } // Timer to send location updates

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Delivery Partner"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startLocationUpdates,
              child: Text("START LOCATION SENDING"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: stopLocationUpdates,
              child: Text("STOP LOCATION SENDING"),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Start Sending Location
  void startLocationUpdates() async {
    bool serviceEnabled;
    LocationPermission permission;

    // ✅ Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enable location services.")),
      );
      return;
    }

    // ✅ Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location permission denied.")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Location permission permanently denied.")),
      );
      return;
    }

    setState(() {
      isTracking = true;
    });

    // 🔁 Send location updates every 5 seconds
    locationTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      if (!isTracking) return;

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      DeliveryBoyLocation location = DeliveryBoyLocation(
        deliveryBoyId: 1, // Set the correct deliveryBoyId
        latitude: position.latitude,
        longitude: position.longitude,
      );

      bool success = await DeliveryBoyService.updateLocation(location);

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Location updates started.")),
        );
      } else {}
    });
  }

  // 🔹 Stop Sending Location
  void stopLocationUpdates() {
    setState(() {
      isTracking = false;
    });
    locationTimer?.cancel();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Location updates stopped.")),
    );
  }
}

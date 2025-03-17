import 'dart:async';
import 'dart:convert';
import 'dart:ffi' as ffi;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zaucy/Entities/DeliveryLocation.dart';
import 'package:zaucy/Entities/Order.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/Orderplaced.dart';
import 'package:zaucy/Services/locationServices.dart';
import 'package:zaucy/main.dart';

BitmapDescriptor logo = BitmapDescriptor.defaultMarker;

class Mappage extends StatefulWidget {
  final Order PlacedOrder; // Update to Menu type, not dynamic

  Mappage({required this.PlacedOrder});

  @override
  State<Mappage> createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  bool isTracking = false; // To track if location updates are running
  Timer? locationTimer;
  late Position position = Position(
    latitude: 0.0, // Default latitude
    longitude: 0.0, // Default longitude
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
    altitudeAccuracy: 0.0,
    headingAccuracy: 0.0,
  );
  late GoogleMapController _mapController;
  DeliveryBoyService deliveryBoyService = DeliveryBoyService();
  TimeOfDay now = TimeOfDay.now();
  double Distance22 = 0.0;
  double duration22 = 0.0;
  final Set<Polyline> _polylines = {};
  late Order PlacedOrder; // Update to Menu type, not dynamic

  DeliveryBoyLocation? deliveryBoyLocation =
      DeliveryBoyLocation(latitude: 0, longitude: 0);
  void _getCustomMarker() async {
    logo = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(48, 48)), // Adjust size
      "assets/logo.png", // Your image file in assets
    );
    setState(() {});
  }

  void _goToLocation() {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: new LatLng(
              deliveryBoyLocation!.latitude, deliveryBoyLocation!.longitude),
          zoom: 14.0,
          tilt: 45.0, // Optional, for cool 3D effect
          bearing: 90.0, // Optional, to rotate the map
        ),
      ),
    );
  }

  void _setPolyline() {
    setState(() {
      _polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: [
            LatLng(position.latitude, position.longitude),
            LatLng(
                deliveryBoyLocation!.latitude, deliveryBoyLocation!.longitude)
          ],
          color: Colors.blue,
          width: 5,
        ),
      );
    });
  }

  void _getvalue() {
    _getCustomMarker();
  }

  void fetchDistance() async {
    double? distance = await deliveryBoyService.getDistance(
        deliveryBoyLocation!.latitude,
        deliveryBoyLocation!.longitude,
        position.latitude,
        position.longitude);
    if (distance != null) {
      setState(() {
        Distance22 = distance;
      });
      setState(() {});
      print('Distance: $distance km');
    } else {
      print('Failed to get distance');
    }
  }

  void fetchDuration() async {
    double? duration = await deliveryBoyService.getDuration(
        deliveryBoyLocation!.latitude,
        deliveryBoyLocation!.longitude,
        position.latitude,
        position.longitude);
    if (duration != null) {
      setState(() {
        duration22 = duration;
      });
      setState(() {});
      print('Durtaiion: $duration min');
    } else {
      print('Failed to get distance');
    }
  }

  Future<void> _callNumber(String number) async {
    var url = Uri.parse("tel:$number");
    if (await canLaunchUrl(url)) {
      print("hello");
      await launchUrl(url);
    } else {
      print("nohello");
      throw 'Could not launch $number';
    }
  }

  Future<void> _launchWebsite() async {
    final Uri url = Uri.parse('https://www.google.com');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print('Could not launch website');
    }
  }

  void getlocationupdate() async {
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
    locationTimer = Timer.periodic(Duration(seconds: 5), (timer) async {
      if (!isTracking) return;

      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      _setPolyline();

      deliveryBoyLocation = await DeliveryBoyService.getLocation(1);
      fetchDistance();
      fetchDuration();
      _goToLocation();
      setState(() {
        now = TimeOfDay.now();
      });

      if (deliveryBoyLocation != null) {
      } else {}
    });
  }

  void initState() {
    super.initState();
    PlacedOrder = widget.PlacedOrder;
    _getvalue();
    getlocationupdate();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, Object? result) {
        if (didPop) {
          Navigator.pop(context);
        } else {}
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OrderPlacedPage(PlacedOrder: PlacedOrder)));
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 500,
              width: double.infinity, // Take full width
              child: GoogleMap(
                myLocationButtonEnabled: true,
                trafficEnabled: true,
                onMapCreated: (controller) => _mapController = controller,
                initialCameraPosition: CameraPosition(
                    target: LatLng(18.5204, 73.8567), // Example: Mumbai
                    zoom: 10),
                mapType: MapType.normal, // Standad Map
                myLocationEnabled: true, // Show user location
                zoomControlsEnabled: true,
                polylines: _polylines,
                markers: {
                  Marker(
                      markerId: MarkerId("pinpoint"),
                      position: LatLng(deliveryBoyLocation!.latitude,
                          deliveryBoyLocation!.longitude),
                      infoWindow:
                          InfoWindow(title: "Delivery Partner Location"),
                      icon: logo),
                  Marker(
                      markerId: MarkerId("OwnLocation"),
                      position: LatLng(position.latitude, position.longitude),
                      infoWindow:
                          InfoWindow(title: "Delivery Partner Location"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                          BitmapDescriptor.hueRose))
                },
              ),
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name:Rakesh Kumar",
                    style: GoogleFonts.akshar(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Row(
                    children: [
                      Text(
                        "Contact Number: ",
                        style: GoogleFonts.akshar(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      GestureDetector(
                        onTap: () {
                          _callNumber("+918605344200");
                        },
                        child: Text(
                          "8605344200",
                          style: GoogleFonts.akshar(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.blue.shade800),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("Remaining Distance for Delivery:"),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${Distance22.toStringAsFixed(4)}km",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text("Estimated Time for Delivery:"),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${duration22.toStringAsFixed(4)} min",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MapView extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapView({super.key, required this.latitude, required this.longitude});

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  String? address; // Holds the fetched address from the API
  String? title; // Holds the fetched title from the API
  String apiUrl =
      'https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json'; // API endpoint

  @override
  void initState() {
    super.initState();
    _getAddressAndTitleFromCoordinates();
  }

  // Fetches address and title from the API based on the provided latitude and longitude
  Future<void> _getAddressAndTitleFromCoordinates() async {
    try {
      String url = '$apiUrl?lat=${widget.latitude}&lng=${widget.longitude}';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        String formattedAddress = jsonData['address'];
        String hotelTitle = jsonData['title'];
        setState(() {
          address = formattedAddress;
          title = hotelTitle;
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng hotelLocation = LatLng(widget.latitude, widget.longitude);

    return Scaffold(
      appBar: AppBar(title: const Text('Hotel Map')),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: hotelLocation,
              zoom: 15,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('hotel'),
                position: hotelLocation,
                infoWindow: InfoWindow(
                  title: 'Hotel Location',
                  snippet: address ??
                      'Loading address...', // Shows the address in the marker's info window
                ),
                onTap: () {
                  _showDialog(); // Shows the dialog box with the fetched address and title when the marker is tapped
                },
              ),
            },
          ),
        ],
      ),
    );
  }

  // Shows a dialog box with the fetched title and address
  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title ?? ''), // Display the fetched title in the dialog
          content: Text(address ??
              'Loading address...'), // Display the fetched address in the dialog
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Close the dialog box when the "Close" button is pressed
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

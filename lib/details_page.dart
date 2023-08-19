import 'package:flutter/material.dart';
import 'package:project/users_hotels.dart';
import 'MapView.dart'; // Import the MapView widget

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key, required this.usersHotels}) : super(key: key);
  final Datum usersHotels;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${usersHotels.title}'s"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            // Display the hotel's image in a circular avatar
            CircleAvatar(
              radius: 152,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 150,
                backgroundImage: NetworkImage(usersHotels.image.medium),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Display the hotel's title as a bold text
            Text(
              usersHotels.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: Column(
                children: [
                  // Display the hotel's description
                  Text(
                    usersHotels.description,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const SizedBox(
              height: 20,
            ),
            // Display the hotel's postcode
            Row(
              children: [
                const Text("Hotel Post Code -",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Text(
                      usersHotels.postcode,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Display the hotel's phone number
            Row(
              children: [
                const Text("Hotel Phone number -",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  width: 5,
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      usersHotels.phoneNumber,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      // Floating action button to open the map view
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //Navigate to the map view passing the hotel's latitude and longitude as parameters
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MapView(
                latitude: double.parse(usersHotels.latitude),
                longitude: double.parse(usersHotels.longitude),
              ),
            ),
          );
        },
        child: Icon(Icons.map),
      ),
    );
  }
}

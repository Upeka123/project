import 'package:flutter/material.dart';
import 'package:project/authController.dart';
import 'package:project/details_page.dart';
import 'package:http/http.dart' as http;
import 'package:project/users_hotels.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // For holding response as UsersHotel
  late UsersHotels usersHotels;
  // for data is loaded flag
  bool isDataLoaded = false;
  // error holding
  String errorMessage = '';

  // API Call
  Future<UsersHotels> getDataFromAPI() async {
    Uri uri = Uri.parse(
        'https://dl.dropboxusercontent.com/s/6nt7fkdt7ck0lue/hotels.json');
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      // All ok
      UsersHotels usersHotels = usersHotelsFromJson(response.body);
      setState(() {
        isDataLoaded = true;
      });
      return usersHotels;
    } else {
      // Handle API error and return an empty UsersHotels object
      errorMessage = '${response.statusCode}: ${response.body} ';
      return UsersHotels(status: 0, data: []);
    }
  }

  // Function to call API and assign data to usersHotels
  callAPIandAssignData() async {
    usersHotels = await getDataFromAPI();
  }

  @override
  void initState() {
    // Call the API and assign data when the widget is initialized
    callAPIandAssignData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Perform user logout when the logout button is pressed
              AuthController.instance.logOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          // Display user's welcome message and email
          const Text(
            "Welcome",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.email,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: !isDataLoaded
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : errorMessage.isNotEmpty
                    ? Center(
                        child: Text(
                            errorMessage)) // Show error message if API call fails
                    : usersHotels.data.isEmpty
                        ? const Text('No Data')
                        : ListView.builder(
                            // Display the list of hotels
                            itemCount: usersHotels.data.length,
                            itemBuilder: (context, index) => getMyRow(index),
                          ),
          ),
        ],
      ),
    );
  }

// Widget to create a row for each hotel item in the list
  Widget getMyRow(int index) {
    return Card(
      child: ListTile(
        onTap: () {
          // Navigate to the DetailsPage when a hotel item is tapped
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  DetailsPage(usersHotels: usersHotels.data[index]),
            ),
          );
        },
        leading: CircleAvatar(
          // Display the hotel's image as the leading avatar
          backgroundImage: NetworkImage(usersHotels.data[index].image.large),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the hotel's title with bold text
            Text(
              usersHotels.data[index].title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            // Display the hotel's address
            Text('Address: ${usersHotels.data[index].address}'),
          ],
        ),
      ),
    );
  }
}

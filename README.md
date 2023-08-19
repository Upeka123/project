# project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

**Project Assumptions:**

1. The provided API endpoint returns a JSON object containing the `address` and `title` fields for a given latitude and longitude.
2. The API endpoint is accessible and returns the expected data in the correct format (JSON).
3. The provided images for the hotel markers exist in the specified locations and are correctly named.
4. The `AuthController` class handles user authentication and registration using Firebase.
5. The project uses the `get` package for state management and navigation.

**Project Improvements:**

1. Used the `http` package to fetch address and title data from the API, instead of using the `geocoding` package, to simplify the code and handle both address and title in a single API call.
2. Added a dialog box to the marker icon, displaying the fetched hotel title and address when tapped on the map.
3. Used shared preferences to cache the address data and reduce loading time.

**Testing the Project on a New Machine:**

To test the project on a new machine, follow these steps:

1. Set up Flutter on the new machine by following the Flutter installation guide: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
2. Clone the project's codebase from a version control repository or copy the project folder to the new machine.
3. Open the project in an IDE or code editor (e.g., Android Studio, Visual Studio Code).
4. Ensure that you have a valid API key or access to the API endpoint mentioned in the `MapView` widget. If not, you may need to replace the `apiUrl` variable with a valid endpoint that returns the required data (address and title) in JSON format.
5. Set up Firebase on the new machine and replace the `google-services.json` file in the `android/app` directory with your Firebase project configuration file.
6. Ensure that all required packages are installed. Run `flutter pub get` in the project directory to fetch and install the required packages listed in `pubspec.yaml`.
7. Connect a physical device or emulator to the new machine.
8. Run the project using `flutter run` in the project directory or click the "Run" button in the IDE to launch the app on the connected device/emulator.
9. The app should now start and show the login screen. You can test the login, registration, and logout functionality with Firebase authentication.
10. Navigate to the home page and the hotel details page to check if the hotel data is displayed correctly. Additionally, tapping on the hotel marker on the map should display the relevant address and title in a dialog box.

**Note:** Ensure that you have valid internet connectivity on the new machine, as the app may require an internet connection to fetch data from the API and Firebase services.

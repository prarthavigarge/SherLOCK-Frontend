import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sherlock_frontend/screens/LandingScreen.dart';

// Main function which starts the app
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

// Top of the widgets, where the app starts
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'sherLOCK',
        theme: ThemeData(
          primarySwatch: Colors.blue, // Theme color set is blue
          fontFamily: GoogleFonts.montserrat().fontFamily, // Montserrat is set as the standard font across the app
        ),
        home: LandingScreen()); // Landing Screen is set as homepage
  }
}

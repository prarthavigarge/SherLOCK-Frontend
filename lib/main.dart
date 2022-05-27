import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sherlock_frontend/screens/LandingScreen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
        home: LandingScreen());
  }
}

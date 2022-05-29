import 'dart:async';

import 'package:flutter/material.dart';

class Loader extends StatefulWidget {
  Loader({Key? key}) : super(key: key);

  @override
  State<Loader> createState() => _LoaderState();
}

class _LoaderState extends State<Loader> {
  Timer? t;
  // messages to iterate through
  List<String> messages = [
    "Scanning the face",
    "Trying to find a match",
    "Comparing to criminal database"
  ];
  int messageIndex = 0;
  @override
  void initState() {
    super.initState();
    // Timer which changes the displayed message every second
    t = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        messageIndex = (messageIndex + 1) % messages.length;
      });
    });
  }

  @override
  void dispose() {
    if (t != null) t!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Will Pop Scope doesnt allow the user to go back via button press when loader is on
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/scan.gif",
                width: 100,
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Text(
                  messages[messageIndex],
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

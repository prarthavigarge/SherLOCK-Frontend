import 'dart:io';

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sherlock_frontend/components/CrimeCard.dart';
import 'package:sherlock_frontend/screens/InstructionsScreen.dart';

class MatchResultsScreen extends StatefulWidget {
  MatchResultsScreen(
      {Key? key, required this.match, this.image, this.criminal, this.uploaded})
      : super(key: key);
  final match;
  final image;
  final criminal;
  final uploaded;

  @override
  State<MatchResultsScreen> createState() => _MatchResultsScreenState();
}

class _MatchResultsScreenState extends State<MatchResultsScreen> {
  bool success = false;
  Color? color;
  List<Widget> crimes = [];
  @override
  void initState() {
    super.initState();
    success = widget.match;
    if (success) {
      for (var crime in widget.criminal['crimes']) {
        crimes.add(CrimeCard(
          title: crime,
        ));
      }
      var danger = widget.criminal['dangerLevel'];
      if (danger <= 25) {
        color = Colors.yellow;
      } else if (danger <= 50) {
        color = Colors.orange;
      } else if (danger <= 75) {
        color = Colors.orange[900];
      } else {
        color = Colors.red[700];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: success
          ? null
          : Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 85,
              child: FloatingActionButton(
                  isExtended: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.lightBlueAccent[200],
                  onPressed: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InstructionsScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Try Again",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
          backgroundColor: Colors.grey[800],
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: !success
          ? FailedMatchScreen()
          : Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[800],
              child: ListView(
                children: <Widget>[
                  Center(
                    child: Text(
                      "Match Found",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 39.0),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child:
                          ListView(scrollDirection: Axis.horizontal, children: [
                        Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Our Match",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: CircularPercentIndicator(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      lineWidth: 15,
                                      backgroundColor: Colors.grey[800]!,
                                      progressColor: color,
                                      percent:
                                          widget.criminal['dangerLevel'] / 100,
                                      center: CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.265,
                                        backgroundImage:
                                            NetworkImage(widget.image),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Uploaded Picture",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30.0),
                                    child: CircularPercentIndicator(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      lineWidth: 15,
                                      percent:
                                          widget.criminal['dangerLevel'] / 100,
                                      backgroundColor: Colors.grey[800]!,
                                      progressColor: color,
                                      center: CircleAvatar(
                                        radius:
                                            MediaQuery.of(context).size.width *
                                                0.265,
                                        backgroundImage:
                                            FileImage(File(widget.uploaded)),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ]),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Swipe to compare",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Center(
                      child: Text(
                          'Danger Level: ' +
                              widget.criminal['dangerLevel'].toString() +
                              "%",
                          style: TextStyle(color: color))),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Text("Crimes Committed",
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: <Widget>[...crimes],
                    ),
                  ),
                ],
              )),
    );
  }
}

class FailedMatchScreen extends StatelessWidget {
  const FailedMatchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[800],
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.075),
              child: Image.asset("assets/try.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text("No Match Found",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w500)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  "Try rescanning or uploading a better or different picture of the suspect.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
            )
          ],
        ));
  }
}

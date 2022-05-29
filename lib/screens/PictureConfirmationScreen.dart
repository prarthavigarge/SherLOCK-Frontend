import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sherlock_frontend/components/loader.dart';
import 'package:sherlock_frontend/screens/MatchResultsScreen.dart';
import 'package:sherlock_frontend/utils/https.utils.dart';
import 'package:sherlock_frontend/utils/snackbar.utils.dart';

// This screen has the main purpose of letting the user confirm what image they have chose
// Request is fired from this screen

class PictureConfirmationScreen extends StatefulWidget {
  PictureConfirmationScreen({Key? key, required this.imagePath})
      : super(key: key);
  final String imagePath;

  @override
  State<PictureConfirmationScreen> createState() =>
      _PictureConfirmationScreenState();
}

class _PictureConfirmationScreenState extends State<PictureConfirmationScreen> {
  bool loading = false; // loading variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: loading
          ? null // if some processing is being done where loading is going on, we hide the button
          // else we display the upload button
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
                    try {
                      // we set loading to true
                      setState(() {
                        loading = true;
                      });
                      // getting the image from the path
                      File image = File(widget.imagePath);
                      // we upload the file to the backend server and wait for the response
                      final resp = jsonDecode(await asyncFileUpload(image));
                      // if a match was found ( Criminal Found )
                      if (resp['match'] == true) {
                        // We move to the results screen with:
                        // image of the criminal from our database
                        // image uploaded
                        // details like dangerLevel and crimes in "criminal" json
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MatchResultsScreen(
                                match: resp['match'],
                                image: resp['image'],
                                criminal: resp['criminal'],
                                uploaded: widget.imagePath),
                          ),
                        );
                      } else if (resp['success'] == false) {
                        // if no face was detected in the image uploaded we display the message
                        showSnackbar(context, resp['message']);
                      } else if (resp['match'] == false) {
                        // face was detected, but no criminal match was found, we return false match to the next screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MatchResultsScreen(
                              match: false,
                            ),
                          ),
                        );
                      } 
                      // catching any errors in the http call
                    } catch (e) {
                      print(e);
                      showSnackbar(
                          context, "There was an error uploading the image");
                    }
                    // setting loading to false at the end
                    setState(() {
                      loading = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: loading
          ? null // back button hidden on loading
          : AppBar(
             // back button
              backgroundColor: Colors.grey[800],
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
      body: loading
          ? Loader() // displays the loader in the body
          : Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[800],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
                    // Rounded Image that was uploaded
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Image.file(
                          File(
                            widget.imagePath,
                          ),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}

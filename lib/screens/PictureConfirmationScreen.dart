import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sherlock_frontend/components/loader.dart';
import 'package:sherlock_frontend/screens/MatchResultsScreen.dart';
import 'package:sherlock_frontend/utils/https.utils.dart';
import 'package:sherlock_frontend/utils/snackbar.utils.dart';

class PictureConfirmationScreen extends StatefulWidget {
  PictureConfirmationScreen({Key? key, required this.imagePath})
      : super(key: key);
  final String imagePath;

  @override
  State<PictureConfirmationScreen> createState() =>
      _PictureConfirmationScreenState();
}

class _PictureConfirmationScreenState extends State<PictureConfirmationScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: loading
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
                    try {
                      setState(() {
                        loading = true;
                      });
                      File image = File(widget.imagePath);
                      final resp = jsonDecode(await asyncFileUpload(image));
                      if (resp['match'] == true) {
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
                        showSnackbar(context, resp['message']);
                      } else if (resp['match'] == false) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MatchResultsScreen(
                              match: false,
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                      showSnackbar(
                          context, "There was an error uploading the image");
                    }
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
          ? null
          : AppBar(
              backgroundColor: Colors.grey[800],
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              )),
      body: loading
          ? Loader()
          : Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[800],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.1),
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

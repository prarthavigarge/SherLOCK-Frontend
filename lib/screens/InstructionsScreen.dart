import 'package:flutter/material.dart';
import 'package:sherlock_frontend/components/SherLOCK.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherlock_frontend/screens/PictureConfirmationScreen.dart';

// This Screen contains the instructions on using this app as well as the functionality to take/upload an image

class InstructionsScreen extends StatefulWidget {
  InstructionsScreen({Key? key}) : super(key: key);

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  XFile? imageFile; // hold the image taken/uploaded by user

  // Uses the image_picker package to take/upload an image
  Future imageSelector(BuildContext context, String pickerType) async {
    // ImageSource.camera opens up the camera
    // ImageSource.gallery opens up the gallery
    imageFile = await ImagePicker().pickImage(
      source: pickerType == 'camera' ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 25, // reduces the quality to 25% of original to prevent heavy files to get uploaded
    );

    // if flutter picks up an image
    if (imageFile != null) {
      print("You selected  image : " + imageFile!.path);
      // we take the image path and pass it onto the next screen
      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                PictureConfirmationScreen(imagePath: imageFile!.path)),
      );
    } else {
      print("You have not taken image");
    }
  }

  // This function triggers a modal which pops up from bottom and lets the user select
  // what mode of upload they can choose from
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                    title: new Text('Gallery'),
                    onTap: () async {
                      imageSelector(context, "gallery");
                      Navigator.pop(context);
                    }),
                new ListTile(
                  title: new Text('Camera'),
                  onTap: () async {
                    imageSelector(context, "camera");
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 85,
        // Scan button which lets user select the image
        child: FloatingActionButton(
            isExtended: true,
            backgroundColor: Colors.lightBlueAccent[200],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            onPressed: () {
              _settingModalBottomSheet(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.document_scanner_outlined,
                  color: Colors.black87,
                  size: 33,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "Scan",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            )),
      ),
      // sets location of the scan button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // main body of the screen
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[900],
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.175),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SherLOCKText(), // styled product name
              // motto
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Your safety is our priority",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                    color: Colors.white,
                  ),
                ),
              ),
              // instruction
              Padding(
                padding: const EdgeInsets.only(top: 68.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    "Tap on the scan button below to take or upload a picture of the suspect",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              // asset of a dog sniffing footsteps
              Image.asset(
                "assets/dog.png",
                width: MediaQuery.of(context).size.width * 0.8,
                height: 200,
              )
            ],
          ),
        ),
      ),
    );
  }
}

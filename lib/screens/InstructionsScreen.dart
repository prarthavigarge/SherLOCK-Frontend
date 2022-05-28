import 'package:flutter/material.dart';
import 'package:sherlock_frontend/components/SherLOCK.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sherlock_frontend/screens/PictureConfirmationScreen.dart';

class InstructionsScreen extends StatefulWidget {
  InstructionsScreen({Key? key}) : super(key: key);

  @override
  State<InstructionsScreen> createState() => _InstructionsScreenState();
}

class _InstructionsScreenState extends State<InstructionsScreen> {
  XFile? imageFile;

  Future imageSelector(BuildContext context, String pickerType) async {
    imageFile = await ImagePicker().pickImage(
      source: pickerType == 'camera' ? ImageSource.camera : ImageSource.gallery,
      imageQuality: 25,
    );

    if (imageFile != null) {
      print("You selected  image : " + imageFile!.path);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[900],
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.175),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SherLOCKText(),
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

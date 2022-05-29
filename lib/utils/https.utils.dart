import 'dart:io';
import 'package:http/http.dart' as http;

// Route to upload image file to datavase
Future asyncFileUpload(File imageFile) async {
  var request = http.MultipartRequest("POST",
      Uri.parse("https://sherlockbackend.herokuapp.com/findCriminal")); // Database URL
  var pic = await http.MultipartFile.fromPath("file", imageFile.path);
  request.files.add(pic); // adding picture to multipart request
  var response = await request.send(); // waiting for response
  var responseData = await response.stream.toBytes();
  var responseString = String.fromCharCodes(responseData);
  print(responseString);
  return responseString;
}

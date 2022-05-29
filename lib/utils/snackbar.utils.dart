import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Displays message to the user
showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
  ));
}

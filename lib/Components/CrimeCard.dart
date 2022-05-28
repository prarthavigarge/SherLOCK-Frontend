import 'package:flutter/material.dart';

class CrimeCard extends StatelessWidget {
  const CrimeCard({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 9),
            child: Text(title, style: TextStyle(color: Colors.white)),
          )),
    );
  }
}

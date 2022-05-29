import 'package:flutter/material.dart';

// contains styled name of the app
class SherLOCKText extends StatelessWidget {
  const SherLOCKText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'sher',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        children: [
          TextSpan(
            text: 'LOCK',
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

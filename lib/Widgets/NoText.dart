import 'package:flutter/material.dart';

class NoText extends StatelessWidget {
  final String text;
  bool noBg = false;
  NoText ({super.key, required this.text, this.noBg = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 7, bottom: 7, left: 23, right: 23),
      decoration: BoxDecoration(
      color: !noBg ? Colors.blueGrey.shade50 : Colors.transparent,
      borderRadius: BorderRadius.circular(100)
      ),
      child: Text(text, style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.blueGrey,
      )),
    );
  }
}

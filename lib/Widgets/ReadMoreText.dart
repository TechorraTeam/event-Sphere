import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReadMoreText extends StatefulWidget {
  final String text;

  const ReadMoreText({super.key, required this.text});

  @override
  _ReadMoreTextState createState() => _ReadMoreTextState();
}

class _ReadMoreTextState extends State<ReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    List<String> words = widget.text.split(' ');

    String visibleText = _isExpanded
        ? widget.text
        : words.take(20).join(' ') + (words.length > 20 ? ' ' : '');

    return RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 18, color: Colors.blueGrey, fontWeight: FontWeight.w500),
        children: [
          TextSpan(text: visibleText),
          if (words.length > 20)
            TextSpan(
              text: _isExpanded ? ' Read Less' : ' Read More...',
              style: TextStyle(color: Colors.deepOrange),
              recognizer: TapGestureRecognizer()..onTap = () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
        ],
      ),
    );
  }
}

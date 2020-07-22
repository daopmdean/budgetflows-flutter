import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SubmitButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;
  final double fontSize;

  const SubmitButton({
    @required this.onPressed,
    @required this.buttonText,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        buttonText,
        style: TextStyle(
          color: Colors.green,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          fontFamily: 'Montserrat',
        ),
      ),
      onPressed: onPressed,
    );
  }
}

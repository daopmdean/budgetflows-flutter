import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;

  const InputField(
      {@required this.hintText,
      @required this.onChanged,
      this.obscureText,
      this.keyboardType,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 5,
        bottom: 5,
      ),
      child: TextField(
        textAlign: TextAlign.center,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 18,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

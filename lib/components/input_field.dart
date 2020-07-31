import 'package:budget_flows/constants.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hintText;
  final Function onChanged;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextEditingController controller;
  final Function validator;

  const InputField(
      {@required this.hintText,
      @required this.onChanged,
      this.obscureText,
      this.keyboardType,
      this.controller,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 5,
        bottom: 5,
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 18,
          ),
          enabledBorder: kEnabledBorder,
          focusedBorder: kFocusedBorder,
          errorBorder: kErrorBorder,
          focusedErrorBorder: kFocusedErrorBorder,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}

import 'package:budget_flows/components/input_field.dart';
import 'package:budget_flows/components/submit_button.dart';
import 'package:budget_flows/models/user.dart';
import 'package:budget_flows/screens/add_record_screen.dart';
import 'package:budget_flows/services/alert.dart';
import 'package:budget_flows/services/arguments.dart';
import 'package:flutter/material.dart';
import 'package:budget_flows/services/util.dart' as util;

class RegisterScreen extends StatelessWidget {
  static final String route = 'register';

  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    String confirm;
    String fullName;
    String phone;
    final _formkey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                InputField(
                  hintText: 'Email',
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (String value) {
                    RegExp exp = new RegExp(r"\w+\@\w+\.\w+");
                    if (!exp.hasMatch(value)) {
                      return 'Please provide a valid email';
                    }
                    return null;
                  },
                ),
                InputField(
                  hintText: 'Password',
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please provide password';
                    }
                    return null;
                  },
                ),
                InputField(
                  hintText: 'Confirm',
                  obscureText: true,
                  onChanged: (value) {
                    confirm = value;
                  },
                  validator: (String value) {
                    if (confirm != password) {
                      return 'Confirm must match password';
                    }
                    if (value.isEmpty) {
                      return '';
                    }

                    return null;
                  },
                ),
                InputField(
                  hintText: 'Full name',
                  onChanged: (value) {
                    fullName = value;
                  },
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please enter your fullname';
                    }
                    return null;
                  },
                ),
                InputField(
                  hintText: 'Phone number',
                  onChanged: (value) {
                    phone = value;
                  },
                  validator: (String value) {
                    RegExp exp = new RegExp(r"^0\d{9}$");
                    if (!exp.hasMatch(value)) {
                      return 'Please provide a valid phone number';
                    }
                    return null;
                  },
                ),
                SubmitButton(
                  buttonText: 'Register',
                  fontSize: 20,
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      User newUser = User(
                        email: email,
                        password: password,
                        fullName: fullName,
                        phone: phone,
                      );
                      bool canRegister = await util.register(newUser);
                      if (canRegister) {
                        Navigator.pushNamed(
                          context,
                          AddRecordScreen.route,
                          arguments: AppArguments(email),
                        );
                      } else {
                        AlertPopUp.announceRegisterFail(
                          context,
                          'Email already exist!',
                        ).show();
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

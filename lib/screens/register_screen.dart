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

    return Scaffold(
      body: SafeArea(
        child: Center(
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
              ),
              InputField(
                hintText: 'Password',
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              InputField(
                hintText: 'Confirm',
                obscureText: true,
                onChanged: (value) {
                  confirm = value;
                },
              ),
              InputField(
                hintText: 'Full name',
                onChanged: (value) {
                  fullName = value;
                },
              ),
              InputField(
                hintText: 'Phone number',
                onChanged: (value) {
                  phone = value;
                },
              ),
              SubmitButton(
                buttonText: 'Register',
                fontSize: 20,
                onPressed: () async {
                  if (email == null || fullName == null || phone == null) {
                    AlertPopUp.announceRegisterFail(
                      context,
                      'Please fill all the information!',
                    ).show();
                  }

                  if (email.trim() == '' ||
                      fullName.trim() == '' ||
                      phone.trim() == '') {
                    AlertPopUp.announceRegisterFail(
                      context,
                      'Please fill all the information!',
                    ).show();
                  }
                  if (password != confirm) {
                    AlertPopUp.announceRegisterFail(
                      context,
                      'Confirm must match password',
                    ).show();
                    return;
                  }
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
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

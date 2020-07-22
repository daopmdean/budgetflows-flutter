import 'package:budget_flows/components/input_field.dart';
import 'package:budget_flows/components/submit_button.dart';
import 'package:budget_flows/screens/add_record_screen.dart';
import 'package:budget_flows/screens/register_screen.dart';
import 'package:budget_flows/services/alert.dart';
import 'package:budget_flows/services/arguments.dart';
import 'package:flutter/material.dart';
import 'package:budget_flows/services/util.dart' as util;

class LoginScreen extends StatelessWidget {
  static const route = 'login';

  @override
  Widget build(BuildContext context) {
    String email;
    String password;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Budget flows',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 50,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InputField(
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email',
                onChanged: (value) {
                  email = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              InputField(
                keyboardType: TextInputType.emailAddress,
                hintText: 'Password',
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SubmitButton(
                buttonText: 'Login',
                fontSize: 30,
                onPressed: () async {
                  bool canLogin = await util.login(email, password);
                  if (canLogin) {
                    Navigator.pushNamed(
                      context,
                      AddRecordScreen.route,
                      arguments: AppArguments(email),
                    );
                  } else {
                    print('Fail to login');
                    AlertPopUp.announceLoginFail(context).show();
                  }
                },
              ),
              SubmitButton(
                buttonText: 'Register',
                fontSize: 20,
                onPressed: () {
                  Navigator.pushNamed(context, RegisterScreen.route);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

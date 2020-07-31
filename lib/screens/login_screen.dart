import 'package:budget_flows/components/input_field.dart';
import 'package:budget_flows/components/submit_button.dart';
import 'package:budget_flows/screens/add_record_screen.dart';
import 'package:budget_flows/screens/register_screen.dart';
import 'package:budget_flows/services/alert.dart';
import 'package:budget_flows/services/arguments.dart';
import 'package:flutter/material.dart';
import 'package:budget_flows/services/util.dart' as util;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static const route = 'login';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  bool isLoggedIn = false;
  bool remember = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    autoLogin();
  }

  void autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('autoLoginEmail');

    if (email != null) {
      setState(() {
        isLoggedIn = true;
      });
      Navigator.pushNamed(
        context,
        AddRecordScreen.route,
        arguments: AppArguments(email),
      );
    }
  }

  Future rememberLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('autoLoginEmail', email);

    setState(() {
      isLoggedIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please provide email';
                    }
                    RegExp exp = new RegExp(r"\w+\@\w+\.\w+");
                    if (!exp.hasMatch(value)) {
                      return 'Please provide a valid email';
                    }
                    return null;
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
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please provide password';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        'Remember me',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.green,
                        onChanged: (bool) {
                          setState(() {
                            remember = bool;
                          });
                        },
                        value: remember,
                      ),
                    ],
                  ),
                ),
                SubmitButton(
                  buttonText: 'Login',
                  fontSize: 30,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      bool canLogin = await util.login(email, password);
                      if (canLogin) {
                        if (remember) {
                          await rememberLogin();
                        }
                        Navigator.pushNamed(
                          context,
                          AddRecordScreen.route,
                          arguments: AppArguments(email),
                        );
                      } else {
                        AlertPopUp.announceLoginFail(context).show();
                      }
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
      ),
    );
  }
}

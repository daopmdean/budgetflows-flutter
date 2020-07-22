import 'package:flutter/material.dart';

class User {
  String email;
  String password;
  String fullName;
  String phone;

  User({this.email, this.password, this.fullName, this.phone});
}

class Das extends StatelessWidget {
  final String s;

  const Das({Key key, this.s}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

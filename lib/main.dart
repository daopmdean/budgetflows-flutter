import 'package:budget_flows/screens/add_record_screen.dart';
import 'package:budget_flows/screens/login_screen.dart';
import 'package:budget_flows/screens/register_screen.dart';
import 'package:budget_flows/screens/report_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BudgetFlows());
}

class BudgetFlows extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      initialRoute: LoginScreen.route,
      routes: {
        LoginScreen.route: (context) => LoginScreen(),
        RegisterScreen.route: (context) => RegisterScreen(),
        AddRecordScreen.route: (context) => AddRecordScreen(),
//        ReportScreen.route: (context) => ReportScreen(),
      },
    );
  }
}

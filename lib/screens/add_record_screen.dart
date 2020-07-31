import 'dart:developer';

import 'package:budget_flows/components/input_field.dart';
import 'package:budget_flows/components/submit_button.dart';
import 'package:budget_flows/models/record.dart';
import 'package:budget_flows/screens/report_screen.dart';
import 'package:budget_flows/services/alert.dart';
import 'package:budget_flows/services/arguments.dart';

import 'package:flutter/material.dart';
import 'package:budget_flows/services/util.dart' as util;
import 'package:shared_preferences/shared_preferences.dart';

class AddRecordScreen extends StatefulWidget {
  static final String route = 'add_record';

  @override
  _AddRecordScreenState createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  @override
  void deactivate() {
    super.deactivate();
    logout();
  }

  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('autoLoginEmail', null);
  }

  @override
  Widget build(BuildContext context) {
    final AppArguments args = ModalRoute.of(context).settings.arguments;
    final moneyTextController = TextEditingController();
    final reasonTextController = TextEditingController();
    String moneyStr;
    String reason;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InputField(
                hintText: 'Money spent as VND',
                controller: moneyTextController,
                onChanged: (value) {
                  moneyStr = value;
                },
              ),
              InputField(
                hintText: 'Reason',
                controller: reasonTextController,
                onChanged: (value) {
                  reason = value;
                },
              ),
              SubmitButton(
                buttonText: 'Add',
                fontSize: 25,
                onPressed: () async {
                  try {
                    await util.addRecord(moneyStr, reason, args.email);
                    AlertPopUp.announceRecordCreated(context, moneyStr, reason)
                        .show();
                  } catch (ex) {
                    AlertPopUp.announceRecordFail(
                            context, 'Please fill the information')
                        .show();
                  }
                  moneyTextController.clear();
                  reasonTextController.clear();
                },
              ),
              SubmitButton(
                buttonText: 'View Report',
                fontSize: 20,
                onPressed: () async {
                  List<Record> records = await util.getRecords(args.email);
                  records.sort((a, b) {
                    return b.created.compareTo(a.created);
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportScreen(
                        email: args.email,
                        records: records,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

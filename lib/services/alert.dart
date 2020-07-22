import 'package:flutter/cupertino.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AlertPopUp {
  static Alert announceRecordCreated(
      BuildContext context, String money, String reason) {
    return Alert(
      context: context,
      title: 'Record Created',
      desc: '$money - $reason',
      buttons: [
        DialogButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static Alert announceRecordFail(BuildContext context, String announce) {
    return Alert(
      context: context,
      title: 'Record Failed',
      desc: announce,
      buttons: [
        DialogButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static Alert announceLoginFail(BuildContext context) {
    return Alert(
      context: context,
      title: 'Incorrect Email or Password',
      buttons: [
        DialogButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  static Alert announceRegisterFail(BuildContext context, String message) {
    return Alert(
      context: context,
      title: message,
      buttons: [
        DialogButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

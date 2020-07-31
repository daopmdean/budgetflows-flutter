import 'package:flutter/material.dart';

const s = 1;

const kBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(15),
  ),
);

const kEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.greenAccent, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kDisableEnabledBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.pink, width: 1.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kFocusedBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.green, width: 2.0),
  borderRadius: BorderRadius.all(Radius.circular(32.0)),
);

const kErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.red, width: 1.0),
  borderRadius: BorderRadius.all(
    Radius.circular(32),
  ),
);

const kFocusedErrorBorder = OutlineInputBorder(
  borderSide: BorderSide(color: Colors.red, width: 2.0),
  borderRadius: BorderRadius.all(
    Radius.circular(32),
  ),
);

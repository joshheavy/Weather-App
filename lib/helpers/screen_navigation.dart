import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
void ChangeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

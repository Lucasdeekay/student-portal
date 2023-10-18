import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

void successFlushbar(BuildContext context, String title, String message) {
  Flushbar(
    title: title,
    message: message,
    backgroundColor: Colors.green, // Customize the background color
    duration: Duration(seconds: 3), // Set the duration
    icon: Icon(
      Icons.check_circle,
      size: 28,
      color: Colors.white,
    ),
    flushbarPosition: FlushbarPosition.TOP, // Set the position to top
  )..show(context);
}

void errorFlushbar(BuildContext context, String title, String message) {
  Flushbar(
    title: title,
    message: message,
    backgroundColor: Colors.red, // Customize the background color
    duration: Duration(seconds: 3), // Set the duration
    icon: Icon(
      Icons.error,
      size: 28,
      color: Colors.white,
    ),
    flushbarPosition: FlushbarPosition.TOP, // Set the position to top
  )..show(context);
}

void infoFlushbar(BuildContext context, String title, String message) {
  Flushbar(
    title: title,
    message: message,
    backgroundColor: Colors.blue, // Customize the background color
    duration: Duration(seconds: 3), // Set the duration
    icon: Icon(
      Icons.info,
      size: 28,
      color: Colors.white,
    ),
    flushbarPosition: FlushbarPosition.TOP, // Set the position to top
  )..show(context);
}


import 'package:flutter/material.dart';

// Custom Widget for Profile Details
Widget ProfileDetail(String title, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.only(left: 40.0, top: 20.0),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 40.0, top: 5.0),
        child: Text(
            content,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.normal,
            ),
        ),
      ),
    ],
  );
}
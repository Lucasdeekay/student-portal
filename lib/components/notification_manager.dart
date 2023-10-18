import 'package:flutter/material.dart';

// Custom Widget for Notification Title
Widget CardTitle(String title, IconData icon) {
  return Container(
    color: Colors.deepPurple,
    child: Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



// Custom Widget for Notification Item
Widget NotificationItem(String message, String timestamp) {
  return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  Text(timestamp),
                ],
              ),
            ),
          ),
        ],
      ),
  );
}


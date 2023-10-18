import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../components/navigation_manager.dart';
import '../components/notification_manager.dart';
import '../components/profile_manager.dart';

class NotificationItem extends StatelessWidget {
  final String title;
  final String content;

  NotificationItem({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
          subtitle: Text(
            content,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          onTap: () {
            // Handle notification item click
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}

class NotificationList {
  final List<NotificationItem> items;

  NotificationList({required this.items});

  factory NotificationList.fromJson(List<dynamic> json) {
    List<NotificationItem> items = [];

    for (var item in json) {
      items.add(NotificationItem(
        title: item['title'],
        content: item['content'],
      ));
    }

    return NotificationList(items: items);
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String matricNumber = '';
  String program = '';
  NotificationList? notifications;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User not logged in, handle this case
      return;
    }

    final email = user.email;

    try {
      final response = await http.get(Uri.parse(
          'https://demosystem.pythonanywhere.com/student-details/?email=$email'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          matricNumber = data['student']['matric_no'];
          program = data['student']['program'];

          notifications = NotificationList.fromJson(data['notifications']);
        });
      } else {
        // Handle API error
        print('Failed to load student details');
      }
    } catch (e) {
      // Handle other errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Top Bar
            TopBar(context),

            // User Profile Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 2,
                color: Colors.deepPurple[100],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CardTitle('Bio-data', Icons.person),
                      const SizedBox(height: 10.0),
                      Row(
                        children: [
                          Image.asset(
                            'assets/logo.png',
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileDetail('Matric Number', matricNumber),
                              ProfileDetail('Program', program),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 2,
                color: Colors.deepPurple[100],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CardTitle('Notifications', Icons.notifications),
                      const SizedBox(height: 16.0),
                      if (notifications == null || notifications!.items.isEmpty)
                        const Text('No notifications available')
                      else
                        Column(
                          children: notifications!.items,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(context, 0),
    );
  }
}

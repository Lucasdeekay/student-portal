import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/components/alert_manager.dart';
import 'dart:convert';

import '../components/drawer.dart';

class NotificationList {
  final String title;
  final String content;
  final String time;

  NotificationList({required this.title, required this.content, required this.time});

  factory NotificationList.fromJson(Map<String, dynamic> json) {
    return NotificationList(
      title: json['title'],
      content: json['content'],
      time: json['time'],
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String lastName = '';
  String firstName = '';
  String matricNumber = '';
  String level = '';
  String image = '';
  late String email = '';
  Future<List<NotificationList>?>? _notifications;


  @override
  void initState() {
    super.initState();
    _notifications = fetchData();
  }

  Future<List<NotificationList>?> fetchData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User not logged in, handle this case
      return null;
    }

    email = user.email!;

    try {
      final response = await http.get(Uri.parse('https://demosystem.pythonanywhere.com/student-details/?email=$email'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          lastName = data['student']['last_name'];
          firstName = data['student']['first_name'];
          matricNumber = data['student']['matric_no'];
          level = data['student']['level'];
          image = data['student']['image'];
        });

        final List<dynamic> notifications = data['notifications'];

        return notifications.map((notification) => NotificationList.fromJson(notification)).toList();
      } else {
        // Handle API error
        errorFlushbar(context, 'Error', 'Unable to load data. Check your internet connection');
      }
    } catch (e) {
      // Handle other errors
      errorFlushbar(context, 'Error', 'An error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context, lastName, firstName, email, matricNumber, level, image),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Home',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 22,
            letterSpacing: 0,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://demosystem.pythonanywhere.com${image}',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 4,
                        color: Color(0x25090F13),
                        offset: Offset(
                          0.0,
                          2,
                        ),
                      )
                    ],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 12, 12, 16),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 24.0,
                            fontFamily: 'Outfit',
                            letterSpacing: 0,
                          ),
                        ),
                        Text(
                          '$lastName $firstName',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            fontFamily: 'Plus Jakarta Sans',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                        Divider(
                          height: 24,
                          thickness: 2,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Matric No',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  Text(
                                    '$matricNumber',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36.0,
                                      fontFamily: 'Outfit',
                                      color: Colors.black,
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Level',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '$level',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36.0,
                                          fontFamily: 'Outfit',
                                          color: Colors.black,
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 0, 0),
                child: Text(
                  'Today\'s Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: 'Plus Jakarta Sans',
                    color: Colors.black,
                    letterSpacing: 0,
                  ),
                ),
              ),
              FutureBuilder<List<NotificationList>?>(
                  future: _notifications,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child:
                              CircularProgressIndicator())); // Show a loading indicator.
                    } else if (snapshot.hasError || snapshot.data == null) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            'Failed to load notifications',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      ); // Show an error message.
                    } else if (snapshot.data!.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: Text(
                            'No new notification available',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                          ),
                        ),
                      );
                    } else {
                      final newNotifications = snapshot.data!;
                      return Column(
                        children: newNotifications.map((notification) {
                          return Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 12, 16, 0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {},
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[50],
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 3,
                                            color: Colors.grey,
                                            offset: Offset(
                                              0.0,
                                              1,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 1, 1, 1),
                                              child: ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                child: Icon(
                                                  Icons.notifications,
                                                  size: 24.0,
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(8, 0, 4, 0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      notification.title,
                                                      style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        fontSize: 22.0,
                                                        fontFamily: 'Outfit',
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 4, 8, 0),
                                                      child: Text(
                                                        notification.content,
                                                        textAlign:
                                                        TextAlign.start,
                                                        style: TextStyle(
                                                          fontFamily:
                                                          'Plus Jakarta Sans',
                                                          fontSize: 12,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 4, 8),
                                                  child: Text(
                                                    notification.time,
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                      fontFamily:
                                                      'Plus Jakarta Sans',
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

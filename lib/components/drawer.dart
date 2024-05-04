
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_portal/components/route_manager.dart';
import 'package:student_portal/screens/payment_screen.dart';
import 'package:student_portal/screens/profile.dart';

import '../screens/dashboard.dart';
import '../screens/program_list.dart';
import '../screens/splash.dart';

String last_name = '';
String first_name = '';
String matric_number = '';
String level_no = '';
String email_add = '';
String image_url = '';

final List<String> _screenTitles = [
  'Dashboard',
  'Course Materials',
  'Make Payment',
  'Profile',
];

final List<IconData> _screenIcons = [
  Icons.home,
  Icons.newspaper,
  Icons.monetization_on,
  Icons.account_box,
];

final List<Widget> _screens = [
  DashboardScreen(),
  ProgramListScreen(lastName: last_name, firstName: first_name, email: email_add, matricNumber: matric_number, level: level_no, image: image_url),
  PaymentScreen(lastName: last_name, firstName: first_name, email: email_add, matricNumber: matric_number, level: level_no, image: image_url),
  ProfileScreen(lastName: last_name, firstName: first_name, email: email_add, matricNumber: matric_number, level: level_no, image: image_url),
];

Widget buildDrawer(context, String lastName, String firstName, String email, String matricNumber, String level, String image) {
  last_name = lastName;
  first_name = firstName;
  email_add = email;
  matric_number = matricNumber;
  level_no = level;
  image_url = image;

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(
            '${lastName} ${firstName}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Outfit',
              fontSize: 18,
              letterSpacing: 0,
            ),
          ),
          accountEmail: Text(
            email,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontFamily: 'Outfit',
              fontSize: 14,
              letterSpacing: 0,
            ),
          ),
          currentAccountPicture: CircleAvatar(
            backgroundImage: Image.network(image).image,
            backgroundColor: Colors.white,
          ),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
        ),
        ListTile(
          leading: Icon(Icons.search),
          title: Text(
            'Ask ChatGPT',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.italic,
              fontFamily: 'Outfit',
              fontSize: 14,
              letterSpacing: 0,
            ),
          ),
          onTap: () => {}, // Add your profile picture navigation here
        ),
        Divider(),
        for (int i = 0; i < _screenTitles.length; i++)
          ListTile(
            leading: Icon(_screenIcons[i]),
            title: Text(
              _screenTitles[i],
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Outfit',
                fontSize: 14,
                letterSpacing: 0,
              ),
            ),
            onTap: () {
              Navigator.pop(context); // Close drawer
              Navigator.of(context).push(createRoute(_screens[i])); // Navigate to screen
            },
          ),

        SizedBox(height: 150.0,),
        Padding(
          padding: const EdgeInsets.only(left:40.0, right:40),
          child: ElevatedButton(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.logout,
                            size: 16.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                        Text(
                          'Logging out...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    elevation: 2,
                    width: 350.0,
                    behavior: SnackBarBehavior.floating,
                  )
              );
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushAndRemoveUntil(createRoute(SplashScreen()), (route) => false);
              } catch (e) {
                // Handle any potential errors during logout
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.error,
                                size: 16.0,
                                color: Colors.redAccent,
                              )
                          ),
                          Text(
                            'Error logging out!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      elevation: 2,
                      width: 350.0,
                      behavior: SnackBarBehavior.floating,
                    )
                );
              }

            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.black),
              fixedSize: MaterialStateProperty.all<Size>(const Size(50, 34)),
              elevation: MaterialStateProperty.all<double>(2),
              shadowColor: MaterialStateProperty.all<Color>(Colors.white),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Log Out',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                          fontSize: 14.0,
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

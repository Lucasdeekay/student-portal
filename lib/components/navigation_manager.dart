import 'package:flutter/material.dart';
import 'package:student_portal/components/route_manager.dart';
import 'package:student_portal/screens/course_screen.dart';
import 'package:student_portal/screens/dashboard.dart';
import 'package:student_portal/screens/payment_screen.dart';
import 'package:student_portal/screens/settings_screen.dart';

import '../screens/login.dart';
import 'logout_manger.dart';

Widget TopBar(BuildContext context){
  return Container(
    height: 80,
    color: Colors.white, // Customize the color
    child: Padding(
      padding: const EdgeInsets.only(top: 20, left: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo and App Name
          Row(
            children: [
              // Logo (Replace with your image)
              Image.asset(
                'assets/logo.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 10),
              // App Name
              const Text(
                'Student Portal',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Logout Link and Icon
          InkWell(
            onTap: () async {
              // Handle logout here
              await AuthService.logout(); // Call the static logout method
              Navigator.of(context).pushAndRemoveUntil(
                createRoute(LoginScreen()),
                    (route) => false,
              );
              // For example, call a logout function and navigate to the login screen
              Navigator.of(context).pushAndRemoveUntil(
                  createRoute(LoginScreen()), (route) => false);
            },
            child: const Row(
              children: [
                Icon(
                  Icons.exit_to_app,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 5),
                Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget BottomBar(BuildContext context, int index){
  return BottomNavigationBar(
    // Navigation Bar at the bottom
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.deepPurple,
    selectedItemColor: Colors.black,
    unselectedFontSize: 10.0,
    selectedFontSize: 12.0,
    selectedLabelStyle: const TextStyle(
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.bold,
    ),
    unselectedLabelStyle: const TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
    ),
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.library_books),
        label: 'Course Materials',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.payment),
        label: 'Make Payment',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
    ],
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    // Set the current index (active link)
    onTap: (index) {
      // Handle navigation here
      if (index == 0) {
        // Navigate to the Dashboard
        Navigator.of(context).push(createRoute(DashboardScreen()));
      } else if (index == 1) {
        // Navigate to Course Materials
        Navigator.of(context).push(createRoute(CourseScreen()));
      } else if (index == 2) {
        // Navigate to Make Payment
        Navigator.of(context).push(createRoute(PaymentScreen()));
      } else if (index == 3) {
        // Navigate to Settings
        Navigator.of(context).push(createRoute(SettingsScreen()));
      }
    },
  );
}
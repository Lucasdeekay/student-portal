import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Added for system bar color
import '../components/alert_manager.dart';
import '../components/input_manager.dart';
import '../components/notification_manager.dart';
import '../components/profile_manager.dart';
import '../components/navigation_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String lastName = '';
  String firstName = '';
  String userEmail = '';
  String matricNumber = '';
  String program = '';
  String level = '';

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
      final response = await http.get(Uri.parse('https://demosystem.pythonanywhere.com/student-details/?email=$email'));


      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          lastName = data['student']['last_name'];
          firstName = data['student']['first_name'];
          matricNumber = data['student']['matric_no'];
          userEmail = data['student']['email'];
          program = data['student']['program'];
          level = data['student']['level'];

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
    // Change system bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    return Scaffold(
      // Remove the app bar
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // Align the content to the start
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
                      Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CardTitle('My Profile', Icons.person),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ProfileDetail('Last Name', lastName),
                                        ProfileDetail('First Name', firstName),
                                        ProfileDetail('Matric Number', matricNumber),
                                      ],
                                    ),
                                    const SizedBox(width: 5.0,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ProfileDetail('Email', userEmail),
                                        ProfileDetail('Program', program),
                                        ProfileDetail('Level', level),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
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
                  child: Form(
                    // Create a Form widget to handle user input
                    key: _formKey, // Define a GlobalKey<FormState> for the form
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CardTitle('Change Password', Icons.settings),
                        const SizedBox(height: 16.0),

                        // Password Input Field
                        buildInputField(
                          labelText: 'Password',
                          icon: Icons.lock,
                          isDateField: false,
                          context: context,
                          isObscure: true,
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            return null; // Return null if the field is valid
                          },
                          color: Colors.black,
                        ),
                        const SizedBox(height: 16.0),

                        // Confirm Password Input Field
                        buildInputField(
                          labelText: 'Confirm Password',
                          icon: Icons.lock,
                          isDateField: false,
                          context: context,
                          isObscure: true,
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Confirm Password is required';
                            } else if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null; // Return null if the field is valid
                          },
                          color: Colors.black,
                        ),
                        const SizedBox(height: 16.0),

                        // Submit Button
                        ElevatedButton(
                          onPressed: () {
                            try {
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, change the password in Firebase
                                // You can add your Firebase password change logic here
                                FirebaseAuth.instance.currentUser
                                    ?.updatePassword(
                                        confirmPasswordController.text);
                                successFlushbar(context, "Success",
                                    "Password Successfully Changed");
                              }
                            } catch (e) {
                              errorFlushbar(
                                  context, "Error", "An error occurred");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepPurple,
                            elevation: 2,
                            minimumSize: const Size(10, 50),
                          ),
                          child: const Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(context, 3),
    );
  }
}

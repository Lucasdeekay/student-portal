import 'package:flutter/material.dart';
import 'package:student_portal/screens/dashboard.dart';
import 'package:student_portal/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/alert_manager.dart';
import '../components/input_manager.dart';
import '../components/route_manager.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login_bg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
          ),
          Positioned(
              top: 40.0,
              right: 16.0,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(createRoute(RegistrationScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.transparent,
                    elevation: 2,
                    minimumSize: const Size(10, 50),
                    side: const BorderSide(color: Colors.white,)
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.app_registration,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Register Your Account',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 12.0,
                          )),
                    ],
                  ))),
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Image.asset(
                      'assets/logo.png',
                      width: 100,
                      height: 100,
                    ),
                  ),
                  buildInputField(
                    labelText: 'Email',
                    icon: Icons.mail,
                    isDateField: false,
                    context: context,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                  ),
                  buildInputField(
                    labelText: 'Password',
                    icon: Icons.lock,
                    isDateField: false,
                    context: context,
                    controller: passwordController,
                    isObscure: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 16.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        infoFlushbar(
                            context, "Please Wait", "Authenticating...");
                        if (_formKey.currentState!.validate()) {
                          try {
                            final UserCredential userCredential =
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );

                            if (userCredential.user != null) {
                              successFlushbar(
                                  context, "Success", "Login successful");
                              // Authentication successful, navigate to the homepage.
                              Future.delayed(Duration(seconds: 3), () {
                                Navigator.of(context)
                                    .push(createRoute(DashboardScreen()));
                              });
                            } else {
                              errorFlushbar(
                                  context, "Error", "Authentication failed");
                            }
                          } catch (e) {
                            errorFlushbar(
                                context, "Authentication failed", "$e");
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.deepPurple,
                        elevation: 2,
                        minimumSize: const Size(200, 50),
                      ),
                      child: const Text('Login',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).push(createRoute(DashboardScreen()));
                  //   },
                  //   child: const Text(
                  //     "Don't have an account? Register here",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontStyle: FontStyle.italic,
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

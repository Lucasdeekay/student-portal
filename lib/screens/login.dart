import 'package:flutter/material.dart';
import 'package:student_portal/screens/dashboard.dart';
import 'package:student_portal/screens/forgot_password.dart';
import 'package:student_portal/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/alert_manager.dart';
import '../components/route_manager.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding:
                EdgeInsetsDirectional.fromSTEB(24, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png', width: 50, height: 50),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Dominion University',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24.0,
                        fontFamily: 'Outfit',
                        letterSpacing: 0,
                      ),
                    ),
                  ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign in your account',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 32.0,
                        fontFamily: 'Outfit',
                        letterSpacing: 0,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 12, 0, 24),
                      child: Text(
                        'Fill out the form below with your credentials.',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.grey,
                          fontFamily: 'Outfit',
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: emailController,
                          autofillHints: [AutofillHints.email],
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle:
                            TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Outfit',
                              letterSpacing: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Colors.white,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Colors.grey,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Colors.redAccent,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            focusedErrorBorder:
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Colors.redAccent,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor:
                            Colors.grey[100],
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            fontFamily: 'Plus Jakarta Sans',
                            letterSpacing: 0,
                          ),
                          keyboardType:
                          TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Email is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, 16),
                      child: Container(
                        width: double.infinity,
                        child: TextFormField(
                          controller: passwordController,
                          autofillHints: [AutofillHints.password],
                          obscureText: !passwordVisibility,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle:
                            TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0,
                              fontFamily: 'Outfit',
                              letterSpacing: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Colors.white,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Colors.grey,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Colors.redAccent,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            focusedErrorBorder:
                            OutlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                Colors.redAccent,
                                width: 2,
                              ),
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor:
                            Colors.grey[100],
                            suffixIcon: InkWell(
                              onTap: () => setState(
                                      () => passwordVisibility = !passwordVisibility
                              ),
                              focusNode:
                              FocusNode(skipTraversal: true),
                              child: Icon(
                                passwordVisibility
                                    ? Icons.visibility_outlined
                                    : Icons
                                    .visibility_off_outlined,
                                color:
                                Colors.black,
                                size: 24,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                            fontFamily: 'Plus Jakarta Sans',
                            letterSpacing: 0,
                          ),
                          keyboardType:
                          TextInputType.visiblePassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              70, 0, 0, 12),
                          child: GestureDetector(
                            onTap: () => {
                              Navigator.of(context).push(createRoute(ForgotPasswordScreen()))
                            },
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily:
                                'Plus Jakarta Sans',
                                color: Colors.blueAccent,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, 16),
                      child: ElevatedButton(
                        onPressed: () async {
                          infoFlushbar(context, "Please Wait", "Processing...");
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
                                  context, "Authentication failed", 'An error occurred. Please try again.');
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent),
                          minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 60)),
                          elevation: MaterialStateProperty.all<double>(0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          0, 0, 0, 24),
                      child: Container(
                        width: double.infinity,
                        child: Stack(
                          alignment: AlignmentDirectional(0, 0),
                          children: [
                            Align(
                              alignment:
                              AlignmentDirectional(0, 0),
                              child: Padding(
                                padding: EdgeInsetsDirectional
                                    .fromSTEB(0, 12, 0, 12),
                                child: Container(
                                  width: double.infinity,
                                  height: 2,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment:
                              AlignmentDirectional(0, 0),
                              child: Container(
                                width: 70,
                                height: 32,
                                decoration: BoxDecoration(
                                  color:
                                  Colors.white,
                                ),
                                alignment:
                                AlignmentDirectional(0, 0),
                                child: Text(
                                  'OR',
                                  style:
                                  TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Outfit',
                                    color: Colors.grey,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Plus Jakarta Sans',
                            letterSpacing: 0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => {
                            Navigator.of(context).pushAndRemoveUntil(createRoute(RegistrationScreen()), (route) => false)
                          },
                          child: Text(
                            ' Sign Up here',
                            style: TextStyle(
                              fontFamily:
                              'Plus Jakarta Sans',
                              color: Colors.blueAccent,
                              letterSpacing: 0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

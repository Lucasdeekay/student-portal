import 'package:flutter/material.dart';
import 'package:student_portal/screens/dashboard.dart';
import 'package:student_portal/screens/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/alert_manager.dart';
import '../components/route_manager.dart';
import 'dart:convert';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 6,
              child: Container(
                width: 100,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                alignment: AlignmentDirectional(0, -1),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 140,
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
                              Image.asset('assets/images/logo.png', width: 80, height: 80),
                            Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'Dominion University',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 36.0,
                                  fontFamily: 'Outfit',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        constraints: BoxConstraints(
                          maxWidth: 430,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Form(
                              key: _formKey,
                              autovalidateMode: AutovalidateMode.disabled,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Forgot Password',
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
                                      'Enter your email to recover account',
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
                                    child: ElevatedButton(
                                      onPressed: () async {
                                        infoFlushbar(context, "Please Wait", "Processing...");
                                        if (_formKey.currentState!.validate()) {
                                          try {
                                            await FirebaseAuth.instance
                                                .sendPasswordResetEmail(
                                              email: emailController.text
                                                  .trim(),
                                            );
                                            successFlushbar(context, 'Success', 'Password reset email sent!');
                                          } on FirebaseAuthException catch (e) {
                                            if (e.code == 'user-not-found') {
                                              errorFlushbar(context, 'Error', 'The email address is not associated with an account.');
                                            } else {
                                              errorFlushbar(context, 'Error', 'An error occurred. Please try again.');
                                            }
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
                                    // child: FFButtonWidget(
                                    //   onPressed: () async {
                                    //     logFirebaseEvent(
                                    //         'SIGN_UP_SCREEN_CREATE_ACCOUNT_BTN_ON_TAP');
                                    //     logFirebaseEvent('Button_auth');
                                    //     GoRouter.of(context).prepareAuthEvent();
                                    //     if (_model
                                    //         .passwordTextController.text !=
                                    //         _model.passwordConfirmTextController
                                    //             .text) {
                                    //       ScaffoldMessenger.of(context)
                                    //           .showSnackBar(
                                    //         SnackBar(
                                    //           content: Text(
                                    //             'Passwords don\'t match!',
                                    //           ),
                                    //         ),
                                    //       );
                                    //       return;
                                    //     }
                                    //
                                    //     final user = await authManager
                                    //         .createAccountWithEmail(
                                    //       context,
                                    //       _model
                                    //           .emailAddressTextController.text,
                                    //       _model.passwordTextController.text,
                                    //     );
                                    //     if (user == null) {
                                    //       return;
                                    //     }
                                    //
                                    //     await UsersRecord.collection
                                    //         .doc(user.uid)
                                    //         .update({
                                    //       ...createUsersRecordData(
                                    //         displayName: _model
                                    //             .fullNameTextController.text,
                                    //         diet: FFAppState().userDiet,
                                    //       ),
                                    //       ...mapToFirestore(
                                    //         {
                                    //           'allergens':
                                    //           FFAppState().userAllergens,
                                    //           'ingredient_dislikes':
                                    //           FFAppState()
                                    //               .userIngredientDislikes,
                                    //         },
                                    //       ),
                                    //     });
                                    //
                                    //     context.goNamedAuth(
                                    //         'Dashboard', context.mounted);
                                    //   },
                                    //   text: 'Create Account',
                                    //   options: FFButtonOptions(
                                    //     width: double.infinity,
                                    //     height: 44,
                                    //     padding: EdgeInsetsDirectional.fromSTEB(
                                    //         0, 0, 0, 0),
                                    //     iconPadding:
                                    //     EdgeInsetsDirectional.fromSTEB(
                                    //         0, 0, 0, 0),
                                    //     color: FlutterFlowTheme.of(context)
                                    //         .primary,
                                    //     textStyle: FlutterFlowTheme.of(context)
                                    //         .titleSmall
                                    //         .override(
                                    //       fontFamily: 'Plus Jakarta Sans',
                                    //       color: Colors.white,
                                    //       letterSpacing: 0,
                                    //     ),
                                    //     elevation: 3,
                                    //     borderSide: BorderSide(
                                    //       color: Colors.transparent,
                                    //       width: 1,
                                    //     ),
                                    //     borderRadius: BorderRadius.circular(12),
                                    //   ),
                                    // ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          70, 0, 0, 12),
                                      child: Row(
                                        children: [
                                          Text(
                                            'Forgot your password?',
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
                                              ' Retrieve account',
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
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          70, 0, 0, 12),
                                      child: Row(
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
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
    );
    // return Scaffold(
    //   body: Stack(
    //     children: [
    //       Container(
    //         decoration: const BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage('assets/login_bg.jpg'),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //       Container(
    //         color: Colors.black.withOpacity(0.8),
    //       ),
    //       Positioned(
    //           top: 40.0,
    //           right: 16.0,
    //           child: ElevatedButton(
    //               onPressed: () {
    //                 Navigator.of(context)
    //                     .push(createRoute(RegistrationScreen()));
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 foregroundColor: Colors.white,
    //                 backgroundColor: Colors.transparent,
    //                 elevation: 2,
    //                 minimumSize: const Size(10, 50),
    //                 side: const BorderSide(color: Colors.white,)
    //               ),
    //               child: const Row(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Icon(
    //                     Icons.app_registration,
    //                     color: Colors.white,
    //                   ),
    //                   SizedBox(
    //                     width: 5.0,
    //                   ),
    //                   Text('Register Your Account',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontWeight: FontWeight.w900,
    //                         fontSize: 12.0,
    //                       )),
    //                 ],
    //               ))),
    //       Padding(
    //         padding: const EdgeInsets.only(left: 50.0, right: 50.0),
    //         child: Form(
    //           key: _formKey,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(bottom: 16.0),
    //                 child: Image.asset(
    //                   'assets/logo.png',
    //                   width: 100,
    //                   height: 100,
    //                 ),
    //               ),
    //               buildInputField(
    //                 labelText: 'Email',
    //                 icon: Icons.mail,
    //                 isDateField: false,
    //                 context: context,
    //                 controller: emailController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Username is required';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               buildInputField(
    //                 labelText: 'Password',
    //                 icon: Icons.lock,
    //                 isDateField: false,
    //                 context: context,
    //                 controller: passwordController,
    //                 isObscure: true,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Password is required';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               Container(
    //                 margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 16.0),
    //                 child: ElevatedButton(
    //                   onPressed: () async {
    //                     infoFlushbar(
    //                         context, "Please Wait", "Authenticating...");
    //                     if (_formKey.currentState!.validate()) {
    //                       try {
    //                         final UserCredential userCredential =
    //                             await FirebaseAuth.instance
    //                                 .signInWithEmailAndPassword(
    //                           email: emailController.text,
    //                           password: passwordController.text,
    //                         );
    //
    //                         if (userCredential.user != null) {
    //                           successFlushbar(
    //                               context, "Success", "Login successful");
    //                           // Authentication successful, navigate to the homepage.
    //                           Future.delayed(Duration(seconds: 3), () {
    //                             Navigator.of(context)
    //                                 .push(createRoute(DashboardScreen()));
    //                           });
    //                         } else {
    //                           errorFlushbar(
    //                               context, "Error", "Authentication failed");
    //                         }
    //                       } catch (e) {
    //                         errorFlushbar(
    //                             context, "Authentication failed", "$e");
    //                       }
    //                     }
    //                   },
    //                   style: ElevatedButton.styleFrom(
    //                     foregroundColor: Colors.white,
    //                     backgroundColor: Colors.deepPurple,
    //                     elevation: 2,
    //                     minimumSize: const Size(200, 50),
    //                   ),
    //                   child: const Text('Login',
    //                       style: TextStyle(color: Colors.white)),
    //                 ),
    //               ),
    //               // GestureDetector(
    //               //   onTap: () {
    //               //     Navigator.of(context).push(createRoute(DashboardScreen()));
    //               //   },
    //               //   child: const Text(
    //               //     "Don't have an account? Register here",
    //               //     style: TextStyle(
    //               //       color: Colors.white,
    //               //       fontStyle: FontStyle.italic,
    //               //     ),
    //               //   ),
    //               // )
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

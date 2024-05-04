import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/alert_manager.dart';
import '../components/route_manager.dart';
import 'login.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String resetToken;

  const ResetPasswordScreen({Key? key, required this.resetToken}) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  late bool passwordVisibility = false;
  late bool confirmPasswordVisibility = false;

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
                                    'Change Password',
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
                                      'Enter a strong password',
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
                                            return 'This field is required';
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
                                        controller: confirmPasswordController,
                                        autofillHints: [AutofillHints.password],
                                        obscureText: !passwordVisibility,
                                        textInputAction: TextInputAction.done,
                                        decoration: InputDecoration(
                                          labelText: 'Confirm Password',
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
                                            return 'This field is required';
                                          }else if (value != passwordController.text) {
                                            return 'Passwords do not match';
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
                                            String newPassword = passwordController
                                                .text.trim();
                                            String confirmPassword = confirmPasswordController
                                                .text.trim();

                                            // Validate new password (add your validation logic here)
                                            if (newPassword.isEmpty ||
                                                confirmPassword.isEmpty) {
                                              throw Exception(
                                                  'Please enter both new password and confirm password.');
                                            }
                                            if (newPassword !=
                                                confirmPassword) {
                                              throw Exception(
                                                  'New password and confirm password do not match.');
                                            }

                                            await FirebaseAuth.instance
                                                .confirmPasswordReset(
                                              code: widget.resetToken,
                                              newPassword: newPassword,
                                            );
                                            successFlushbar(context, 'Success', 'Password reset email sent!');
                                            Navigator.of(context).pushAndRemoveUntil(createRoute(LoginScreen()), (route) => false);
                                            // Navigate to login page or display success message (you decide)
                                          } on FirebaseAuthException catch (e) {
                                            errorFlushbar(context, 'Error', 'An error occurred. Please try again.');
                                          } catch (e) {
                                            errorFlushbar(context, 'Error', 'An error occurred. Please try again.');
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
                                              'Create Account',
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
  }
}

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/alert_manager.dart';
import '../components/drawer.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Terms And Condition',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 22,
            letterSpacing: 0,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Terms and Conditions',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Text(
                        'Welcome! These Terms and Conditions ("Terms") govern your use of the Dominion University Student Portal mobile application ("App"). By downloading and using the App, you agree to be bound by these Terms. If you disagree with any part of the Terms, then you may not access or use the App.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '1. Acceptance of Terms',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Text(
                        'These Terms constitute a legally binding agreement '
                            'between you ("User") and Dominion University '
                            '("University") regarding your access to and use '
                            'of the App.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '2. Access and Use',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Text(
                        '2.1 The App is intended for use by currently enrolled students of Dominion University.\n\n'
                       '2.2 You are responsible for maintaining the confidentiality of your login credentials '
                            'and for restricting access to your device to prevent unauthorized access to the App.\n\n'
                      '2.3 You agree to use the App in accordance with all applicable laws and regulations.\n\n'
                      '2.4 You agree not to use the App for any purpose that is unlawful or prohibited by these Terms.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          letterSpacing: 0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          '3. Content',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Text(
                        '3.1 The App contains content provided by the University, including but not '
                            'limited to academic resources, course information, and student services information.\n\n'
                        '3.2 The University reserves the right to modify or remove content from the App at '
                            'any time without prior notice.',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.0,
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          letterSpacing: 0,
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
    );
  }
}

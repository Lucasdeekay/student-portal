import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/alert_manager.dart';
import '../components/drawer.dart';

class SupportPageScreen extends StatefulWidget {
  const SupportPageScreen({super.key});

  @override
  State<SupportPageScreen> createState() =>
      _SupportPageScreenState();
}

class _SupportPageScreenState extends State<SupportPageScreen>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController topicController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  late String email = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User not logged in, handle this case
      return;
    }

    email = user.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Get support',
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
                      Text(
                        'Welcome to support',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          fontFamily: 'Outfit',
                          color: Colors.grey,
                          letterSpacing: 0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Submit a Ticket',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    TextFormField(
                                      controller: topicController,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Topic',
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          fontFamily: 'Outfit',
                                          color: Colors.grey,
                                          letterSpacing: 0,
                                        ),
                                        hintStyle:TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          fontFamily: 'Outfit',
                                          color: Colors.grey,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                                            16, 12, 16, 12),
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        fontFamily: 'Outfit',
                                        color: Colors.black,
                                        letterSpacing: 0,
                                      ),
                                      cursorColor: Colors.grey,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 12),
                                    TextFormField(
                                      controller: contentController,
                                      autofocus: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Short Description of what\'s going on...',
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          fontFamily: 'Outfit',
                                          color: Colors.grey,
                                          letterSpacing: 0,
                                        ),
                                        hintStyle:TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.0,
                                          fontFamily: 'Outfit',
                                          color: Colors.grey,
                                          letterSpacing: 0,
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        contentPadding: EdgeInsetsDirectional.fromSTEB(
                                            16, 12, 16, 12),
                                      ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.0,
                                        fontFamily: 'Outfit',
                                        color: Colors.black,
                                        letterSpacing: 0,
                                      ),
                                      maxLines: 16,
                                      minLines: 6,
                                      cursorColor: Colors.grey,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'This field cannot be empty';
                                        }
                                        return null;
                                      },
                                    ),
                                  ]
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
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
                                              child: Text(
                                                'Processing Ticket...',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.mail,
                                              size: 16.0,
                                              color: Colors.deepPurple,
                                            ),
                                          ],
                                        ),
                                        elevation: 2,
                                        width: 350.0,
                                        behavior: SnackBarBehavior.floating,
                                      )
                                  );
                                  if (_formKey.currentState!.validate()) {
                                    final response = await http.post(
                                      Uri.parse('https://demosystem.pythonanywhere.com/submit_ticket/'),
                                      headers: {
                                        "Content-Type": "application/json",
                                      },
                                      body: jsonEncode({
                                        'topic': topicController.text,
                                        'content': contentController.text,
                                        'email': email,
                                      }),
                                    );

                                    try {
                                      if (response.statusCode == 201) {
                                        setState(() {
                                          topicController.text = '';
                                          contentController.text = '';
                                        });

                                        successFlushbar(context, "Success", "Ticket Submitted!");
                                      } else {
                                        errorFlushbar(context, "Error", "Ticket Submission Failed!");
                                      }
                                    } catch (e) {
                                      errorFlushbar(context, "Error", "An error occured!");
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.deepPurple),
                                  fixedSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 48)),
                                  elevation: MaterialStateProperty.all<double>(4),
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
                                          Padding(
                                            padding: EdgeInsets.only(right:8.0),
                                            child: Icon(
                                              Icons.receipt_long,
                                              color: Colors.white,
                                              size: 16.0,
                                            ),
                                          ),
                                          Text(
                                            'Submit Ticket',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 16.0,
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
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'How can we help you?',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 4),
                        child: Text(
                          'Review FAQ\'s below',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            fontFamily: 'Outfit',
                            color: Colors.grey,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth: 500,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey,
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'How do I download Code?',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.0,
                                    fontFamily: 'Outfit',
                                    color: Colors.black,
                                    letterSpacing: 0,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 4, 0, 0),
                                  child: Text(
                                    'Showcase a couple of eye-catching screenshots or mockups of your UI Kit to capture attention and give users a glimpse of what they can expect.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: 'Outfit',
                                      color: Colors.grey,
                                      letterSpacing: 0,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

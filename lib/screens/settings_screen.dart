import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:core';
import 'dart:io';

import 'package:student_portal/components/alert_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String email = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  XFile? _imageFile;
  String imageUrl = ''; // Stores the uploaded image URL

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    });
  }

  Future<void> _uploadImage() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User not logged in, handle this case
      return null;
    }

    email = user.email!;

    if (_imageFile == null) return;

    // Replace with your Django API endpoint URL (ensure authentication if needed)
    var url = Uri.parse(
        'https://demosystem.pythonanywhere.com/upload_image/$email');

    var request = http.MultipartRequest('POST', url);
    // Await the result of `http.MultipartFile.fromPath` before adding it to the request
    var multipartFile = await http.MultipartFile.fromPath(
        'image', _imageFile!.path);
    request.files.add(multipartFile);
    var response = await request.send();

    if (response.statusCode == 200) {
      // Successful upload
      final responseData = await response.stream.transform(utf8.decoder).join();
      setState(() {
        imageUrl =
            responseData; // Update imageUrl with the response (e.g., uploaded image URL)
      });
    } else {
      // Handle upload error
      errorFlushbar(context, "Error", "Error uploading image");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
        ),
        title: Text(
          'Profile Setting',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 22,
            letterSpacing: 0,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kindly upload image of your face',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    fontFamily: 'Outfit',
                    color: Colors.grey,
                    letterSpacing: 0,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    _pickImage
                  },
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
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
                        padding: EdgeInsets.all(8),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.add_a_photo_rounded,
                              color: Colors.purple,
                              size: 32,
                            ),
                            Padding(
                              padding:
                              EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                              child: Text(
                                'Select Image',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.0,
                                  fontFamily: 'Plus Jakarta Sans',
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
                  child: ElevatedButton(
                    onPressed: () async {
                      await _uploadImage;
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurple),
                      fixedSize: MaterialStateProperty.all<Size>(
                          const Size(double.infinity, 48)),
                      elevation: MaterialStateProperty.all<double>(4),
                      shadowColor: MaterialStateProperty.all<Color>(
                          Colors.white),
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
                                padding: EdgeInsets.only(right: 8.0),
                                child: Icon(
                                  Icons.image,
                                  color: Colors.white,
                                  size: 16.0,
                                ),
                              ),
                              Text(
                                'Upload Image',
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
        ),
      ),
    );
  }
}

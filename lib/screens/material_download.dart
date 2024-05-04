import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/alert_manager.dart';
import 'program_list.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CourseMaterial {
  final String title;
  final String file;

  CourseMaterial({
    required this.title,
    required this.file,
  });

  factory CourseMaterial.fromJson(Map<String, dynamic> json) {
    return CourseMaterial(
      title: json['title'],
      file: json['file'],
    );
  }
}

class CourseMaterialDownloadScreen extends StatefulWidget {
  final Program program;

  CourseMaterialDownloadScreen({required this.program});

  @override
  _CourseMaterialDownloadScreenState createState() => _CourseMaterialDownloadScreenState();
}

class _CourseMaterialDownloadScreenState extends State<CourseMaterialDownloadScreen> {
  Future<List<CourseMaterial>?>? _courseMaterials;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController searchBarTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _courseMaterials = fetchCourseMaterialsByProgram(widget.program.name);
  }

  Future<List<CourseMaterial>?> fetchCourseMaterialsByProgram(programName) async {
    try {
      final response = await http.get(Uri.parse('https://demosystem.pythonanywhere.com/get_course_materials/$programName'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((materialData) => CourseMaterial.fromJson(materialData)).toList();
      } else {
        errorFlushbar(context, 'Error', 'Failed to load data. Check your internet connection');
      }
    } catch (error) {
      // Handle the error, show a message, or log it.
      errorFlushbar(context, 'Error', 'An error occured');
    }
  }

  Future<List<CourseMaterial>?> fetchCourseMaterialsBySelectedProgram(programName, searchText) async {
    try {
      final response = await http
          .get(Uri.parse(
          'https://demosystem.pythonanywhere.com/get_course_materials/$programName/$searchText'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((courseData) => CourseMaterial.fromJson(courseData)).toList();
      } else {
        errorFlushbar(context, 'Error', 'Failed to load data. Check your internet connection');
      }
    } catch (error) {
      // Handle the error, show a message, or log it.
      errorFlushbar(context, 'Error', 'An error occured');
    }
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
          'Course Materials',
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Form(
              key: _formKey,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 8, 0),
                      child: TextFormField(
                        controller: searchBarTextController,
                        textCapitalization: TextCapitalization.words,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Type to search...',
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontFamily: 'Outfit',
                            letterSpacing: 0,
                          ),
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.0,
                            color: Colors.grey,
                            fontFamily: 'Outfit',
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
                              color: Colors.pinkAccent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pinkAccent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 14.0,
                          fontFamily: 'Plus Jakarta Sans',
                          letterSpacing: 0,
                        ),
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter your search';
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.search_sharp,
                        color: Colors.grey,
                        size: 30,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.rocket_launch,
                                      size: 16.0,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  Text(
                                    'Loading...',
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
                        setState(() {
                          _courseMaterials =
                              fetchCourseMaterialsBySelectedProgram(widget.program.name, searchBarTextController.text);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(16, 16, 0, 0),
                            child: Text(
                              'Available Books',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          FutureBuilder<List<CourseMaterial>?>(
                              future: _courseMaterials,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: Padding(
                                          padding: EdgeInsets.only(top: 20.0),
                                          child: CircularProgressIndicator()
                                      )
                                  ); // Show a loading indicator.
                                } else if (snapshot.hasError ||
                                    snapshot.data == null) {
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        'No available material presently. Kindly check back later',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          fontFamily: 'Plus Jakarta Sans',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                  ); // Show an error message.
                                } else if (snapshot.data!.isEmpty) {
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child: Text(
                                        'No course material available',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14,
                                          fontFamily: 'Plus Jakarta Sans',
                                          letterSpacing: 0,
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  final courseMaterials = snapshot.data!;
                                  return Column(
                                    children: courseMaterials.map((material) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 8),
                                        child: Container(
                                          width: double.infinity,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            boxShadow: [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x32000000),
                                                offset: Offset(
                                                  0.0,
                                                  2,
                                                ),
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(26),
                                                      child: Icon(
                                                        Icons.newspaper,
                                                        size: 20.0,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                          12, 0, 0, 0),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.max,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            material.title,
                                                            style: TextStyle(
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: 14.0,
                                                              fontFamily: 'Plus Jakarta Sans',
                                                              letterSpacing: 0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: [
                                                    ElevatedButton(
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
                                                                      Icons.downloading,
                                                                      size: 16.0,
                                                                      color: Colors.blueAccent,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Download...',
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
                                                        // Implement material download logic here
                                                        const baseUrl = 'https://demosystem.pythonanywhere.com/';
                                                        final materialUrl = baseUrl + material.file;
                                                        if (await canLaunchUrl(Uri.parse(materialUrl))) {
                                                          await launchUrl(Uri.parse(materialUrl));
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              content: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(right: 8.0),
                                                                    child: Icon(
                                                                      Icons.thumb_up_alt,
                                                                      size: 16.0,
                                                                      color: Colors.lightGreen,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Download Complete!',
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
                                                            ),
                                                          );
                                                        } else {
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(right:8.0),
                                                                      child: Icon(
                                                                        Icons.thumb_down_alt,
                                                                        size: 16.0,
                                                                        color: Colors.redAccent,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'Download Failed!',
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
                                                            Colors.blueAccent),
                                                        minimumSize: MaterialStateProperty.all<Size>(const Size(40, 50)),
                                                        elevation: MaterialStateProperty.all<double>(2),
                                                      ),
                                                      child: const Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Padding(
                                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsets.only(right:8.0),
                                                                  child: Icon(
                                                                    Icons.download,
                                                                    size: 14.0,
                                                                    color: Colors.white,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'Download',
                                                                  style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontSize: 12.0,
                                                                    fontWeight: FontWeight.bold,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}

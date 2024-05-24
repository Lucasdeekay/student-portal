import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/alert_manager.dart';
import '../components/drawer.dart';
import '../components/route_manager.dart';
import 'material_download.dart';
import 'package:http/http.dart' as http;

class Program {
  final String name;

  Program({
    required this.name,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      name: json['program'],
    );
  }
}

class ProgramListScreen extends StatefulWidget {
  final String lastName;
  final String firstName;
  final String matricNumber;
  final String level;
  final String email;
  final String image;
  ProgramListScreen({super.key, required this.lastName, required this.firstName, required this.email, required this.matricNumber, required this.level, required this.image});

  @override
  _ProgramListScreenState createState() => _ProgramListScreenState();
}

class _ProgramListScreenState extends State<ProgramListScreen> {
  Future<List<Program>?>? _programsFuture;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController searchBarTextController = TextEditingController();

  late String lastName;
  late String firstName;
  late String matricNumber;
  late String level;
  late String email;
  late String image;

  @override
  void initState() {
    super.initState();
    _programsFuture = fetchPrograms();
    lastName = widget.lastName;
    firstName = widget.firstName;
    email = widget.email;
    matricNumber = widget.matricNumber;
    level = widget.level;
    image = widget.image;
  }

  Future<List<Program>?> fetchPrograms() async {
    try {
      final response = await http.get(Uri.parse('https://demosystem.pythonanywhere.com/get_programs'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((courseData) => Program.fromJson(courseData)).toList();
      } else {
        errorFlushbar(context, 'Error', 'Unable to load data. Check your internet connection');
      }
    } catch (error) {
      // Handle the error, show a message, or log it.
      errorFlushbar(context, 'Error', 'An error occured');
    }
  }

  Future<List<Program>?> fetchSelectedProgram(searchText) async {
    try {
      final response = await http
          .get(Uri.parse(
          'https://demosystem.pythonanywhere.com/get_programs/$searchText/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(response);
        return data.map((courseData) => Program.fromJson(courseData)).toList();
      } else {
        errorFlushbar(context, 'Error', 'Unable to load data. Check your internet connection');
      }
    } catch (error) {
      // Handle the error, show a message, or log it.
      errorFlushbar(context, 'Error', 'An error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context, lastName, firstName, email, matricNumber, level, image),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) =>
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'List of Programs',
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
                          labelText: 'Search your preferred program...',
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
                                    padding: const EdgeInsets.only(right:8.0),
                                    child: Icon(
                                      Icons.rocket_launch,
                                      size: 16.0,
                                      color: Colors.deepPurple,
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
                          _programsFuture =
                              fetchSelectedProgram(searchBarTextController.text);
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
                              'Categories',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                          FutureBuilder<List<Program>?>(
                              future: _programsFuture,
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
                                        'Unable to load data. Check your internet connection',
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
                                        'No program available',
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
                                  final programs = snapshot.data!;
                                  return Column(
                                    children: programs.map((program) {
                                      return Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 8, 16, 8),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            Navigator.of(context).push(
                                                createRoute(CourseMaterialDownloadScreen(
                                                    program: program)));
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[50],
                                              borderRadius: BorderRadius.circular(
                                                  8),
                                            ),
                                            child: Padding(
                                              padding:
                                              EdgeInsetsDirectional.fromSTEB(12, 12,
                                                  16, 12),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .circular(8),
                                                    child: Icon(
                                                      Icons.text_snippet_sharp,
                                                      size: 16.0,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        16, 0, 0, 0),
                                                    child: Text(
                                                      program.name,
                                                      style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .normal,
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
      ),
    );
  }
}

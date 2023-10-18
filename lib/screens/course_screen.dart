import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/navigation_manager.dart';
import '../components/notification_manager.dart';
import '../components/route_manager.dart';
import 'course_details_screen.dart';
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

class CourseScreen extends StatefulWidget {
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  Future<List<Program>?>? _programsFuture;

  @override
  void initState() {
    super.initState();
    _programsFuture = fetchCourses();
  }

  Future<List<Program>?> fetchCourses() async {
    try {
      final response = await http.get(
          Uri.parse('https://demosystem.pythonanywhere.com/get_programs'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((courseData) => Program.fromJson(courseData)).toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (error) {
      // Handle the error, show a message, or log it.
      print(error);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopBar(context),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  elevation: 2,
                  color: Colors.deepPurple[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: CardTitle('Select Course', Icons.double_arrow_sharp),
                      ),
                      const SizedBox(height: 10),
                      FutureBuilder<List<Program>?>(
                        future: _programsFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator(); // Show a loading indicator.
                          } else if (snapshot.hasError || snapshot.data == null) {
                            return const Text('Failed to load courses'); // Show an error message.
                          } else {
                            final programs = snapshot.data!;
                            return Column(
                              children: programs.map((program) {
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(program.name),
                                        onTap: () {
                                          Navigator.of(context).push(
                                            createRoute(CourseDetailScreen(program: program)),
                                          );
                                        },
                                      ),
                                      const Divider(
                                        color: Colors.grey,
                                      ),
                                    ]
                                  ),
                                );
                              }).toList(),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(context, 1),
    );
  }
}

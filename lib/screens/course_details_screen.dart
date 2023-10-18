import 'dart:convert';
import 'package:flutter/material.dart';
import '../components/alert_manager.dart';
import '../components/navigation_manager.dart';
import '../components/notification_manager.dart';
import 'course_screen.dart';
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

Future<List<CourseMaterial>> fetchCourseMaterialsByProgram(String programName) async {
  final response = await http.get(Uri.parse('https://demosystem.pythonanywhere.com/get_course_materials/$programName'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((materialData) => CourseMaterial.fromJson(materialData)).toList();
  } else {
    throw Exception('Failed to load course materials');
  }
}

class CourseDetailScreen extends StatefulWidget {
  final Program program;

  CourseDetailScreen({required this.program});

  @override
  _CourseDetailScreenState createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  List<CourseMaterial> courseMaterials = [];

  @override
  void initState() {
    super.initState();
    fetchCourseMaterials();
  }

  void fetchCourseMaterials() async {
    try {
      final materials = await fetchCourseMaterialsByProgram(widget.program.name);
      setState(() {
        courseMaterials = materials;
      });
    } catch (e) {
      print('Failed to load course materials: $e');
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CardTitle('Available Course Materials', Icons.download),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: courseMaterials.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      courseMaterials[index].title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                    subtitle: const Text(
                                      'Click to download',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    onTap: () async {
                                      infoFlushbar(context, "Please Wait", "Downloading...");
                                      // Implement material download logic here
                                      const baseUrl = 'https://demosystem.pythonanywhere.com/';
                                      final materialUrl = baseUrl + courseMaterials[index].file;
                                      if (await canLaunchUrl(Uri.parse(materialUrl))) {
                                        await launchUrl(Uri.parse(materialUrl));
                                        successFlushbar(context, "Success", "Download Complete");
                                      } else {
                                        errorFlushbar(context, "Error", "Download failed");
                                        throw 'Could not launch $materialUrl';
                                      }
                                    },
                                  ),
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            );
                          },
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
      bottomNavigationBar: BottomBar(context, 1),
    );
  }
}

import 'package:flutter/material.dart';
import '../components/alert_manager.dart';
import '../components/input_manager.dart';
import '../components/route_manager.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController matricNoController = TextEditingController();
  String? selectedProgram; // Changed to String
  TextEditingController levelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/login_bg.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.8),
            padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Image.asset('assets/logo.png', width: 100, height: 100),
                  ),
                  const SizedBox(height: 20),
                  // Input Fields
                  buildInputField(
                    labelText: 'Last Name (Surname)',
                    icon: Icons.person,
                    isDateField: false,
                    context: context,
                    controller: lastNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  buildInputField(
                    labelText: 'First Name',
                    icon: Icons.person,
                    isDateField: false,
                    context: context,
                    controller: firstNameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  buildInputField(
                    labelText: 'Matric No',
                    icon: Icons.school,
                    isDateField: false,
                    context: context,
                    controller: matricNoController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  buildInputField(
                    labelText: 'Email',
                    icon: Icons.email,
                    isDateField: false,
                    context: context,
                    controller: emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  // Program selection using DropdownButtonFormField
                  buildInputField(
                    labelText: 'Program',
                    icon: Icons.book,
                    isDateField: false,
                    context: context,
                    // Removed controller from here
                    validator: (value) {
                      if (value == null) {
                        return 'This field is required';
                      }
                      return null;
                    },
                    inputField: DropdownButtonFormField<String>(
                      value: selectedProgram,
                      hint: const Row(
                        children: <Widget>[
                          Icon(Icons.book, color: Colors.white),
                          SizedBox(width: 10),
                          Text('Select Program', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                        ],
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedProgram = newValue;
                        });
                      },
                      items: [
                        'Computer Science',
                        'Software Engineering',
                        'Cyber Security',
                        'Biochemistry',
                        'Industrial Chemistry',
                        'Business Administration',
                        'Mass Communication',
                        'Criminology',
                        'Microbiology',
                        'Economics/Accounting',
                      ].map((String program) {
                        return DropdownMenuItem<String>(
                          value: program,
                          child: Row(
                            children: <Widget>[
                              const Icon(Icons.book, color: Colors.white),
                              const SizedBox(width: 10),
                              Text(program, style: const TextStyle(color: Colors.white, fontSize: 12.0)),
                            ],
                          ),
                        );
                      }).toList(),
                      dropdownColor: Colors.grey,
                    ),
                  ),
                  buildInputField(
                    labelText: 'Level',
                    icon: Icons.school,
                    isDateField: false,
                    context: context,
                    controller: levelController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  buildInputField(
                    labelText: 'Password',
                    icon: Icons.lock,
                    isDateField: false,
                    context: context,
                    isObscure: true,
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  buildInputField(
                    labelText: 'Confirm Password',
                    icon: Icons.lock,
                    isDateField: false,
                    context: context,
                    isObscure: true,
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Confirm Password is required';
                      } else if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      infoFlushbar(context, "Please Wait", "Processing...");
                      if (_formKey.currentState!.validate()) {
                        final response = await http.post(
                          Uri.parse('https://demosystem.pythonanywhere.com/register/'),
                          headers: {
                            "Content-Type": "application/json",
                          },
                          body: jsonEncode({
                            'last_name': lastNameController.text,
                            'first_name': firstNameController.text,
                            'matric_no': matricNoController.text,
                            'email': emailController.text,
                            'program': selectedProgram, // Updated
                            'level': levelController.text,
                          }),
                        );

                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );

                          if (response.statusCode == 201) {
                            successFlushbar(context, "Success", "Registration successful");
                            Future.delayed(Duration(seconds: 3), (){
                              Navigator.of(context).push(createRoute(LoginScreen()));
                            });
                          } else {
                            errorFlushbar(context, "Registration failed", response.body);
                          }
                        } catch (e) {
                          errorFlushbar(context, "Registration failed", "$e");
                        }
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.deepPurpleAccent),
                      minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
                    ),
                    child: const Text('Register',
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(createRoute(LoginScreen()));
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

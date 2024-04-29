import 'package:flutter/material.dart';
import '../components/alert_manager.dart';
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
  String? level;
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
                                  'Create Account',
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
                                    'Let\'s get started by filling out the form below.',
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
                                      controller: lastNameController,
                                      autofillHints: [AutofillHints.familyName],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
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
                                      TextInputType.text,
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
                                      controller: firstNameController,
                                      autofillHints: [AutofillHints.name],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'First Name',
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
                                      TextInputType.text,
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
                                      controller: matricNoController,
                                      autofillHints: [AutofillHints.nickname],
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Matric No',
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
                                      TextInputType.text,
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
                                    child: DropdownButtonFormField<String>(
                                      value: selectedProgram,
                                      hint: Row(
                                        children: <Widget>[
                                          Text(
                                              'Program',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0,
                                                fontFamily: 'Plus Jakarta Sans',
                                                letterSpacing: 0,
                                              )
                                          ),
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
                                              Text(
                                                  program,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0,
                                                    fontFamily: 'Plus Jakarta Sans',
                                                    letterSpacing: 0,
                                                  )
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      dropdownColor: Colors.grey[100],
                                      decoration: InputDecoration(
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
                                    child: DropdownButtonFormField<String>(
                                      value: level,
                                      hint: const Row(
                                        children: <Widget>[
                                          Text(
                                              'Level',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0,
                                                fontFamily: 'Plus Jakarta Sans',
                                                letterSpacing: 0,
                                              )
                                          ),
                                        ],
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          level = newValue;
                                        });
                                      },
                                      items: [
                                        '100',
                                        '200',
                                        '300',
                                        '400',
                                      ].map((String level) {
                                        return DropdownMenuItem<String>(
                                          value: level,
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                  level,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.0,
                                                    fontFamily: 'Plus Jakarta Sans',
                                                    letterSpacing: 0,
                                                  )
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                      dropdownColor: Colors.grey[100],
                                      decoration: InputDecoration(
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
                                            'level': level,
                                          }),
                                        );

                                        try {
                                          if (response.statusCode == 201) {
                                            UserCredential userCredential = await FirebaseAuth
                                                .instance
                                                .createUserWithEmailAndPassword(
                                              email: emailController.text,
                                              password: passwordController.text,
                                            );
                                            successFlushbar(context, "Success", "Registration successful");
                                            Future.delayed(Duration(seconds: 3), (){
                                              Navigator.of(context).push(createRoute(LoginScreen()));
                                            });
                                          } else {
                                            errorFlushbar(context, "Registration failed", 'An error occurred. Please try again.');
                                          }
                                        } catch (e) {
                                          errorFlushbar(context, "Error", 'An error occurred. Please try again.');
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
                                          'Already have an account? ',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => {
                                            Navigator.of(context).pushAndRemoveUntil(createRoute(LoginScreen()), (route) => false)
                                          },
                                          child: Text(
                                            ' Sign In here',
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
    //   body: SingleChildScrollView(
    //     child: Container(
    //       decoration: const BoxDecoration(
    //         image: DecorationImage(
    //           image: AssetImage('assets/login_bg.jpg'),
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       child: Container(
    //         color: Colors.black.withOpacity(0.8),
    //         padding: const EdgeInsets.fromLTRB(50.0, 0, 50.0, 0),
    //         child: Form(
    //           key: _formKey,
    //           child: Column(
    //             children: [
    //               Padding(
    //                 padding: const EdgeInsets.only(top: 20.0),
    //                 child: Image.asset('assets/images/logo.png', width: 100, height: 100),
    //               ),
    //               const SizedBox(height: 20),
    //               // Input Fields
    //               buildInputField(
    //                 labelText: 'Last Name (Surname)',
    //                 icon: Icons.person,
    //                 isDateField: false,
    //                 context: context,
    //                 controller: lastNameController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'This field is required';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               buildInputField(
    //                 labelText: 'First Name',
    //                 icon: Icons.person,
    //                 isDateField: false,
    //                 context: context,
    //                 controller: firstNameController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'This field is required';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               buildInputField(
    //                 labelText: 'Matric No',
    //                 icon: Icons.school,
    //                 isDateField: false,
    //                 context: context,
    //                 controller: matricNoController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'This field is required';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               buildInputField(
    //                 labelText: 'Email',
    //                 icon: Icons.email,
    //                 isDateField: false,
    //                 context: context,
    //                 controller: emailController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'This field is required';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               // Program selection using DropdownButtonFormField
    //               buildInputField(
    //                 labelText: 'Program',
    //                 icon: Icons.book,
    //                 isDateField: false,
    //                 context: context,
    //                 // Removed controller from here
    //                 validator: (value) {
    //                   if (value == null) {
    //                     return 'This field is required';
    //                   }
    //                   return null;
    //                 },
    //                 inputField: DropdownButtonFormField<String>(
    //                   value: selectedProgram,
    //                   hint: const Row(
    //                     children: <Widget>[
    //                       Icon(Icons.book, color: Colors.white),
    //                       SizedBox(width: 10),
    //                       Text('Select Program', style: TextStyle(color: Colors.grey, fontSize: 12.0)),
    //                     ],
    //                   ),
    //                   onChanged: (String? newValue) {
    //                     setState(() {
    //                       selectedProgram = newValue;
    //                     });
    //                   },
    //                   items: [
    //                     'Computer Science',
    //                     'Software Engineering',
    //                     'Cyber Security',
    //                     'Biochemistry',
    //                     'Industrial Chemistry',
    //                     'Business Administration',
    //                     'Mass Communication',
    //                     'Criminology',
    //                     'Microbiology',
    //                     'Economics/Accounting',
    //                   ].map((String program) {
    //                     return DropdownMenuItem<String>(
    //                       value: program,
    //                       child: Row(
    //                         children: <Widget>[
    //                           const Icon(Icons.book, color: Colors.white),
    //                           const SizedBox(width: 10),
    //                           Text(program, style: const TextStyle(color: Colors.white, fontSize: 12.0)),
    //                         ],
    //                       ),
    //                     );
    //                   }).toList(),
    //                   dropdownColor: Colors.grey,
    //                 ),
    //               ),
    //               buildInputField(
    //                 labelText: 'Level',
    //                 icon: Icons.school,
    //                 isDateField: false,
    //                 context: context,
    //                 controller: levelController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'This field is required';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               buildInputField(
    //                 labelText: 'Password',
    //                 icon: Icons.lock,
    //                 isDateField: false,
    //                 context: context,
    //                 isObscure: true,
    //                 controller: passwordController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'This field is required';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               buildInputField(
    //                 labelText: 'Confirm Password',
    //                 icon: Icons.lock,
    //                 isDateField: false,
    //                 context: context,
    //                 isObscure: true,
    //                 controller: confirmPasswordController,
    //                 validator: (value) {
    //                   if (value!.isEmpty) {
    //                     return 'Confirm Password is required';
    //                   } else if (value != passwordController.text) {
    //                     return 'Passwords do not match';
    //                   }
    //                   return null;
    //                 },
    //               ),
    //               const SizedBox(height: 20),
    //               ElevatedButton(
    //                 onPressed: () async {
    //                   infoFlushbar(context, "Please Wait", "Processing...");
    //                   if (_formKey.currentState!.validate()) {
    //                     final response = await http.post(
    //                       Uri.parse('https://demosystem.pythonanywhere.com/register/'),
    //                       headers: {
    //                         "Content-Type": "application/json",
    //                       },
    //                       body: jsonEncode({
    //                         'last_name': lastNameController.text,
    //                         'first_name': firstNameController.text,
    //                         'matric_no': matricNoController.text,
    //                         'email': emailController.text,
    //                         'program': selectedProgram, // Updated
    //                         'level': levelController.text,
    //                       }),
    //                     );
    //
    //                     try {
    //                       UserCredential userCredential = await FirebaseAuth
    //                           .instance
    //                           .createUserWithEmailAndPassword(
    //                         email: emailController.text,
    //                         password: passwordController.text,
    //                       );
    //
    //                       if (response.statusCode == 201) {
    //                         successFlushbar(context, "Success", "Registration successful");
    //                         Future.delayed(Duration(seconds: 3), (){
    //                           Navigator.of(context).push(createRoute(LoginScreen()));
    //                         });
    //                       } else {
    //                         errorFlushbar(context, "Registration failed", response.body);
    //                       }
    //                     } catch (e) {
    //                       errorFlushbar(context, "Registration failed", "$e");
    //                     }
    //                   }
    //                 },
    //                 style: ButtonStyle(
    //                   backgroundColor: MaterialStateProperty.all<Color>(
    //                       Colors.deepPurpleAccent),
    //                   minimumSize: MaterialStateProperty.all<Size>(const Size(200, 50)),
    //                 ),
    //                 child: const Text('Register',
    //                     style: TextStyle(color: Colors.white)),
    //               ),
    //               const SizedBox(height: 10),
    //               GestureDetector(
    //                 onTap: () {
    //                   Navigator.of(context).push(createRoute(LoginScreen()));
    //                 },
    //                 child: const Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       'Already have an account? ',
    //                       style: TextStyle(
    //                         color: Colors.white,
    //                         fontStyle: FontStyle.italic,
    //                       ),
    //                     ),
    //                     Icon(
    //                       Icons.arrow_forward,
    //                       color: Colors.white,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(height: 60),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

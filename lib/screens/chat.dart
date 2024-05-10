import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/components/alert_manager.dart';
import 'dart:convert';

import '../components/drawer.dart';

class ChatScreen extends StatefulWidget {
  final String lastName;
  final String firstName;
  final String matricNumber;
  final String level;
  final String email;
  final String image;
  ChatScreen({super.key, required this.lastName, required this.firstName, required this.email, required this.matricNumber, required this.level, required this.image});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textController = TextEditingController();

  late String lastName;
  late String firstName;
  late String matricNumber;
  late String level;
  late String email;
  late String image;

  final List<Map<String, dynamic>> _messages = [];

  void _addMessage(String message, {bool isUser = true}) {
    setState(() {
      _messages.add({
        'text': message,
        'isUser': isUser,
      });
    });
  }

  Future<void> _getResponse(String userInput) async {
    final String apiKey = 'YOUR_API_KEY';
    final String endpoint =
        'https://api.openai.com/v1/engines/davinci/completions';

    final response = await http.post(Uri.parse(endpoint), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    }, body: {
      'prompt': userInput,
      'max_tokens': '150', // Adjust token length as per your requirement
    });

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final chatResponse = responseData['choices'][0]['text'];
      _addMessage(chatResponse, isUser: false);
    } else {
      throw Exception('Failed to load response');
    }
  }

  @override
  void initState() {
    super.initState();
    lastName = widget.lastName;
    firstName = widget.firstName;
    email = widget.email;
    matricNumber = widget.matricNumber;
    level = widget.level;
    image = widget.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context, lastName, firstName, email, matricNumber, level, image),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Chat With AI',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 22,
            letterSpacing: 0,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Container(
              width: 60,
              height: 60,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.96,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0.0,
                                  2,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView.builder(
                          itemCount: _messages.length,
                          itemBuilder: (context, index) {
                            final message = _messages[index];
                            return ListTile(
                              title: message['isUser']
                                  ? Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 12, 0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.96,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 4,
                                              color: Color(0x33000000),
                                              offset: Offset(
                                                0.0,
                                                2,
                                              ),
                                            )
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(2),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 12, 16, 0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.all(2),
                                                        child: Container(
                                                          width: 25,
                                                          height: 25,
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Image.network(
                                                            image,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        // '${firstName} ${lastName}',
                                                        '${firstName} ${lastName}',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily: 'Outfit',
                                                          fontSize: 16,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 4, 16, 12),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          message['text'],
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'Outfit',
                                                            fontSize: 14,
                                                            letterSpacing: 0,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.96,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 4,
                                            color: Color(0x33000000),
                                            offset: Offset(
                                              0.0,
                                              2,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 12, 0, 12),
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.96,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        blurRadius: 4,
                                                        color:
                                                            Color(0x33000000),
                                                        offset: Offset(
                                                          0.0,
                                                          2,
                                                        ),
                                                      )
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 12, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      'ChatGPT',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontFamily: 'Outfit',
                                                        fontSize: 16,
                                                        letterSpacing: 0,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(2),
                                                      child: Container(
                                                        width: 25,
                                                        height: 25,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.asset(
                                                          'assets/images/userAvatar.png',
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 4, 16, 12),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        message['text'],
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.black,
                                                          fontFamily: 'Outfit',
                                                          fontSize: 14,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 12),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.96,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4,
                            color: Color(0x33000000),
                            offset: Offset(
                              0.0,
                              2,
                            ),
                          )
                        ],
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.96,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(
                            0.0,
                            2,
                          ),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  child: TextFormField(
                                    controller: textController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelText: 'Ask Anything...',
                                      labelStyle: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0,
                                      ),
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                        fontFamily: 'Outfit',
                                        letterSpacing: 0,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              16, 12, 16, 12),
                                    ),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0,
                                    ),
                                    maxLines: null,
                                    cursorColor: Colors.black,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'This field cannot be empty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => {
                                    _addMessage(textController.text),
                                    _getResponse(textController.text),
                                    textController.clear(),
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.blueAccent,
                                      size: 28.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

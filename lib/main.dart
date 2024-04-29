import 'dart:js';
import 'package:flutter/material.dart';
import 'package:student_portal/screens/reset_password.dart';
import 'package:student_portal/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Configure Firebase Dynamic Links
  final PendingDynamicLinkData? dynamicLink = await FirebaseDynamicLinks.instance.getInitialLink();
  if (dynamicLink != null) {
    _handleDynamicLink(dynamicLink.link); // Handle the initial link if present
  }

  FirebaseDynamicLinks.instance.onLink.listen((pendingLinkData) {
    final Uri deepLink = pendingLinkData.link;
    _handleDynamicLink(deepLink); // Handle subsequent link changes
  });

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Portal',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}

Future<void> _handleDynamicLink(Uri link) async {
  // Extract the password reset token from the URL parameters (modify if needed)
  final resetToken = link.queryParameters['token'];

  if (resetToken != null) {
    // Navigate to the ChangePasswordPage with the token
    Navigator.push(
      context as BuildContext,
      MaterialPageRoute(
        builder: (context) => ResetPasswordScreen(resetToken: resetToken!),
      ),
    );
  }
}

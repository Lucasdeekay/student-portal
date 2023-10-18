import 'package:flutter/material.dart';
import 'package:student_portal/screens/login.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  double logoOpacity = 0.0;
  double textOpacity = 0.0;
  double progress = 0.0;

  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // Delay the fading of the logo and text
    Future.delayed(const Duration(seconds: 1), () {
      _startFading();
    });

    // Navigate to the main screen
    Future.delayed(const Duration(seconds: 8), () {
      _navigateToMainScreen();
    });
  }

  void _startFading() {
    setState(() {
      logoOpacity = 1.0;
      textOpacity = 1.0;
    });
  }

  void _navigateToMainScreen() {
    _pageController.nextPage(
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      children: [
        Scaffold(
          backgroundColor: Colors.deepPurple[100],
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated logo fading in
                AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: logoOpacity,
                  child: Image.asset('assets/logo.png', width: 100, height: 100),
                ),
                const SizedBox(height: 16),
                // Text fading in over 4 seconds
                AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: textOpacity,
                  child: const Text(
                    'My Student Portal',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const CircularProgressIndicator(),
              ],
            ),
          ),
        ),
        // Add your main screen here
        LoginScreen(),
      ],
    );
  }
}

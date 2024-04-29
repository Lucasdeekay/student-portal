import 'package:flutter/material.dart';
import 'package:student_portal/components/route_manager.dart';
import 'package:student_portal/screens/login.dart';
import 'package:student_portal/screens/registration.dart';

import '../components/alert_manager.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  // double logoOpacity = 0.0;
  // double textOpacity = 0.0;
  // double progress = 0.0;
  //
  // final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // // Delay the fading of the logo and text
    // Future.delayed(const Duration(seconds: 1), () {
    //   _startFading();
    // });

    // // Navigate to the main screen
    // Future.delayed(const Duration(seconds: 8), () {
    //   _navigateToMainScreen();
    // });
  }

  // void _startFading() {
  //   setState(() {
  //     logoOpacity = 1.0;
  //     textOpacity = 1.0;
  //   });
  // }

  // void _navigateToMainScreen() {
  //   _pageController.nextPage(
  //     duration: const Duration(seconds: 1),
  //     curve: Curves.easeInOut,
  //   );
  // }

  // @override
  // void dispose() {
  //   // _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            maxWidth: 670,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset('assets/images/login_bg.jpg').image,
                    ),
                  ),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0x00FFFFFF),
                          Colors.white
                        ],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                    ),
                    alignment: AlignmentDirectional(0, 1),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(24, 64, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset('assets/images/logo.png', width: 100, height: 100),
                          Text(
                            'Raising Generational Leaders',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 45.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 44, 0, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 16),
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pushAndRemoveUntil(createRoute(RegistrationScreen()), (route) => false);
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.black),
                          minimumSize: MaterialStateProperty.all<Size>(const Size(double.infinity, 60)),
                          elevation: MaterialStateProperty.all<double>(0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                              child: Icon(
                                Icons.launch,
                                color: Colors.white,
                                size: 24.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              child: Text(
                                'Sign up your account',
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
                      padding: EdgeInsetsDirectional.fromSTEB(150, 24, 0, 64),
                      child: Row(
                        children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                letterSpacing: 0,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => {
                                Navigator.of(context).pushAndRemoveUntil(createRoute(LoginScreen()), (route) => false)
                              },
                              child: Text(
                                ' Log In!',
                                style: TextStyle(
                                  fontFamily: 'Plus Jakarta Sans',
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

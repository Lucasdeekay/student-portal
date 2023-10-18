import 'package:flutter/material.dart';

PageRouteBuilder createRoute(Widget Screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Screen,
    // Replace with your login page
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween =
      Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
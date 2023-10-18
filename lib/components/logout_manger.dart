import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // Static method to handle logout
  static Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      // Handle any potential errors during logout
      print('Error during logout: $e');
      // You can also throw an exception or return an error message if needed.
    }
  }
}

import 'package:cipherschool_expense_tracking_app/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cipherschool_expense_tracking_app/services/auth_service.dart';

class SignUpProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _obscureText = true;
  bool _termsAccepted = false;
  bool _isLoading = false;

  bool get obscureText => _obscureText;
  bool get termsAccepted => _termsAccepted;
  bool get isLoading => _isLoading;

  void togglePasswordVisibility() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void toggleTermsAccepted(bool value) {
    _termsAccepted = value;
    notifyListeners();
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    UserCredential? userCredential = await _authService.signInWithGoogle();
    _isLoading = false;
    notifyListeners();

    if (userCredential != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      ); // Navigate to Home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google Sign-In Failed!")),
      );
    }
  }
}

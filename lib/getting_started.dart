import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cipherschool_expense_tracking_app/Screens/Home.dart';
import 'package:cipherschool_expense_tracking_app/Screens/signup_page.dart';

class Getting_started extends StatelessWidget {
  const Getting_started({super.key});

  // Method to handle navigation based on authentication status
  void _navigateToNextScreen(BuildContext context) async {
    // Check current authentication state
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // User is already logged in, navigate to Home screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // No user logged in, navigate to SignUp page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignUpScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7E57FF), // Light purple
                  Color(0xFF6C45FF), // Darker purple
                ],
              ),
            ),
          ),

          // Top Right Circle Decoration
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: 220,
              height: 220,
              child: Image.asset("assets/recordcircle.png"),
            ),
          ),
          Positioned(
            top: 50,
            left: 20,
            child: SizedBox(
              width: 70,
              height: 70,
              child: Image.asset("assets/Vector.png"),
            ),
          ),
          // Top Left Logo
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: 220,
              height: 220,
              child: Image.asset("assets/recordcircle1.png"),
            ),
          ),

          // Bottom Left - Welcome Text + Button (Clickable Image)
          Positioned(
            bottom: 70,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => _navigateToNextScreen(context),
              child: Image.asset(
                "assets/Group262.png", // Your provided image
                width: MediaQuery.of(context).size.width * 0.9,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
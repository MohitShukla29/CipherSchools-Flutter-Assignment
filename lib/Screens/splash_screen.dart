import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF7E57FF), // Slightly lighter purple at top
                  Color(0xFF6C45FF), // Main purple color
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/recordcircle.png"),
                  fit: BoxFit.cover, // Ensures proper scaling
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              width: 220,
              height: 220,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/recordcircle1.png"),
                  fit: BoxFit.cover, // Ensures proper scaling
                ),
              ),
            ),
          ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Takes most of the space
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Logo
                        Container(
                          width: 80,
                          height: 80,
                          child: Image.asset("assets/Vector.png")
                        ),
                        const SizedBox(height: 16),
                        // CipherX Text
                        const Text(
                          'CipherX',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.2,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Bottom section
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // "By Open Source Community" text
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'By',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Open Source ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Community',
                                style: TextStyle(
                                  color: Color(0xFFFFAA00), // Orange color
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Progress indicator
                      Container(
                        width: 120,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),

        ],
      ),
    );
  }
}

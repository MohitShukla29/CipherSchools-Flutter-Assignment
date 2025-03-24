import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cipherschool_expense_tracking_app/controller/signup_provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SignUpProvider>(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: provider.obscureText,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding: const EdgeInsets.all(16),
                    suffixIcon: IconButton(
                      icon: Icon(
                        provider.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: provider.togglePasswordVisibility,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: provider.termsAccepted,
                        onChanged: (value) =>
                            provider.toggleTermsAccepted(value ?? false),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        activeColor: const Color(0xFF7E3FF2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: RichText(
                        text: const TextSpan(
                          text: 'By signing up, you agree to the ',
                          style: TextStyle(color: Colors.black87, fontSize: 16),
                          children: [
                            TextSpan(
                              text: 'Terms of Service and Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF7E3FF2),
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7E3FF2),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Or with',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => provider.handleGoogleSignIn(context),
                  icon: Image.network(
                    'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                    height: 24,
                    width: 24,
                  ),
                  label: const Text(
                    'Sign Up with Google',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: Colors.grey[300]!),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF7E3FF2),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

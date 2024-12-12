// ignore_for_file: prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yenebuna/constants/colors.dart';
import 'package:yenebuna/screens/home_screen.dart'; // Import your home screen
import 'package:yenebuna/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();

  bool _isLoading = false; // To track loading state

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Email TextField
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: AppColors.tertiaryColor),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor),
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),

        // Password TextField with Forgot Password Link
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: AppColors.tertiaryColor),
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Forgot Password logic here
              print('Forgot Password clicked');
            },
            child: Text(
              'forgot password?',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 30.h),

        // Sign In Button
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.r),
              ),
            ),
            onPressed:
                _isLoading ? null : _login, // Disable button when loading
            child: _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            'continue with',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFFCCD6C4),
            ),
          ),
        ),

        // Social Media Sign-In Buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // Google sign-in logic
              },
              icon: Image.asset(
                'Assets/images/Google.png',
                height: 30.h,
                width: 30.w,
              ),
            ),
            SizedBox(width: 20.w),
            IconButton(
              onPressed: () {
                // Apple sign-in logic
              },
              icon: Image.asset(
                'Assets/images/apple.png',
                height: 30.h,
                width: 30.w,
              ),
            ),
            SizedBox(width: 20.w),
            IconButton(
              onPressed: () {
                // Instagram sign-in logic
              },
              icon: Image.asset(
                'Assets/images/instagram.png',
                height: 30.h,
                width: 30.w,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Login method to handle sign-in
  void _login() async {
    String email = _emailController.text;
    String password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please fill in both email and password');
    } else {
      setState(() {
        _isLoading =
            true;
      });

      try {
        // Call the AuthService login method
        await _authService.loginWithEmailName(email, password);

        // Navigate to Home page after successful login
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      } catch (error) {
        _showErrorDialog(error.toString());
      } finally {
        setState(() {
          _isLoading = false; // Set loading state to false after login process
        });
      }
    }
  }

  // Show error dialog if there is an issue with login
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yenebuna/constants/colors.dart';
import 'package:yenebuna/provider/auth_service.dart';
import 'package:yenebuna/screens/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const String id = 'login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Login method using Riverpod's authProvider
  Future<void> _login() async {
    final authNotifier = ref.read(authProvider.notifier);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorDialog('Please fill in both email and password');
      return;
    }

    try {
      await authNotifier.loginWithEmail(email, password);
      final authState = ref.read(authProvider);

      if (authState.user != null) {
        // Check if email is verified
        if (!authState.user!.emailVerified) {
          _showEmailVerificationDialog();
        } else {
          // Navigate to Home screen
          Navigator.pushReplacementNamed(context, HomeScreen.id);
        }
      } else if (authState.errorMessage != null) {
        _showErrorDialog(authState.errorMessage!);
      }
    } catch (error) {
      _showErrorDialog(error.toString());
    }
  }

  // Show email verification dialog if the email is not verified
  void _showEmailVerificationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Email Verification'),
          content: Text('Please verify your email address before logging in.'),
          actions: [
            TextButton(
              onPressed: () async {
                // Send verification email if not already sent
                try {
                  final authNotifier = ref.read(authProvider.notifier);
                  await authNotifier.sendEmailVerification();
                  Navigator.of(context).pop();
                  _showInfoDialog(
                      'Verification email sent. Please check your inbox.');
                } catch (e) {
                  Navigator.of(context).pop();
                  _showErrorDialog('Failed to send verification email.');
                }
              },
              child: Text('Resend Email'),
            ),
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

  // Show information dialog
  void _showInfoDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Info'),
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

  // Error dialog to display login issues
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

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

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
              'Forgot password?',
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
            onPressed: authState.isLoading ? null : _login,
            child: authState.isLoading
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
            'Continue with',
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
}

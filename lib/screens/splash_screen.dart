// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yenebuna/screens/home_screen.dart';
import 'package:yenebuna/screens/onboarding.dart';
import 'package:yenebuna/screens/signUp_screen.dart';
import 'package:yenebuna/services/auth_service.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splashScreen";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  // Check if the app is launched for the first time
  Future<void> _checkFirstLaunch() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isFirstLaunch =
        prefs.getBool('isFirstLaunch') ?? true; // Default to true

    if (isFirstLaunch) {
      // If first launch, set flag to false and navigate to onboarding page
      await prefs.setBool('isFirstLaunch', false);
      _navigateTo(OnboardingPage.id);
    } else {
      // If not first launch, check if the user is logged in
      _checkUserLoggedIn();
    }
  }

  // Check if the user is logged in
  Future<void> _checkUserLoggedIn() async {
    FirebaseAuthService authService = FirebaseAuthService();

    bool isLoggedIn = await authService.isLoggedIn();

    if (isLoggedIn) {
      _navigateTo(HomeScreen.id);
    } else {
      _navigateTo(SignUpPage.id);
    }
  }

  // Navigate to the specified page
  void _navigateTo(String route) {
    Navigator.popAndPushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

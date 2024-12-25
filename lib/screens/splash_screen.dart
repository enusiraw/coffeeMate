import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';
import 'onboarding.dart';
import 'signUp_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String id = "splashScreen";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

      if (isFirstLaunch) {
        await prefs.setBool('isFirstLaunch', false);
        _navigateTo(OnboardingPage.id);
        return;
      }

      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        debugPrint("User is logged in: ${user.email}");
        _navigateTo(HomeScreen.id);
      } else {
        _navigateTo(SignUpPage.id);
      }
    } catch (e) {
      debugPrint("Error during initialization: $e");
      _navigateTo(SignUpPage.id);
    }
  }

  void _navigateTo(String route) {
    if (!mounted) return;
    Navigator.pushReplacementNamed(context, route);
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

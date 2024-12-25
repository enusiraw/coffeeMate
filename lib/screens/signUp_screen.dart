// ignore_for_file: file_names, use_build_context_synchronously, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yenebuna/constants/colors.dart';
import 'package:yenebuna/provider/auth_service.dart';
import 'package:yenebuna/screens/home_screen.dart';
import 'package:yenebuna/screens/login_screen.dart';
import 'package:yenebuna/services/auth_service.dart';

import '../widgets/bottom_clipper.dart';

class SignUpPage extends ConsumerStatefulWidget {
  static const String id = 'signup';
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  bool isSignUpSelected = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final FirebaseAuthService _authService = FirebaseAuthService();
  OverlayEntry? _overlayEntry;

   // Sign-up handler using Riverpod's authProvider
  void _signUp() async {
    final authNotifier = ref.read(authProvider.notifier);
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final name = nameController.text.trim();

    await authNotifier.signUpWithEmail(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      name: name,
    );

    final authState = ref.read(authProvider);

    if (authState.user != null) {
      Navigator.pushNamed(context, HomeScreen.id);
    } else if (authState.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(authState.errorMessage!)),
      );
    }
  }
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside of the text fields
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            // Background image or design here
            ClipPath(
              clipper: BottomClipper(),
              child: Container(
                color: AppColors.mainColor,
                height: MediaQuery.of(context).size.height * 0.378,
                child: Center(
                  child: Image.asset("Assets/images/logo.png"),
                ),
              ),
            ),
            // Main content
            Positioned(
              top: MediaQuery.of(context).size.height * 0.289,
              left: MediaQuery.of(context).size.width * 0.05,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Sign Up and Sign In buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUpSelected = true;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: isSignUpSelected
                                      ? AppColors.tertiaryColor
                                      : AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSignUpSelected = false;
                                });
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: !isSignUpSelected
                                      ? AppColors.tertiaryColor
                                      : AppColors.mainColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Form content
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          child: isSignUpSelected
                              ? _signupContent()
                              : LoginScreen()),
                    ),
                  ],
                ),
              ),
            ),
            // Overlay content (optional)
            _overlayEntry != null
                ? Positioned(
                    bottom: 50,
                    left: 50,
                    child: Material(
                      color: Colors.transparent,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          width: 200,
                          height: 100,
                          child: const Center(child: Text('Overlay Content')),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  // Custom text field widget
  Widget _customTextField({
    required String labelText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: AppColors.tertiaryColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
      ),
    );
  }

// Sign-up form
    Widget _signupContent() {
    final authState = ref.watch(authProvider);

    return Column(
      children: [
        _customTextField(labelText: 'Name', controller: nameController),
        const SizedBox(height: 20),
        _customTextField(
          labelText: 'Email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        _customTextField(
          labelText: 'Password',
          controller: passwordController,
          obscureText: true,
        ),
        const SizedBox(height: 20),
        _customTextField(
          labelText: 'Confirm Password',
          controller: confirmPasswordController,
          obscureText: true,
        ),
        SizedBox(height: 30),

        // Sign-Up Button
        SizedBox(
          width: double.infinity,
          height: 49,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: authState.isLoading ? null : _signUp,
            child: authState.isLoading
                ? CircularProgressIndicator(color: Colors.white)
                : const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        const SizedBox(height: 20),

        // Social Media Icons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                // Add Google sign-up logic
              },
              icon: Image.asset(
                'Assets/images/Google.png',
                height: 30,
                width: 30,
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                // Add Apple sign-up logic
              },
              icon: Image.asset(
                'Assets/images/apple.png',
                height: 30,
                width: 30,
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                // Add Instagram sign-up logic
              },
              icon: Image.asset(
                'Assets/images/instagram.png',
                height: 30,
                width: 30,
              ),
            ),
          ],
        ),
      ],
    );
  }

}

import 'package:flutter/material.dart';
import 'package:yenebuna/constants/colors.dart';

import '../widgets/bottom_clipper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isSignUpSelected = true;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  OverlayEntry? _overlayEntry;

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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Sign Up and Sign In buttons
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isSignUpSelected
                              ? AppColors.tertiaryColor
                              : AppColors.mainColor,
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
                                child: Center(
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
                                child: Center(
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
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        child: isSignUpSelected
                            ? _signupContent(context)
                            : _signinContent(context),
                      ),
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
                        onTap: () {
                          _removeOverlay();
                        },
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          width: 200,
                          height: 100,
                          child: Center(child: Text('Overlay Content')),
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showOverlay(context);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  // Show overlay
  void _showOverlay(BuildContext context) {
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 50,
        left: 50,
        child: Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: () {
              _removeOverlay();
            },
            child: Container(
              color: Colors.black.withOpacity(0.5),
              width: 200,
              height: 100,
              child: Center(child: Text('Overlay Content')),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  // Remove overlay
  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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
        labelStyle: TextStyle(color: AppColors.tertiaryColor),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
      ),
    );
  }

  // Sign-up form
  Widget _signupContent(BuildContext context) {
    return Column(
      children: [
        _customTextField(labelText: 'Name', controller: nameController),
        SizedBox(height: 20),
        _customTextField(
          labelText: 'Email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20),
        _customTextField(
          labelText: 'Password',
          controller: passwordController,
          obscureText: true,
        ),
        SizedBox(height: 20),
        _customTextField(
          labelText: 'Confirm Password',
          controller: confirmPasswordController,
          obscureText: true,
        ),
      ],
    );
  }

  // Sign-in form
  Widget _signinContent(BuildContext context) {
    return Column(
      children: [
        _customTextField(
          labelText: 'Email',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 20),
        _customTextField(
          labelText: 'Password',
          controller: passwordController,
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add sign-in logic here
          },
          child: Text('Sign In'),
        ),
      ],
    );
  }
}

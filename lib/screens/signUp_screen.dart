import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yenebuna/constants/colors.dart';
import 'package:yenebuna/widgets/bottom_clipper.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isSignUpSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        clipBehavior: Clip.none, // Allows the Positioned widget to overflow
        children: [
          // Background with ClipPath
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
          // Overlay container
          Positioned(
            top: MediaQuery.of(context).size.height * 0.289,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.r,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Sign Up and Sign In buttons in the same container
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isSignUpSelected
                            ? AppColors.mainColor
                            : AppColors.tertiaryColor,
                        borderRadius: BorderRadius.circular(20.r),
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
                                    fontSize: 16.sp,
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
                                    fontSize: 16.sp,
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
                  // Add your other content here
                  Expanded(
                    child: Center(
                        child: isSignUpSelected
                            ? _signupContent(context)
                            : _signinContent(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

    // Create a custom text field widget
  Widget _customTextField({
    required String labelText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    TextStyle? labelStyle,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: labelStyle ?? const TextStyle(color: AppColors.tertiaryColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
      ),
    );
  }

  // Create the sign-up content using the custom text field
  Widget _signupContent(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.w),
      child: Column(
        children: [
          _customTextField(labelText: 'Name', controller: nameController),
          SizedBox(height: 20.h),
          _customTextField(
            labelText: 'Email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 20.h),
          _customTextField(
            labelText: 'Password',
            controller: passwordController,
            obscureText: true,
          ),
          SizedBox(height: 20.h),
          _customTextField(
            labelText: 'Confirm Password',
            controller: confirmPasswordController,
            obscureText: true,
          ),
        ],
      ),
    );
  }

  Widget _signinContent(BuildContext context) {
    return const Column();
  }
}

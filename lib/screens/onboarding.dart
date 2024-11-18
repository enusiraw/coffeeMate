import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yenebuna/screens/signUp_screen.dart';

import '../constants/colors.dart';

class OnboardingPage extends StatefulWidget {
  static const String id = 'onboarding';
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushNamed(context, SignUpPage.id);
    }
  }

  void _skip() {
    _pageController.animateToPage(
      2, // Navigate to the last page
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onDotTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Page View
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: [
              _buildPage(
                image: 'Assets/images/page1.png',
                description: 'Get Your coffee mate',
                subDescription: 'Discover the perfect companion for your brew.',
              ),
              _buildPage(
                image: 'Assets/images/page2.png',
                description: 'Share your daily coffee taste',
                subDescription: 'Let others savor the joy of your mornings.',
              ),
              _buildPage(
                image: 'Assets/images/page3.png',
                description: 'Lets enjoy together',
                subDescription: 'Join a community of coffee enthusiasts.',
              ),
            ],
          ),

          // Skip Button
          Positioned(
            top: 40.h,
            right: 20.w,
            child: AnimatedOpacity(
              opacity:
                  _currentPage == 2 ? 0.0 : 1.0, // Hide Skip on the last page
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 78.w,
                height: 29.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: TextButton(
                  onPressed: _skip, // Navigate to the last page
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Dots Indicator
          Positioned(
            bottom: 50.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => GestureDetector(
                  onTap: () => _onDotTapped(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    height: _currentPage == index ? 12.h : 10.h,
                    width: _currentPage == index ? 12.w : 10.w,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.mainColor
                          : AppColors.tertiaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Next/Done Button
          Positioned(
            bottom: 30.h,
            right: 20.w,
            child: AnimatedScale(
              scale: _currentPage == 2 ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                width: 78.w,
                height: 29.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: TextButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == 2 ? 'Done' : 'Next',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build each page
  Widget _buildPage({
    required String image,
    required String description,
    required String subDescription,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(image, width: 250.w, height: 250.h),
          ),
          SizedBox(height: 20.h),
          Text(
            description,
            textAlign: TextAlign.start,
            style: GoogleFonts.inriaSans(
              fontSize: 24.sp,
              color: const Color(0xFF3F0200),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            subDescription,
            textAlign: TextAlign.start,
            style: GoogleFonts.inriaSans(
              fontSize: 16.sp,
              color: const Color(0xFF3F0200),
            ),
          ),
        ],
      ),
    );
  }
}

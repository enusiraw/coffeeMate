import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class OnboardingPage extends StatefulWidget {
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
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    } else {
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  void _skip() {
    Navigator.pushReplacementNamed(context, '/home');
  }

  void _onDotTapped(int index) {
    // Move to the selected page when a dot is tapped
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
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
              ),
              _buildPage(
                image: 'Assets/images/page2.png',
                description: 'Share your daily coffee taste',
              ),
              _buildPage(
                image: 'Assets/images/page3.png',
                description: 'Lets enjoy together',
              ),
            ],
          ),

          // Skip Button
          Positioned(
            top: 40.h,
            right: 20.w,
            child: AnimatedOpacity(
              opacity: _currentPage == 0
                  ? 1.0
                  : 1.0, // Keep Skip button visible at all times
              duration: Duration(milliseconds: 300),
              child: Container(
                width: 78.w,
                height: 29.h,
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: TextButton(
                  onPressed: _skip,
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
                  onTap: () => _onDotTapped(index), // Handle dot tap
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    height: _currentPage == index
                        ? 12.h
                        : 10.h, // Bigger dot for the current page
                    width: _currentPage == index ? 12.w : 10.w,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppColors.mainColor
                          : AppColors.tertiaryColor,
                      shape: BoxShape.circle, // Make the dots circular
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
              scale: _currentPage == 2
                  ? 1.1
                  : 1.0, // Slight scale animation on the last page
              duration: Duration(milliseconds: 300),
              child: Container(
                width: 78.w, // Consistent width
                height: 29.h, // Consistent height
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(5.r), // Rounded corners
                ),
                child: TextButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == 2 ? 'Done' : 'Next',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text
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
  Widget _buildPage({required String image, required String description}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(image, width: 250.w, height: 250.h),
        SizedBox(height: 20.h),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.inriaSans(
            fontSize: 24.sp,
            color: Color(0xFF3F0200),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

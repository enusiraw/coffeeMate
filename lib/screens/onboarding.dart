import 'package:flutter/material.dart';
import 'package:yenebuna/constants/colors.dart'; // Assuming your AppColors are here

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // The top 80% of the screen is just a container (no clips here)
          Container(
            color: AppColors.mainColor,
            height: MediaQuery.of(context).size.height * 0.8, // Top 80% of the screen
          ),
          
          // Bottom 20% of the screen with the clipped eclipse shape
          ClipPath(
            clipper: BottomClipper(), // Custom clipper for eclipse shape
            child: Container(
              color: AppColors.mainColor,
              height: MediaQuery.of(context).size.height * 0.2, // Bottom 20% of the screen
            ),
          ),
        ],
      ),
    );
  }
}

class BottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Start from top left
    path.lineTo(0, 0);
    path.lineTo(0, size.height); // Bottom left

    // Draw a curve for the eclipse effect
    path.quadraticBezierTo(
      size.width / 2, // x control point (center of the width)
      size.height + 30, // y control point (full height, making the curve lower)
      size.width, // End at the right side of the screen
      size.height, // Bottom right
    );

    path.lineTo(size.width, 0); // Close the path to top right
    path.close(); // Close the path to make it a filled shape

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; // No need to reclip, the shape stays the same
  }
}

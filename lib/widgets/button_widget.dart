import 'package:flutter/material.dart';
import 'package:yenebuna/constants/colors.dart';


class ButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final String text;
  final double borderRadius;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 50.0,
    this.color = AppColors.mainColor, // Default to main color
    this.borderRadius = 8.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          text,
          style: textStyle ?? const TextStyle(
            color: AppColors.whiteColor, // Default text color is white
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

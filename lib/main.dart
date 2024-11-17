import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yenebuna/constants/colors.dart';
import 'package:yenebuna/screens/signUp_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Yenebuna',
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.backgroundColor,
              colorSchemeSeed: AppColors.mainColor,
              textTheme: GoogleFonts.inriaSansTextTheme()),
          home: SignUpPage(),
        );
      },
    );
  }
}

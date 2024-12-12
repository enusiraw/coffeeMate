// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yenebuna/constants/colors.dart';
import 'package:yenebuna/firebase_options.dart';
import 'package:yenebuna/screens/home_screen.dart';
import 'package:yenebuna/screens/onboarding.dart';
import 'package:yenebuna/screens/post.dart';
import 'package:yenebuna/screens/signUp_screen.dart';
import 'package:yenebuna/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
              initialRoute: SplashScreen.id ,
              routes: {
                SplashScreen.id:(context) => SplashScreen(),
                OnboardingPage.id:(context) => const OnboardingPage(),
                SignUpPage.id:(context) => const SignUpPage(),
            //    LoginScreen.id:(context) => LoginScreen(),
                HomeScreen.id:(context) => const HomeScreen(),
                PostPage.id:(context) => PostPage()
              },
          home: const HomeScreen(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:research_app/Resources/colors.dart';
import 'package:research_app/UI/SplashScreen/splashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reearch',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ColorManager.primaryColor,
      ),
      home: const SplashView(),
    );
  }
}
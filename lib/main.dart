import 'package:flutter/material.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/discover/doscover_screen.dart';
import 'package:tiktik_clone/features/inbox/activity_screen.dart';
import 'package:tiktik_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktik_clone/features/main_navigation/main_navigation_screen.dart';
import 'package:tiktik_clone/features/onboarding/interests_screen.dart';
import 'package:tiktik_clone/features/authentication/sign_up_screen.dart';

void main() {
  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TikTok Clone',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontSize: Sizes.size16 + Sizes.size2,
              fontWeight: FontWeight.w700,
              color: Colors.black),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          padding: const EdgeInsets.symmetric(vertical: Sizes.size20),
          elevation: 1,
          color: Colors.white.withOpacity(1),
        ),
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        useMaterial3: false,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

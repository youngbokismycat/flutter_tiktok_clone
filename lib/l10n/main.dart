import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktik_clone/common/widgets/video_configurations/video_config.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/l10n/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});
  @override
  Widget build(BuildContext context) {
    return VideoConfig(
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'TikTok Clone',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          tabBarTheme: TabBarTheme(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.black,
          ),
          textTheme: Typography.blackMountainView,
          brightness: Brightness.light,
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
              color: Colors.black,
            ),
          ),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade50,
            height: 120,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFFE9435A),
          useMaterial3: false,
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          listTileTheme: const ListTileThemeData(
            iconColor: Colors.black,
          ),
        ),
        darkTheme: ThemeData(
          tabBarTheme: TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade500,
            indicatorColor: Colors.white,
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Color(0xFFE9435A),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.grey.shade900,
          ),
          textTheme: Typography.whiteMountainView,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: Colors.black,
          primaryColor: const Color(0xFFE9435A),
          bottomAppBarTheme: BottomAppBarTheme(
            color: Colors.grey.shade900,
            height: 120,
          ),
        ),
      ),
    );
  }
}

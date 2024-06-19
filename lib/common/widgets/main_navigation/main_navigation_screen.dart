import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/discover/doscover_screen.dart';
import 'package:tiktik_clone/features/inbox/inbox_screen.dart';
import 'package:tiktik_clone/common/widgets/main_navigation/widgets/nav_tab.dart';
import 'package:tiktik_clone/common/widgets/main_navigation/widgets/post_video_button.dart';
import 'package:tiktik_clone/features/users/user_profile_screen.dart';
import 'package:tiktik_clone/features/videos/video_timeline_screen.dart';
import 'package:tiktik_clone/l10n/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  static const String routeName = "mainNavigation";

  final String tab;

  const MainNavigationScreen({super.key, required this.tab});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  double _postVideoButtonScale = 1;
  double _fakeflypadding = 0.0;

  final List<String> _tabs = [
    "home",
    "discover",
    "xxxx",
    "inbox",
    "profile",
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoButtonTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              "Record Videos",
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  void _onPostVideoButtonTapDown(TapDownDetails details) {
    setState(() {
      _postVideoButtonScale = 1.1;
      _fakeflypadding = 10;
    });
  }

  void _onPostVideoButtonTapUp(TapUpDetails details) {
    setState(() {
      _postVideoButtonScale = 1.0;
      _fakeflypadding = 0;
    });
  }

  void _onPostVideoButtonTapCancel() {
    setState(() {
      _postVideoButtonScale = 1.0;
      _fakeflypadding = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _selectedIndex == 0 || isDarkMode(context)
          ? Colors.black
          : Colors.white,
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const VideoTimeLineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        padding: const EdgeInsets.only(),
        color: _selectedIndex == 0 || isDarkMode(context)
            ? Colors.black
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                text: "Home",
                isSelected: _selectedIndex == 0,
                icon: FontAwesomeIcons.house,
                selectedicon: FontAwesomeIcons.house,
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Discover",
                isSelected: _selectedIndex == 1,
                icon: FontAwesomeIcons.compass,
                selectedicon: FontAwesomeIcons.solidCompass,
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              GestureDetector(
                onTapDown: _onPostVideoButtonTapDown,
                onTap: _onPostVideoButtonTap,
                onTapUp: _onPostVideoButtonTapUp,
                onTapCancel: _onPostVideoButtonTapCancel,
                child: AnimatedPadding(
                  curve: Curves.elasticOut,
                  duration: const Duration(milliseconds: 800),
                  padding: EdgeInsets.only(bottom: _fakeflypadding),
                  child: AnimatedScale(
                      curve: Curves.easeOutCirc,
                      duration: const Duration(milliseconds: 300),
                      scale: _postVideoButtonScale,
                      child: PostVideoButton(
                        inverted: _selectedIndex != 0,
                      )),
                ),
              ),
              Gaps.h24,
              NavTab(
                text: "Inbox",
                isSelected: _selectedIndex == 3,
                icon: FontAwesomeIcons.message,
                selectedicon: FontAwesomeIcons.solidMessage,
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                text: "Profile",
                isSelected: _selectedIndex == 4,
                icon: FontAwesomeIcons.user,
                selectedicon: FontAwesomeIcons.solidUser,
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktik_clone/l10n/utils.dart';

enum Direction { right, left }

enum Page { first, second }

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  Direction _direction = Direction.right;
  Page _showingPage = Page.first;

  void _onPanUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      setState(() {
        _direction = Direction.right;
      });
    } else {
      setState(() {
        _direction = Direction.left;
      });
    }
  }

  void _onPanEnd(DragEndDetails details) {
    if (_direction == Direction.left) {
      setState(() {
        _showingPage = Page.second;
      });
    } else {
      setState(() {
        _showingPage = Page.first;
      });
    }
  }

  void _onEnterAppTab() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size24,
          ),
          child: SafeArea(
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 300),
              crossFadeState: _showingPage == Page.first
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              firstChild: const TutoralPage1(),
              secondChild: const TutorialPage2(),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: isDarkMode(context) ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size24,
              vertical: Sizes.size24,
            ),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _showingPage == Page.first ? 0 : 1,
              child: CupertinoButton(
                color: Theme.of(context).primaryColor,
                onPressed: _onEnterAppTab,
                child: const Text(
                  "Enter the app!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TutoralPage1 extends StatelessWidget {
  const TutoralPage1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        FractionallySizedBox(
          widthFactor: 1,
          child: Text(
            "Watch cool Videos!",
            style: TextStyle(
              fontSize: Sizes.size40,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Gaps.v16,
        FractionallySizedBox(
          widthFactor: 1,
          child: Text(
            "Videos are personalized for you based on what you watch like, and share.",
            style: TextStyle(
              fontSize: Sizes.size20,
            ),
          ),
        ),
      ],
    );
  }
}

class TutorialPage2 extends StatelessWidget {
  const TutorialPage2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v80,
        FractionallySizedBox(
          widthFactor: 1,
          child: Text(
            "Fallow the rules",
            style: TextStyle(
              fontSize: Sizes.size40,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Gaps.v16,
        FractionallySizedBox(
          widthFactor: 1,
          child: Text(
            "Take care of one another! Plis!",
            style: TextStyle(
              fontSize: Sizes.size20,
            ),
          ),
        ),
      ],
    );
  }
}

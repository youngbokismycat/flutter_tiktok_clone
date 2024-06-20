import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/l10n/utils.dart';

class PostVideoButton extends StatelessWidget {
  const PostVideoButton({super.key, required this.inverted});
  final bool inverted;
  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 17,
          child: Container(
            height: 32,
            width: 29,
            decoration: BoxDecoration(
              color: const Color(0xFF61D4F0),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
          ),
        ),
        Positioned(
          left: 17,
          child: Container(
            height: 32,
            width: 29,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size10),
            color: inverted && !isDark ? Colors.black : Colors.white,
          ),
          height: 32,
          width: 42,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: inverted && !isDark ? Colors.white : Colors.black,
              size: 19,
            ),
          ),
        ),
      ],
    );
  }
}

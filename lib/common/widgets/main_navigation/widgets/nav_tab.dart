import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/l10n/utils.dart';

class NavTab extends StatelessWidget {
  const NavTab(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.icon,
      required this.onTap,
      required this.selectedicon,
      required this.selectedIndex,});
  final String text;
  final bool isSelected;
  final IconData icon;
  final IconData selectedicon;
  final Function onTap;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => onTap(),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isSelected ? 1 : 0.6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  isSelected ? selectedicon : icon,
                  color: selectedIndex == 0 || isDark
                      ? Colors.white
                      : Colors.grey.shade700,
                ),
                Gaps.v4,
                Text(
                  text,
                  style: TextStyle(
                      color: selectedIndex == 0 || isDark
                          ? Colors.white
                          : Colors.grey.shade700,
                      fontSize: Sizes.size10,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

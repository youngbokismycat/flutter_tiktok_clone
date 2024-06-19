import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/breakpoints.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/l10n/utils.dart';

class PersistentTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final isDark = isDarkMode(context);
    return Align(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: Breakpoints.lg,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          border: Border.all(
            color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
            width: 0.5,
          ),
        ),
        child: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
          labelPadding: const EdgeInsets.symmetric(
            vertical: Sizes.size7,
          ),
          tabs: const [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              child: Icon(
                Icons.grid_4x4_rounded,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Sizes.size20),
              child: FaIcon(
                FontAwesomeIcons.heart,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => 41;
  @override
  double get minExtent => 41;
  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';

class CountsCountWhat extends StatelessWidget {
  final String counts;
  final String countWhat;
  const CountsCountWhat({
    super.key,
    required this.counts,
    required this.countWhat,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          counts,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          countWhat,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}

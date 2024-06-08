import 'package:flutter/material.dart';
import 'package:tiktik_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.disabled,
    required this.text,
  });

  final bool disabled;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size14,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Sizes.size5,
            ),
            color: disabled
                ? Colors.grey.shade100
                : Theme.of(context).primaryColor),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 100),
          style: TextStyle(
              color: disabled ? Colors.grey.shade400 : Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: Sizes.size16),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

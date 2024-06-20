import 'package:flutter/material.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/l10n/utils.dart';

class InterestButton extends StatefulWidget {
  const InterestButton({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestButton> createState() => _InterestButtonState();
}

class _InterestButtonState extends State<InterestButton> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          color: _isSelected
              ? Theme.of(context).primaryColor
              : isDarkMode(context)
                  ? Colors.grey.shade700
                  : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 5,
            ),
          ],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 100),
          style: TextStyle(
            color: _isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          child: Text(
            widget.interest,
          ),
        ),
      ),
    );
  }
}

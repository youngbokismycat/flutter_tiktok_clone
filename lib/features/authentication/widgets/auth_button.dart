import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final Widget widget;

  void _onAuthButtonTap(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ),);
  }

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onAuthButtonTap(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(
            Sizes.size14,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: Sizes.size24,
                  height: Sizes.size24,
                  alignment: Alignment.center,
                  child: icon,
                ),
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: Sizes.size16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

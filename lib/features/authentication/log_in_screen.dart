import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/authentication/login_form_screen.dart';
import 'package:tiktik_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktik_clone/features/authentication/widgets/auth_button.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).pop(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              Text(
                "Log in to TikTok",
                style: TextStyle(
                  fontSize: Sizes.size28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                "Manage your account, check notifications, comment on videos, and more.",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.black45,
                ),
                textAlign: TextAlign.center,
              ),
              Gaps.v40,
              AuthButton(
                  widget: LoginFormScreen(),
                  icon: FaIcon(FontAwesomeIcons.user),
                  text: "Use email &  password"),
              Gaps.v16,
              AuthButton(
                  widget: Placeholder(),
                  icon: FaIcon(FontAwesomeIcons.apple),
                  text: "Continue with Apple"),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey.shade50,
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: Sizes.size20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an account?",
              ),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  "Sign Up",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

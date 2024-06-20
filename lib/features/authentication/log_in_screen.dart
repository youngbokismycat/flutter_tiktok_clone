import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/authentication/login_form_screen.dart';
import 'package:tiktik_clone/features/authentication/widgets/auth_button.dart';

class LogInScreen extends StatelessWidget {
  static const String routeName = 'logIn';
  static const String routeUrl = '/login';
  const LogInScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).pop("wat");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const SingleChildScrollView(
        child: SafeArea(
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
                Opacity(
                  opacity: 0.7,
                  child: Text(
                    "Manage your account, check notifications, comment on videos, and more.",
                    style: TextStyle(
                      fontSize: Sizes.size16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Gaps.v40,
                AuthButton(
                    widget: LoginFormScreen(),
                    icon: FaIcon(FontAwesomeIcons.user),
                    text: "Use email &  password",),
                Gaps.v16,
                AuthButton(
                    widget: Placeholder(),
                    icon: FaIcon(FontAwesomeIcons.apple),
                    text: "Continue with Apple",),
                Gaps.v16,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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

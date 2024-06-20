import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/authentication/username_screen.dart';
import 'package:tiktik_clone/features/authentication/log_in_screen.dart';
import 'package:tiktik_clone/features/authentication/widgets/auth_button.dart';

class SignUpScreen extends StatelessWidget {
  static const String routeUrl = "/";
  static const String routeName = 'signUp';
  const SignUpScreen({super.key});

  void _onLogInTap(BuildContext context) async {
    context.pushNamed(LogInScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
                child: Column(
                  children: [
                    Gaps.v80,
                    Text(
                      "Sign up for TikTok",
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                    Gaps.v20,
                    const Opacity(
                      opacity: 0.7,
                      child: Text(
                        "Create a profile, follow other accounts, make your own videos, and more.",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v40,
                    if (orientation == Orientation.portrait) ...[
                      const AuthButton(
                          widget: UsernameScreen(),
                          icon: FaIcon(FontAwesomeIcons.user),
                          text: "Use email &  password",),
                      Gaps.v16,
                      const AuthButton(
                          widget: Placeholder(),
                          icon: FaIcon(FontAwesomeIcons.apple),
                          text: "Continue with Apple",),
                      Gaps.v16,
                    ],
                    if (orientation == Orientation.landscape)
                      const Row(
                        children: [
                          Expanded(
                            child: AuthButton(
                                widget: UsernameScreen(),
                                icon: FaIcon(FontAwesomeIcons.user),
                                text: "Use email &  password",),
                          ),
                          Gaps.h16,
                          Expanded(
                            child: AuthButton(
                                widget: Placeholder(),
                                icon: FaIcon(FontAwesomeIcons.apple),
                                text: "Continue with Apple",),
                          ),
                          Gaps.v16,
                        ],
                      ),
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
                    "Already have an account?",
                  ),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLogInTap(context),
                    child: Text(
                      "Log In",
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
      },
    );
  }
}

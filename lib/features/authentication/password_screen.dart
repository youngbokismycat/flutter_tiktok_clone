import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/authentication/birthday_screen.dart';
import 'package:tiktik_clone/features/authentication/widgets/form_button.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _passwordcontroller = TextEditingController();
  String _password = "";
  bool _obscureText = true;
  bool _isPassword8to20Characters() {
    return _password.isNotEmpty &&
        _password.length > 8 &&
        _password.length < 20;
  }

  bool _isPasswordLettersNumbersandSpecialCharacters() {
    final regExp =
        RegExp(r"^(?=.*[a-zA-Z])(?=.*[@$!%*#?&\^])[A-Za-z0-9@$!%*#?&\^]{3,}$");
    return _password.isNotEmpty && regExp.hasMatch(_password);
  }

  @override
  void initState() {
    super.initState();

    _passwordcontroller.addListener(() {
      setState(() {
        _password = _passwordcontroller.text;
      });
    });
  }

  @override
  void dispose() {
    _passwordcontroller.dispose();
    super.dispose();
  }

  bool _isPasswordVaild() {
    return _isPassword8to20Characters() &&
        _isPasswordLettersNumbersandSpecialCharacters();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordVaild()) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BirthdayScreen(),
      ),
    );
  }

  void _onClearTap() {
    _passwordcontroller.clear();
  }

  void _toggleObscureTap() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign up",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v24,
              const Text(
                "Password",
                style: TextStyle(
                  fontSize: Sizes.size20 + Sizes.size2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextField(
                obscureText: _obscureText,
                onEditingComplete: _onSubmit,
                autocorrect: false,
                controller: _passwordcontroller,
                decoration: InputDecoration(
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: _onClearTap,
                        child: Container(
                          alignment: Alignment.center,
                          width: Sizes.size20,
                          height: Sizes.size20,
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey.shade500,
                            size: Sizes.size16,
                          ),
                        ),
                      ),
                      Gaps.h16,
                      GestureDetector(
                        onTap: _toggleObscureTap,
                        child: Container(
                          alignment: Alignment.center,
                          width: Sizes.size20,
                          height: Sizes.size20,
                          child: FaIcon(
                            _obscureText
                                ? FontAwesomeIcons.eye
                                : FontAwesomeIcons.eyeSlash,
                            color: Colors.grey.shade500,
                            size: Sizes.size16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: "Make it strong!",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v8,
              const Text(
                "Your password must have:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              Column(
                children: [
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circleCheck,
                        size: Sizes.size20,
                        color: _isPassword8to20Characters()
                            ? Colors.green
                            : Colors.grey.shade400,
                      ),
                      Gaps.h7,
                      const Text(
                        '8 to 20 characters',
                      ),
                    ],
                  ),
                  Gaps.v6,
                  Row(
                    children: [
                      FaIcon(
                        FontAwesomeIcons.circleCheck,
                        size: Sizes.size20,
                        color: _isPasswordLettersNumbersandSpecialCharacters()
                            ? Colors.green
                            : Colors.grey.shade400,
                      ),
                      Gaps.h7,
                      const Text(
                        'Letters, numbers, and special characters',
                      ),
                    ],
                  ),
                ],
              ),
              Gaps.v32,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: !_isPasswordVaild(),
                  text: "Next",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

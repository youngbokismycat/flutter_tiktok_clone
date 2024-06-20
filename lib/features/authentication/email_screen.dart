import 'package:flutter/material.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/authentication/widgets/form_button.dart';
import 'package:tiktik_clone/features/authentication/password_screen.dart';

class EmailScreen extends StatefulWidget {
  static String routename = "/email";
  final String username;

  const EmailScreen({
    super.key,
    required this.username,
  });

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _emailcontroller = TextEditingController();
  String _email = "";

  @override
  void initState() {
    super.initState();

    _emailcontroller.addListener(() {
      setState(() {
        _email = _emailcontroller.text;
      });
    });
  }

  @override
  void dispose() {
    _emailcontroller.dispose();
    super.dispose();
  }

  String? _isEmailVaild() {
    if (_email.isEmpty) return null;
    // perform some val.
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",);

    if (!regExp.hasMatch(_email)) {
      return "Email Not Valid";
    }
    return null;
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_email.isEmpty || _isEmailVaild() != null) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PasswordScreen(),
      ),
    );
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
              Text(
                "What is your email, ${widget.username}?",
                style: const TextStyle(
                  fontSize: Sizes.size20 + Sizes.size2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextField(
                onEditingComplete: _onSubmit,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: _emailcontroller,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w400,
                  ),
                  hintText: "Email",
                  errorText: _isEmailVaild(),
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
              Gaps.v32,
              GestureDetector(
                onTap: _onSubmit,
                child: FormButton(
                  disabled: _email.isEmpty || _isEmailVaild() != null,
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

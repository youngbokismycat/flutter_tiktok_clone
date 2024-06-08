import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/authentication/email_screen.dart';
import 'package:tiktik_clone/features/onboarding/interests_screen.dart';
import 'package:tiktik_clone/features/authentication/widgets/form_button.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final TextEditingController _birthdaycontroller = TextEditingController();

  DateTime nowDate = DateTime.now();
  late DateTime initialDate =
      DateTime(nowDate.year - 12, nowDate.month, nowDate.day);

  @override
  void initState() {
    super.initState();

    _setTextFieldDate(initialDate);
  }

  @override
  void dispose() {
    _birthdaycontroller.dispose();
    super.dispose();
  }

  void onNextTap() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const InterestsScreen(),
      ),
      (route) => false,
    );
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthdaycontroller.value = TextEditingValue(text: textDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              "When's your birthday?",
              style: TextStyle(
                fontSize: Sizes.size20 + Sizes.size2,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gaps.v8,
            const Text(
              "Your birthday won't be shown publicly",
              style: TextStyle(
                  fontSize: Sizes.size14,
                  color: Colors.black45,
                  fontWeight: FontWeight.w400),
            ),
            Gaps.v16,
            TextField(
              style: const TextStyle(color: Colors.black),
              enabled: false,
              controller: _birthdaycontroller,
              decoration: InputDecoration(
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                ),
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
              onTap: onNextTap,
              child: const FormButton(
                disabled: false,
                text: "Next",
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 300,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          maximumDate: initialDate,
          initialDateTime: initialDate,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}

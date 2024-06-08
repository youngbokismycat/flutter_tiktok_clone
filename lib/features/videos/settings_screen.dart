import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/sizes.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Settings",
        ),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            title: const Text(
              "Enable Switch",
            ),
            subtitle: const Text(
              "You guys have no switch?",
            ),
            value: _notifications,
            onChanged: _onNotificationsChanged,
          ),
          CheckboxListTile.adaptive(
            value: _notifications,
            onChanged: _onNotificationsChanged,
            title: const Text(
              "I'm a baaad guysss",
            ),
            subtitle: const Text(
              "Duh",
            ),
          ),
          ListTile(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text(
                    "Are u sure?",
                  ),
                  actions: [
                    CupertinoDialogAction(
                      isDestructiveAction: true,
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Noo I'm suuure",
                      ),
                    ),
                    const CupertinoDialogAction(
                      child: Text(
                        "Yes ur right",
                      ),
                    ),
                  ],
                ),
              );
            },
            title: const Text(
              "Log out (IOS / Bottom)",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Are u sure?",
                  ),
                  content: const Text(
                    "No ur not.",
                  ),
                  actions: [
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const FaIcon(
                        FontAwesomeIcons.cat,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        "Yes ur right",
                      ),
                    ),
                  ],
                ),
              );
            },
            title: const Text(
              "Log out (Android)",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          const BirthdayListTile(),
          const AboutListTile(),
        ],
      ),
    );
  }
}

class BirthdayListTile extends StatelessWidget {
  const BirthdayListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime(2030),
        );
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        final booking = await showDateRangePicker(
          context: context,
          firstDate: DateTime(1980),
          lastDate: DateTime(2030),
          builder: (context, child) {
            return Theme(
              data: ThemeData(
                appBarTheme: const AppBarTheme(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                ),
              ),
              child: child!,
            );
          },
        );
      },
      title: const Text(
        "What is your birthday?",
      ),
      subtitle: const Text(
        "Let me know",
      ),
    );
  }
}

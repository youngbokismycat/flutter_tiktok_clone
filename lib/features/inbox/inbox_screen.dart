import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/inbox/activity_screen.dart';
import 'package:tiktik_clone/features/inbox/chats_screen.dart';

class InboxScreen extends StatelessWidget {
  static const String routeName = 'inbox';
  static const String routeUrl = '/inbox';

  const InboxScreen({super.key});

  void _onDmPressed(BuildContext context) {
    context.pushNamed(ChatsScreen.routeName);
  }

  void _onActivityTap(BuildContext context) {
    context.pushNamed(ActivityScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: const Text(
          "Inbox",
        ),
        actions: [
          IconButton(
            onPressed: () => _onDmPressed(context),
            icon: const FaIcon(FontAwesomeIcons.paperPlane),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () => _onActivityTap(context),
            title: const Text(
              "Activity",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size12,
              color: Colors.black,
            ),
          ),
          const InboxBoundaryLine(),
          ListTile(
            leading: Container(
              width: Sizes.size52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.users,
                  color: Colors.white,
                ),
              ),
            ),
            title: const Text(
              "New Followers ",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size14,
              ),
            ),
            subtitle: const Text(
              "Messages from followers will appear hear",
              style: TextStyle(
                fontSize: Sizes.size14,
              ),
            ),
            trailing: const FaIcon(
              FontAwesomeIcons.chevronRight,
              size: Sizes.size12,
              color: Colors.black,
            ),
          ),
          const InboxBoundaryLine(),
        ],
      ),
    );
  }
}

class InboxBoundaryLine extends StatelessWidget {
  const InboxBoundaryLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.6,
      color: Colors.grey.shade200,
    );
  }
}

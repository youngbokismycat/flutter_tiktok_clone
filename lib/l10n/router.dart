import 'package:go_router/go_router.dart';
import 'package:tiktik_clone/common/widgets/main_navigation/main_navigation_screen.dart';
import 'package:tiktik_clone/features/authentication/log_in_screen.dart';
import 'package:tiktik_clone/features/authentication/sign_up_screen.dart';
import 'package:tiktik_clone/features/inbox/activity_screen.dart';
import 'package:tiktik_clone/features/inbox/chat_detail_screen.dart';
import 'package:tiktik_clone/features/inbox/chats_screen.dart';
import 'package:tiktik_clone/features/onboarding/interests_screen.dart';
import 'package:tiktik_clone/features/videos/video_recording_screen.dart';

final router = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: "/",
    builder: (context, state) => const VideoRecordingScreen(),
  ),
  GoRoute(
    name: SignUpScreen.routeName,
    path: SignUpScreen.routeUrl,
    builder: (context, state) => const SignUpScreen(),
  ),
  GoRoute(
    name: InterestsScreen.routeName,
    path: InterestsScreen.routeUrl,
    builder: (context, state) => const InterestsScreen(),
  ),
  GoRoute(
    name: LogInScreen.routeName,
    path: LogInScreen.routeUrl,
    builder: (context, state) => const LogInScreen(),
  ),
  GoRoute(
    path: '/:tab(home|discover|inbox|profile)',
    name: MainNavigationScreen.routeName,
    builder: (context, state) {
      final tab = state.params['tab']!;
      return MainNavigationScreen(
        tab: tab,
      );
    },
  ),
  GoRoute(
    path: ActivityScreen.routeUrl,
    name: ActivityScreen.routeName,
    builder: (context, state) {
      return const ActivityScreen();
    },
  ),
  GoRoute(
    path: ChatsScreen.routeUrl,
    name: ChatsScreen.routeName,
    builder: (context, state) {
      return const ChatsScreen();
    },
    routes: [
      GoRoute(
        name: ChatDetailScreen.routeName,
        path: ChatDetailScreen.routeUrl,
        builder: (context, state) {
          final chatId = state.params["chatId"]!;
          return ChatDetailScreen(
            chatId: chatId,
          );
        },
      )
    ],
  ),
]);

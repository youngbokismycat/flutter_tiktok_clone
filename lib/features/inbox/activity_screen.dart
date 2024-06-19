import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/l10n/utils.dart';

class ActivityScreen extends StatefulWidget {
  static const String routeName = "activity";
  static const String routeUrl = "/activity";

  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen>
    with TickerProviderStateMixin {
  final List<String> _notifications = List.generate(
    20,
    (index) => "${index}h",
  );

  late final AnimationController _animationArrowController =
      AnimationController(
    vsync: this,
    reverseDuration: const Duration(
      milliseconds: 800,
    ),
    duration: const Duration(
      milliseconds: 800,
    ),
  );

  late final AnimationController _animationPanelController =
      AnimationController(
    vsync: this,
    reverseDuration: const Duration(
      milliseconds: 100,
    ),
    duration: const Duration(
      milliseconds: 500,
    ),
  );

  late final Animation<double> _arrowAnimation =
      Tween(begin: 0.0, end: 0.5).animate(
    CurvedAnimation(
      parent: _animationArrowController,
      curve: Curves.elasticOut,
      reverseCurve: Curves.elasticIn,
    ),
  );

  late final Animation<Offset> _panelAnimation =
      Tween(begin: const Offset(0, -1), end: Offset.zero).animate(
    CurvedAnimation(
      parent: _animationPanelController,
      curve: Curves.easeOutCirc,
      reverseCurve: Curves.easeInCirc,
    ),
  );

  late final Animation<Color?> _barrierAnimation = ColorTween(
    begin: Colors.transparent,
    end: Colors.black38,
  ).animate(_animationPanelController);

  bool _isAnimating = false;
  bool _showBarrier = false;

  final List<Map<String, dynamic>> _tabs = [
    {
      'title': 'All activity',
      'icon': FontAwesomeIcons.solidComment,
    },
    {'title': 'Likes', 'icon': FontAwesomeIcons.solidHeart},
    {
      'title': 'Comments',
      'icon': FontAwesomeIcons.solidCommentDots,
    },
    {
      'title': 'Mentions',
      'icon': FontAwesomeIcons.at,
    },
    {
      'title': 'Followers',
      'icon': FontAwesomeIcons.solidUser,
    },
    {
      'title': 'From TikTok',
      'icon': FontAwesomeIcons.tiktok,
    },
  ];

  @override
  void initState() {
    _animationArrowController.addStatusListener(_onStatusChanged);
    super.initState();
  }

  void _onStatusChanged(AnimationStatus status) {
    if (status == AnimationStatus.forward ||
        status == AnimationStatus.reverse) {
      _isAnimating = true;
      setState(() {});
    } else {
      _isAnimating = false;
      setState(() {});
    }
  }

  void _onDismissed(String notification) {
    _notifications.remove(
      notification,
    );
    setState(() {});
  }

  void _toggleAnimations() async {
    _animationArrowController.isCompleted
        ? _animationArrowController.reverse()
        : _animationArrowController.forward();

    _animationPanelController.isCompleted
        ? await _animationPanelController.reverse()
        : _animationPanelController.forward();

    setState(() => _showBarrier = !_showBarrier);
  }

  @override
  void dispose() {
    _animationArrowController.dispose();
    _animationPanelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _isAnimating ? null : _toggleAnimations,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "All activity",
              ),
              Gaps.h2,
              RotationTransition(
                turns: _arrowAnimation,
                child: const FaIcon(
                  FontAwesomeIcons.chevronDown,
                  size: Sizes.size14,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Gaps.v14,
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                ),
                child: Text(
                  "New",
                  style: TextStyle(
                    fontSize: Sizes.size14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Gaps.v14,
              for (var notification in _notifications)
                Dismissible(
                  onDismissed: (direction) => _onDismissed(notification),
                  key: Key(notification),
                  background: Container(
                    alignment: Alignment.centerLeft,
                    color: Colors.green,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.checkDouble,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  secondaryBackground: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                      ),
                      child: FaIcon(
                        FontAwesomeIcons.trashCan,
                        color: Colors.white,
                        size: Sizes.size32,
                      ),
                    ),
                  ),
                  child: ListTile(
                    minVerticalPadding: Sizes.size16,
                    leading: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDarkMode(context)
                              ? Colors.grey.shade800
                              : Colors.white,
                          border: Border.all(
                            color: isDarkMode(context)
                                ? Colors.black
                                : Colors.grey.shade400,
                            width: 0.6,
                          )),
                      width: Sizes.size52,
                      child: Center(
                        child: FaIcon(
                          FontAwesomeIcons.bell,
                          color:
                              isDarkMode(context) ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        text: "Account updates:",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: Sizes.size16,
                          color:
                              isDarkMode(context) ? Colors.white : Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: " Upload longer videos",
                            style: const TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                            children: [
                              TextSpan(
                                text: " $notification",
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    trailing: const FaIcon(
                      FontAwesomeIcons.chevronRight,
                      size: Sizes.size16,
                    ),
                  ),
                )
            ],
          ),
          if (_showBarrier)
            AnimatedModalBarrier(
              color: _barrierAnimation,
              dismissible: true,
              onDismiss: _toggleAnimations,
            ),
          SlideTransition(
            position: _panelAnimation,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).appBarTheme.backgroundColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(
                    Sizes.size5,
                  ),
                  bottomRight: Radius.circular(
                    Sizes.size5,
                  ),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var tab in _tabs)
                    ListTile(
                      title: Row(
                        children: [
                          Icon(
                            tab["icon"],
                            size: Sizes.size16,
                          ),
                          Gaps.h14,
                          Text(
                            tab["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

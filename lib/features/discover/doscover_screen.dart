import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/breakpoints.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/l10n/utils.dart';
import 'package:visibility_detector/visibility_detector.dart';

final List<String> tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands"
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _textEditingController = TextEditingController();

  void _onTapClear() {
    FocusScope.of(context).unfocus();
    _textEditingController.clear();
  }

  void _onChanged(String text) {
    setState(() {});
  }

  void _onIndexChanged() {
    if (_tabController.index != _tabController.previousIndex) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_onIndexChanged);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          titleSpacing: 0,
          leading: const Center(
            child: FaIcon(
              FontAwesomeIcons.chevronLeft,
              size: Sizes.size20,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size20,
              ),
              child: Icon(
                Icons.filter_list_sharp,
              ),
            )
          ],
          title: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Breakpoints.sm,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _onChanged,
                    controller: _textEditingController,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(Sizes.size5),
                      ),
                      hintText: "Search",
                      filled: true,
                      fillColor: isDarkMode(context)
                          ? Colors.grey.shade700
                          : Colors.grey.shade100,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: Sizes.size12,
                      ),
                      iconColor: Colors.grey,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.size12),
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          color: Colors.black,
                          size: Sizes.size16,
                        ),
                      ),
                      suffixIcon: _textEditingController.text.isNotEmpty
                          ? GestureDetector(
                              onTap: _onTapClear,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: Sizes.size10,
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.solidCircleXmark,
                                  color: Colors.grey,
                                  size: Sizes.size16,
                                ),
                              ),
                            )
                          : null,
                      prefixIconConstraints: const BoxConstraints(),
                      suffixIconConstraints: const BoxConstraints(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            splashFactory: NoSplash.splashFactory,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w700,
            ),
            tabs: [
              for (var tab in tabs)
                Tab(
                  text: tab,
                ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(
                Sizes.size9,
              ),
              itemCount: 20,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                crossAxisSpacing: Sizes.size9,
                mainAxisSpacing: Sizes.size9,
                childAspectRatio: 9 / 20.5,
              ),
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: AspectRatio(
                      aspectRatio: 9 / 16,
                      child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: 'assets/images/placeholder.webp',
                          image:
                              "https://images.unsplash.com/photo-1551028150-64b9f398f678?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    "This a very long caption for my tiktok tha im upaa sdasda dasdasd sdlkasd,",
                    style: TextStyle(
                      fontSize: Sizes.size14 + Sizes.size2,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gaps.v7,
                  DefaultTextStyle(
                    style: TextStyle(
                      color: isDarkMode(context)
                          ? Colors.grey.shade300
                          : Colors.grey.shade500,
                      fontWeight: FontWeight.w700,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 15,
                          backgroundImage: NetworkImage(
                            "https://avatars.githubusercontent.com/u/3612017",
                          ),
                        ),
                        Gaps.h4,
                        const Expanded(
                          child: Text(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            "Anyway Fuck then now we move the cwroud babe",
                          ),
                        ),
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size14 + 1,
                          color: Colors.grey.shade600,
                        ),
                        Gaps.h2,
                        const Text("2.0M"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            for (var tab in tabs.skip(1))
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(
                    fontSize: Sizes.size20,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

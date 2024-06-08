import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/discover/doscover_screen.dart';
import 'package:tiktik_clone/features/users/widgets/count_counts_what.dart';
import 'package:tiktik_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                title: const Text(
                  "Youngbok",
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      foregroundImage: AssetImage(
                        "assets/images/youngbok.jpg",
                      ),
                      child: Text('youngbok'),
                    ),
                    Gaps.v10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "@youngbok",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size16,
                          ),
                        ),
                        Gaps.h5,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: Sizes.size16,
                          color: Colors.blue.shade300,
                        )
                      ],
                    ),
                    Gaps.v24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CountsCountWhat(
                          counts: "37",
                          countWhat: "Following",
                        ),
                        VerticalDivider(
                          width: Sizes.size32,
                          thickness: 1,
                          color: Colors.grey.shade300,
                          indent: Sizes.size14,
                          endIndent: Sizes.size14,
                        ),
                        const CountsCountWhat(
                          counts: "10.5M",
                          countWhat: "Followers",
                        ),
                        VerticalDivider(
                          width: Sizes.size32,
                          thickness: 1,
                          color: Colors.grey.shade300,
                          indent: Sizes.size14,
                          endIndent: Sizes.size14,
                        ),
                        const CountsCountWhat(
                          counts: "149.3M",
                          countWhat: "Likes",
                        ),
                      ],
                    ),
                    Gaps.v14,
                    const FractionallySizedBox(
                      widthFactor: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FollowButton(),
                          Gaps.h5,
                          CustomButton(
                            icon: FontAwesomeIcons.youtube,
                          ),
                          Gaps.h5,
                          CustomButton(
                            icon: FontAwesomeIcons.caretDown,
                          ),
                        ],
                      ),
                    ),
                    Gaps.v14,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: Sizes.size32),
                      child: Text(
                        "Youngbok cuteness is forever in the world look at him so cuuuuuuuuuuuuute",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v14,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Text(
                          "https://youngbokissocuuuute.cute",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                    Gaps.v20,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.zero,
                itemCount: 20,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: Sizes.size2,
                  mainAxisSpacing: Sizes.size2,
                  childAspectRatio: 9 / 13,
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    AspectRatio(
                      aspectRatio: 9 / 13,
                      child: GridTile(
                        footer: const Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.white,
                              size: Sizes.size24,
                            ),
                            Text(
                              "4.1M",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: 'assets/images/placeholder.webp',
                            image:
                                "https://images.unsplash.com/photo-1551028150-64b9f398f678?q=80&w=1287&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
                      ),
                    ),
                  ],
                ),
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: Sizes.size14,
        horizontal: Sizes.size56,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            Sizes.size2,
          ),
        ),
      ),
      child: const Text(
        "Follow",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  const CustomButton({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        Sizes.size7,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size3,
        ),
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(
            0.4,
          ),
        ),
      ),
      child: SizedBox(
        height: 30,
        width: 30,
        child: Center(
          child: FaIcon(
            icon,
          ),
        ),
      ),
    );
  }
}

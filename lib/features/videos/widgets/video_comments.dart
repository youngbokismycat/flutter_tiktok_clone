import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/l10n/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onStartWriting() {
    _isWriting = true;
    setState(() {});
  }

  bool _isWriting = false;
  void _stopWriting() {
    FocusScope.of(context).unfocus();
    _isWriting = false;
    setState(() {});
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = isDarkMode(context);
    return Container(
      height: size.height * 0.7,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Sizes.size14,
        ),
      ),
      child: GestureDetector(
        onTap: _stopWriting,
        child: Scaffold(
          backgroundColor: isDark ? null : Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: isDark ? null : Colors.grey.shade50,
            automaticallyImplyLeading: false,
            title: const Text("22796 comments"),
            actions: [
              IconButton(
                onPressed: _onClosePressed,
                icon: const FaIcon(FontAwesomeIcons.xmark),
              ),
            ],
          ),
          body: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (context, index) => Gaps.v20,
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                    bottom: Sizes.size96 + Sizes.size20,
                    left: Sizes.size16,
                    right: Sizes.size16,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 18,
                        child: Text(
                          "영진",
                        ),
                      ),
                      Gaps.h8,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "youngbok",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade500,
                                fontSize: Sizes.size14,
                              ),
                            ),
                            Gaps.v4,
                            const Text(
                              "anyway fuck then now we move the crowd babe someday there was all we could say boy look what we've done. yeah we made it when all your damn friends have settled done it motherfuckin mondane life",
                            ),
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            color: Colors.grey.shade500,
                            size: Sizes.size20,
                          ),
                          Gaps.v2,
                          Text(
                            "52.2K",
                            style: TextStyle(
                              fontSize: Sizes.size14,
                              color: Colors.grey.shade500,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                    bottom: Sizes.size24,
                    left: Sizes.size12,
                    right: Sizes.size12,
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.shade500,
                        foregroundColor: Colors.white,
                        radius: 18,
                        child: const Text(
                          "영진",
                        ),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: SizedBox(
                          height: Sizes.size44,
                          child: TextField(
                            onTap: _onStartWriting,
                            expands: true,
                            minLines: null,
                            maxLines: null,
                            textInputAction: TextInputAction.newline,
                            cursorColor: Theme.of(context).primaryColor,
                            decoration: InputDecoration(
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  right: Sizes.size14,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.at,
                                      color: isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    FaIcon(
                                      FontAwesomeIcons.gift,
                                      color: isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                      color: isDark
                                          ? Colors.grey.shade500
                                          : Colors.grey.shade900,
                                    ),
                                    Gaps.h14,
                                    if (_isWriting)
                                      GestureDetector(
                                        onTap: _stopWriting,
                                        child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color:
                                                Theme.of(context).primaryColor,),
                                      ),
                                  ],
                                ),
                              ),
                              hintText: "Write a comment...",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(
                                  Sizes.size12,
                                ),
                              ),
                              filled: true,
                              fillColor: isDark
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade200,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: Sizes.size12,
                                vertical: Sizes.size10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onClosePressed() {
    Navigator.of(context).pop();
  }
}

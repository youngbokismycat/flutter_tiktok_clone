import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:readmore/readmore.dart';
import 'package:tiktik_clone/common/widgets/video_configurations/video_config.dart';

import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/videos/widgets/video_button.dart';
import 'package:tiktik_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });
  final int index;
  final Function onVideoFinished;

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  bool _isPaused = false;
  bool _isVolume0 = false;
  final Duration _duration = const Duration(milliseconds: 200);
  late final AnimationController _animationController;

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPaused) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _ontogglePause();
    }
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    setState(() {});
    await _videoPlayerController.setLooping(true);
    if (kIsWeb) {
      _isVolume0 = true;
      await _videoPlayerController.setVolume(0);
    }
    _videoPlayerController.addListener(_onVideoChange);
  }

  void _onSeeMoreTap() {}

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _duration,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();

    super.dispose();
  }

  void _ontogglePause() {
    if (!mounted) {
      return;
    }
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _ontogglePause();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent, //Scaffold color

      context: context,
      builder: (context) => const VideoComments(),
    );
  }

  void _onEnableVolumeTap() {
    _isVolume0 = false;
    _videoPlayerController.setVolume(10);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _ontogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedScale(
                  duration: _duration,
                  scale: _isPaused ? 1 : 1.5,
                  child: AnimatedOpacity(
                    duration: _duration,
                    opacity: _isPaused ? 1 : 0,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size56,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              icon: FaIcon(
                VideoConfigData.of(context).autoMute
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: VideoConfigData.of(context).toggleMuted,
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: _isVolume0 ? 1 : 0,
                  child: GestureDetector(
                    onTap: _onEnableVolumeTap,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.size10,
                        vertical: Sizes.size10,
                      ),
                      color: Colors.white,
                      child: const Text(
                        "Enable Volume",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Gaps.v10,
                const Text(
                  "@youngbok",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Gaps.v16,
                const Text(
                  "This is my Cat YOUNBOK!! ",
                  style: TextStyle(
                    fontSize: Sizes.size14 + Sizes.size1,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Gaps.v3,
                const SizedBox(
                  width: 300,
                  child: ReadMoreText(
                    '#myCat #myHome #myMe #SingleTickerProviderStateMixin #Fuckyou #FuckredScreen #FUCK ALL',
                    trimMode: TrimMode.Line,
                    trimLines: 1,
                    trimExpandedText: " Close",
                    trimCollapsedText: " See more",
                    colorClickableText: Colors.white,
                    moreStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    lessStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    style: TextStyle(
                      fontSize: Sizes.size14 + Sizes.size1,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Gaps.v16,
                const Row(
                  children: [
                    FaIcon(
                      FontAwesomeIcons.music,
                      color: Colors.white,
                      size: Sizes.size16,
                    ),
                    Gaps.h10,
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "RedBone - Childish Gambino",
                          style: TextStyle(color: Colors.white),
                        ),
                        Gaps.h10,
                        Text(
                          "original sound",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  child: FaIcon(FontAwesomeIcons.user),
                ),
                Gaps.v24,
                const VideoButton(
                    icon: FontAwesomeIcons.solidHeart, text: "2.2M",),
                Gaps.v24,
                GestureDetector(
                    onTap: () => _onCommentsTap(context),
                    child: const VideoButton(
                        icon: FontAwesomeIcons.solidComment, text: "32K",),),
                Gaps.v24,
                const VideoButton(icon: FontAwesomeIcons.share, text: "Share"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

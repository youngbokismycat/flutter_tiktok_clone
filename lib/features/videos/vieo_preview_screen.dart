import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:video_player/video_player.dart';

class VieoPreviewScreen extends StatefulWidget {
  final XFile video;
  const VieoPreviewScreen({
    super.key,
    required this.video,
  });

  @override
  State<VieoPreviewScreen> createState() => _VieoPreviewScreenState();
}

class _VieoPreviewScreenState extends State<VieoPreviewScreen> {
  bool _savedVideo = false;

  late final VideoPlayerController _videoPlayerController;
  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(
        widget.video.path,
      ),
    );

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;
    String savedPath = widget.video.path;
    await GallerySaver.saveVideo(
      savedPath,
      albumName: "TikTok Clone!",
    );

    _savedVideo = true;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Video Preview",
        ),
        actions: [
          IconButton(
            onPressed: _saveToGallery,
            icon: FaIcon(
              _savedVideo ? FontAwesomeIcons.check : FontAwesomeIcons.download,
            ),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? VideoPlayer(_videoPlayerController)
          : null,
    );
  }
}

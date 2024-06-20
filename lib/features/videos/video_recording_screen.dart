import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';
import 'package:tiktik_clone/features/videos/vieo_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});
  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );
  late final AnimationController _progressAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 10,
    ),
    lowerBound: 0.0,
    upperBound: 1.0,
  );
  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);
  late CameraController _cameraController;
  bool _userHasPermission = false;
  bool _userHasDeniedPermission = false;
  bool _isSelfieMode = false;
  late FlashMode _flashMode;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 0 : 1],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();
    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermission() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _userHasPermission = true;

      await initCamera();
      setState(() {});
    } else {
      _userHasDeniedPermission = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initPermission();
    _progressAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _stopRecording();
        }
      },
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _progressAnimationController.forward();
    _buttonAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    final video = await _cameraController.stopVideoRecording();
    print(video.path);
    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VieoPreviewScreen(
          video: video,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_userHasPermission || !_cameraController.value.isInitialized
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Initializing...",
                    style:
                        TextStyle(color: Colors.white, fontSize: Sizes.size20),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(
                    _cameraController,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).viewPadding.top,
                    right: Sizes.size10,
                    child: Column(
                      children: [
                        IconButton(
                          color: Colors.white,
                          onPressed: _toggleSelfieMode,
                          icon: const Icon(
                            Icons.cameraswitch,
                          ),
                        ),
                        Gaps.v10,
                        FlashModeButton(
                          flashMode: _flashMode,
                          setFlashMode: FlashMode.off,
                          onPressed: _setFlashMode,
                        ),
                        FlashModeButton(
                          flashMode: _flashMode,
                          setFlashMode: FlashMode.always,
                          onPressed: _setFlashMode,
                        ),
                        FlashModeButton(
                          flashMode: _flashMode,
                          setFlashMode: FlashMode.auto,
                          onPressed: _setFlashMode,
                        ),
                        FlashModeButton(
                          flashMode: _flashMode,
                          setFlashMode: FlashMode.torch,
                          onPressed: _setFlashMode,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: Sizes.size40,
                    child: GestureDetector(
                      onTapDown: _startRecording,
                      onTapCancel: _stopRecording,
                      onTapUp: (details) => _stopRecording(),
                      child: ScaleTransition(
                        scale: _buttonAnimation,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: Sizes.size80,
                              height: Sizes.size80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red.shade500,
                              ),
                            ),
                            SizedBox(
                              width: Sizes.size80 + Sizes.size14,
                              height: Sizes.size80 + Sizes.size14,
                              child: AnimatedBuilder(
                                animation: _progressAnimationController,
                                builder: (context, child) =>
                                    CircularProgressIndicator(
                                  value: _progressAnimationController.value,
                                  strokeWidth: Sizes.size6,
                                  color: Colors.red.shade500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class FlashModeButton extends StatelessWidget {
  const FlashModeButton({
    super.key,
    required this.flashMode,
    required this.setFlashMode,
    required this.onPressed,
  });

  final FlashMode flashMode;
  final FlashMode setFlashMode;
  final Function onPressed;

  IconData _getIconData(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return Icons.flash_off_rounded;
      case FlashMode.always:
        return Icons.flash_on_rounded;
      case FlashMode.auto:
        return Icons.flash_auto_rounded;
      case FlashMode.torch:
        return Icons.flashlight_on_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: flashMode == setFlashMode ? Colors.amber.shade200 : Colors.white,
      onPressed: () => onPressed(setFlashMode),
      icon: Icon(
        _getIconData(setFlashMode),
      ),
    );
  }
}

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktik_clone/constants/gaps.dart';
import 'package:tiktik_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});
  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
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
                  CircularProgressIndicator.adaptive()
                ],
              )
            : Stack(
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
                  )
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

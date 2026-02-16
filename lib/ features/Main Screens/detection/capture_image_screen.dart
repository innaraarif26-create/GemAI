import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class CaptureImageScreen extends StatefulWidget {
  const CaptureImageScreen({super.key});

  @override
  State<CaptureImageScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CaptureImageScreen> {
  CameraController? controller;
  List<CameraDescription>? cameras;
  final ImagePicker picker = ImagePicker();
  bool isCameraReady = false;

  @override
  void initState() {
    super.initState();

    // Hide status & navigation bars
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    initializeCamera();
  }

  Future<void> initializeCamera() async {
    try {
      cameras = await availableCameras();

      if (cameras == null || cameras!.isEmpty) return;

      controller = CameraController(
        cameras![0],
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller!.initialize();

      if (!mounted) return;

      setState(() => isCameraReady = true);
    } catch (e) {
      debugPrint("Camera error: $e");
    }
  }

  @override
  void dispose() {
    controller?.dispose();

    // Restore system UI
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    super.dispose();
  }

  // Pick image from gallery
  Future<void> pickFromGallery() async {
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery);

    if (!mounted) return;

    if (image != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected: ${image.path}')),
      );
    }
  }

  // Capture image
  Future<void> captureImage() async {
    if (controller == null || !controller!.value.isInitialized) return;

    try {
      final XFile image = await controller!.takePicture();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved: ${image.path}')),
      );
    } catch (e) {
      debugPrint("Capture error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isCameraReady) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// Camera Preview (proper scaling)
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: controller!.value.aspectRatio,
              child: CameraPreview(controller!),
            ),
          ),

          /// Bottom Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// Gallery Button
                    GestureDetector(
                      onTap: pickFromGallery,
                      child: _circleButton(Icons.photo),
                    ),

                    /// Capture Button
                    GestureDetector(
                      onTap: captureImage,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 4),
                        ),
                      ),
                    ),

                    /// Spacer for symmetry
                    const SizedBox(width: 60),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
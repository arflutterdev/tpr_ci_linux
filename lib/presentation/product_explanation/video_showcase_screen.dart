import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fvp/fvp.dart';

class VideoShowCaseScreen extends StatefulWidget {
  const VideoShowCaseScreen({super.key});

  @override
  State<VideoShowCaseScreen> createState() => _VideoShowCaseScreenState();
}

class _VideoShowCaseScreenState extends State<VideoShowCaseScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    // _controller = VideoPlayerController.asset(
    //     'assets/videos/forest.mp4')
    //   ..initialize().then((_) {
    //     setState(() {});
    //     _controller.play();
    //   });
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    // Play a [Media] or [Playlist].
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: VideoPlayer(_controller),
      ),
    );
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }
}

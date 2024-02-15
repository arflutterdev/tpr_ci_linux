import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:fvp/fvp.dart' as fvp;

class VideoShowCaseScreen extends StatefulWidget {
  const VideoShowCaseScreen({super.key});

  @override
  State<VideoShowCaseScreen> createState() => _VideoShowCaseScreenState();
}

class _VideoShowCaseScreenState extends State<VideoShowCaseScreen> {
  late VideoPlayerController _controller;

 
  @override
  void initState() {
    _controller = VideoPlayerController.asset(
        'assets/videos/Tamilnadu Forest Department _ Sathyamangalam Tiger Reserve.mp4');
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
    
    super.dispose();
  }
}

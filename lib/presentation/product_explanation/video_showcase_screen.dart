import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';                      // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart'; 

class VideoShowCaseScreen extends StatefulWidget {
  const VideoShowCaseScreen({super.key});

  @override
  State<VideoShowCaseScreen> createState() => _VideoShowCaseScreenState();
}

class _VideoShowCaseScreenState extends State<VideoShowCaseScreen> {
  // Create a [Player] to control playback.
  late final player = Player();
  // Create a [VideoController] to handle video output from [Player].
  late final controller = VideoController(player);
  @override
  void initState() {
    // _controller = VideoPlayerController.asset(
    //     'assets/videos/Tamilnadu Forest Department _ Sathyamangalam Tiger Reserve.mp4');
    // Play a [Media] or [Playlist].
    player.open(Media('assets/videos/Tamilnadu Forest Department _ Sathyamangalam Tiger Reserve.mp4'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width * 9.0 / 16.0,
        // Use [Video] widget to display video output.
        child: Video(controller: controller),
      ),
    );
  }

   @override
  void dispose() {
    player.dispose();
    super.dispose();
  }
}

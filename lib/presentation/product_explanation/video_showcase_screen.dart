// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
// import 'package:fvp/fvp.dart';

// class VideoShowCaseScreen extends StatefulWidget {
//   const VideoShowCaseScreen({super.key});

//   @override
//   State<VideoShowCaseScreen> createState() => _VideoShowCaseScreenState();
// }

// class _VideoShowCaseScreenState extends State<VideoShowCaseScreen> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     _controller = VideoPlayerController.asset(
//         'assets/videos/foresttamil.mp4')
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//       });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//       ),
//       body: Center(
//         child: VideoPlayer(_controller),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.pause();
//     _controller.dispose();
//     super.dispose();
//   }
// }

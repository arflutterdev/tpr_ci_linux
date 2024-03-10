import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FollowMeScreen extends StatelessWidget {
  const FollowMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow Me'),
      ),
      body: Center(
        child: LottieBuilder.asset('assets/lottieanimations/3.json'),
      ),
    );
  }
}

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FollowMeScreen extends StatefulWidget {
  const FollowMeScreen({super.key});

  @override
  State<FollowMeScreen> createState() => _FollowMeScreenState();
}

class _FollowMeScreenState extends State<FollowMeScreen> {
  bool isFollowing = false;

  handleFollowMe() {
    setState(() {
      isFollowing = !isFollowing;
    });
    //ros.setFollowMe(isFollowing?Stop:start)
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Follow Me'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isFollowing)
              SizedBox(
                  height: size.height*0.4,
                  child: LottieBuilder.asset('assets/lottieanimations/3.json')),
            ElevatedButton(
              onPressed: handleFollowMe,
              child: Text(isFollowing ? 'Stop' : 'Start'),
            )
          ],
        ),
      ),
    );
  }
}

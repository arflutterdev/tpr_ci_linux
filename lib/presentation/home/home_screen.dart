import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:tpr_control_interface_linux/presentation/product_explanation/video_showcase_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var isProcessing = ValueNotifier(false);
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onLongPress: () {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const VideoShowCaseScreen(),
            ));
          });
        },
        child: Center(
          child: Column(
            children: [
              Container(
                  // color: Colors.red,
                  padding: const EdgeInsets.all(2),
                  height: size.height * 0.67,
                  width: double.infinity,
                  child: const RiveAnimation.asset(
                    'assets/rive/sq_eyeL.riv',
                    fit: BoxFit.contain,
                  )),
              ValueListenableBuilder(
                valueListenable: isProcessing,
                builder: (context, value, child) {
                  if (value) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: LottieBuilder.asset(
                        'assets/lottieanimations/pre.json',
                        height: size.height * 0.2,
                        // fit: BoxFit.fitHeight,
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rive/rive.dart';
import 'package:tpr_control_interface_linux/models/robot_state.dart';
import 'package:tpr_control_interface_linux/presentation/feature_launcher/feature_launcher_screen.dart';
import 'package:tpr_control_interface_linux/services/ros_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var rosService = RosService();
  var isInteracting = ValueNotifier(false);
  bool isSuscribed = false;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      rosService.isRosConnected.addListener(() {
        if (rosService.isConnected) {
          if(!isSuscribed){
            startSuscription();
          }
          
        }
      });
    });
    super.initState();
  }

  startSuscription() {
    isSuscribed = true;
    rosService.suscribeToRobotState((state) {
      if (state.state.isIdle && isInteracting.value) {
        isInteracting.value = false;
      }
      if (state.state.isInteracting && !isInteracting.value) {
        isInteracting.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onDoubleTap: () {
          showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(title: const Text('Exit ?'), actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No')),
              TextButton(
                  onPressed: () {
                    exit(0);
                  },
                  child: const Text('yes'))
            ]),
          );
        },
        onLongPress: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const FeatureLauncherScreen(),
          ));
        },
        child: Center(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: rosService.isRosConnected,
                builder: (context, value, child) {
                  if (!value) {
                    return buildRosNotConnected();
                  } else {
                    return const SizedBox();
                  }
                },
              ),
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
                valueListenable: isInteracting,
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
              ),
              // ValueListenableBuilder(
              //   valueListenable: rosService.currentRobotStateLog,
              //   builder: (context, value, child) {
              //     return Text(value);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildRosNotConnected() {
    return Container(
      padding: const EdgeInsets.all(2),
      color: Colors.red,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Ros Not Connected.. Retrying ..'),
        ],
      ),
    );
  }

  @override
  void dispose() {
    rosService.unsuscribeRobotState();
    super.dispose();
  }
}

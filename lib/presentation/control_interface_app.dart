import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:tpr_control_interface_linux/presentation/home/home_screen.dart';
import 'package:tpr_control_interface_linux/presentation/video_calling/incomming_call_screen.dart';
import 'package:tpr_control_interface_linux/services/ros_service.dart';

import '../services/connecty_cube_service.dart';
import '../utils/navigation_utils.dart';

var navigatorKey = GlobalKey<NavigatorState>();

class ControlInterfaceApp extends StatefulWidget {
  const ControlInterfaceApp({super.key});

  @override
  State<ControlInterfaceApp> createState() => _ControlInterfaceAppState();
}

class _ControlInterfaceAppState extends State<ControlInterfaceApp> {
  P2PClient callClient = P2PClient.instance;
  @override
  void initState() {
    setupVideoCalling();
    super.initState();
  }

  setupVideoCalling() async {
    //init & autologin
    ConnectyCubeService().initConectyCube();
    await ConnectyCubeService().login();

    callClient.init();
    // calls when P2PClient receives new incoming call
    callClient.onReceiveNewSession = (incomingCallSession) {
      print(incomingCallSession);
      print('Incomming call');
      navigateTo(navigatorKey.currentContext ?? context,
          IncomingCallScreen(incomingCallSession));
    };
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }

  @override
  void dispose() {
    RosService().disposeTimer();
    super.dispose();
  }
}

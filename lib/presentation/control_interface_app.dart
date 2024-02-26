import 'package:flutter/material.dart';
import 'package:tpr_control_interface_linux/presentation/home/home_screen.dart';
import 'package:tpr_control_interface_linux/services/ros_service.dart';

class ControlInterfaceApp extends StatefulWidget {
  const ControlInterfaceApp({super.key});

  @override
  State<ControlInterfaceApp> createState() => _ControlInterfaceAppState();
}

class _ControlInterfaceAppState extends State<ControlInterfaceApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    RosService().disposeTimer();
    super.dispose();
  }
}

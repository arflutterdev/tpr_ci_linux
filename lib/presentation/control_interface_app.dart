import 'package:flutter/material.dart';
import 'package:tpr_control_interface_linux/presentation/home/home_screen.dart';

class ControlInterfaceApp extends StatelessWidget {
  const ControlInterfaceApp({super.key});

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
}

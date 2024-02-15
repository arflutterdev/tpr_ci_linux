import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:tpr_control_interface_linux/presentation/control_interface_app.dart';

void main() {
  initVideoPlayerMediaKit();
  runApp(const ControlInterfaceApp());
}

initVideoPlayerMediaKit() {
  WidgetsFlutterBinding.ensureInitialized();
  // Necessary initialization for package:media_kit.
  MediaKit.ensureInitialized();
}

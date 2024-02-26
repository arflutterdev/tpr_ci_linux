import 'package:flutter/material.dart';

import 'package:tpr_control_interface_linux/presentation/control_interface_app.dart';
import 'package:fvp/fvp.dart' as fvp;
import 'package:tpr_control_interface_linux/services/ros_service.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Must add this line.
  await windowManager.ensureInitialized();

  WindowOptions wo = WindowOptions(
    alwaysOnTop: true,
    fullScreen: true,
    titleBarStyle: TitleBarStyle.hidden,

  );

    windowManager.waitUntilReadyToShow(wo, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  initVideoPlayerMediaKit();
  runApp(const ControlInterfaceApp());
}

initVideoPlayerMediaKit() {
  WidgetsFlutterBinding.ensureInitialized();
  fvp.registerWith();
}

initRos() {
  RosService();
}

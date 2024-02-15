import 'package:flutter/material.dart';

import 'package:tpr_control_interface_linux/presentation/control_interface_app.dart';
import 'package:fvp/fvp.dart' as fvp;

void main() {
  initVideoPlayerMediaKit();
  runApp(const ControlInterfaceApp());
}

initVideoPlayerMediaKit() {
  WidgetsFlutterBinding.ensureInitialized();
  fvp.registerWith();
}

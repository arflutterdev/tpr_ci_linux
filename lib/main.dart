import 'package:flutter/material.dart';
import 'package:tpr_control_interface_linux/presentation/control_interface_app.dart';
import 'package:video_player_media_kit/video_player_media_kit.dart';

void main() {
  runApp(const ControlInterfaceApp());
}

initVideoPlayerMediaKit(){
   VideoPlayerMediaKit.ensureInitialized(
    linux: true,
  );
}




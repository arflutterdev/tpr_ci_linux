import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tpr_control_interface_linux/presentation/face_detection_preview/face_detection_preview.dart';
import 'package:tpr_control_interface_linux/presentation/volume_control/volume_control_screen.dart';

class FeatureLauncherScreen extends StatelessWidget {
  const FeatureLauncherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Features'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1,
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10),
          children: [
            buildCard(text: 'Follow Me'),
            buildCard(text: 'Map Location'),
            buildCard(text: 'Save Location'),
            buildCard(text: 'Goto Location'),
            buildCard(text: 'Live Translate'),
            buildCard(
                text: 'Face Detection Preview',
                ontap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FaceDetectionPreview(),
                  ));
                }),
            buildCard(
                text: 'Sound',
                ontap: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const VolumeControlScreen(),
                  ));
                })
          ],
        ),
      ),
    );
  }

  buildCard({required String text, VoidCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 4,
                    color: Colors.white24,
                    offset: Offset.zero,
                    blurStyle: BlurStyle.outer)
              ]),
          child: Text(
            text,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

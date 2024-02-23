import 'package:flutter/material.dart';
import 'package:flutter_volume_controller/flutter_volume_controller.dart';

class VolumeControlScreen extends StatefulWidget {
  const VolumeControlScreen({super.key});

  @override
  State<VolumeControlScreen> createState() => _VolumeControlScreenState();
}

class _VolumeControlScreenState extends State<VolumeControlScreen> {
  double volumeLevel = 0;
  bool isMuted = false;
  @override
  void initState() {
    FlutterVolumeController.addListener((value) {
      print('vlevel: $value');
      setState(() {
        volumeLevel = value;
      });
    });
    FlutterVolumeController.getMute().then((value) {
      setState(() {
        isMuted = value??false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sound Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Volume',
              style: theme.textTheme.titleLarge,
            ),
            Slider(
              value: volumeLevel,
              max: 1.0,
              onChanged: (value) {
                FlutterVolumeController.setVolume(value);
              },
            ),
            Text(isMuted?'UnMute': 'Mute',style: theme.textTheme.titleLarge,),
            IconButton(
                onPressed: () {
                  FlutterVolumeController.setMute(!isMuted).then((value){
                    setState(() {
                      isMuted=!isMuted;
                    });
                  });
                },
                icon: Icon(isMuted?Icons.volume_up: Icons.volume_mute),iconSize: 50,)
          ],
        ),
      ),
    );
  }
}

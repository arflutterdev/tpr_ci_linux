import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class RetellAiScreen extends StatefulWidget {
  const RetellAiScreen({super.key});

  @override
  State<RetellAiScreen> createState() => _RetellAiScreenState();
}

class _RetellAiScreenState extends State<RetellAiScreen> {
  late WebSocket socket;

  bool isConversing = false;

  @override
  void initState() {
    setupWs();
    super.initState();
  }

  setupWs() async {
    socket = await WebSocket.connect('ws://10.71.172.181:8070');
    socket.listen((event) {
      print(event);
      if (event == 'started') {
        setState(() {
          isConversing = true;
        });
      } else if (event == 'stoped') {
        setState(() {
          isConversing = false;
        });
      }
    });
  }

  trigger() {
    socket.add('fstart');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Ai'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isConversing)
              LottieBuilder.asset(
                'assets/lottieanimations/5.json',
                height: size.height * 0.5,
                // fit: BoxFit.fitHeight,
              ),
            ElevatedButton(
              onPressed: () {
                trigger();
              },
              child: Text(isConversing ? 'Stop' : 'Start'),
            )
          ],
        ),
      ),
    );
  }
}

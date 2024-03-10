import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../utils/navigation_utils.dart';
import 'call_screen.dart';

class IncomingCallScreen extends StatelessWidget {
  final P2PSession incommingcallSession;
  const IncomingCallScreen(this.incommingcallSession, {super.key});

  @override
  Widget build(BuildContext context) {
    incommingcallSession.onUserNoAnswer = (session, userId) {
      incommingcallSession.closeCurrentSession();
      pop(context);
    };
    incommingcallSession.onReceiveHungUpFromUser =
        (session, userId, [userInfo]) {
      incommingcallSession.closeCurrentSession();
      maybePop(context);
    };
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Incomming call',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          LottieBuilder.asset('assets/lottieanimations/phone_ringing.json'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    incommingcallSession.reject();
                    pop(context);
                  },
                  child: const Text('Decline')),
              const SizedBox(
                width: 40,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await incommingcallSession.acceptCall();
                    navigateTo(context, CallScreen(incommingcallSession),
                        replace: true);
                  },
                  child: const Text('Answer')),
            ],
          )
        ],
      ),
    );
  }
}

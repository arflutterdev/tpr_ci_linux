import 'package:connectycube_sdk/connectycube_sdk.dart';
import 'package:flutter/material.dart';

import '../../utils/navigation_utils.dart';

class CallScreen extends StatefulWidget {
  final P2PSession callSession;
  const CallScreen(this.callSession, {super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  RTCVideoView? localvideoView;
  RTCVideoView? remotevideoView;

  bool isMuted = false;
  @override
  void initState() {
//     callClient.init();
//     // calls when P2PClient receives new incoming call
//     callClient.onReceiveNewSession = (incomingCallSession) {
//       print(incomingCallSession);
//       incommingcallSession = incommingcallSession;
//     };

// // calls when any callSession closed
//     callClient.onSessionClosed = (closedCallSession) {
//       print('session closed');
//     };
    startCall();
    super.initState();
  }

  startCall() async {
    // callSession =
    //     callClient.createCallSession(CallType.VIDEO_CALL, {users.last.id!});
    // await callSession?.startCall();
    // await widget.callSession.startCall();

    widget.callSession.onLocalStreamReceived = (mediaStream) async {
      // called when local media stream completely prepared
      // create video renderer and set media stream to it
      RTCVideoRenderer streamRender = RTCVideoRenderer();
      await streamRender.initialize();
      streamRender.srcObject = mediaStream;
      //streamRender.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

      // create view to put it somewhere on screen
      localvideoView = RTCVideoView(
        streamRender,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
        mirror: true,
      );
      setState(() {});
    };
    widget.callSession.onRemoteStreamReceived =
        (session, userId, stream) async {
      print(userId);
      RTCVideoRenderer streamRender = RTCVideoRenderer();
      await streamRender.initialize();
      streamRender.srcObject = stream;
      //streamRender.objectFit = RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

      // create view to put it somewhere on screen
      remotevideoView = RTCVideoView(
        streamRender,
        objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
      );
      setState(() {});
    };

    widget.callSession.onReceiveHungUpFromUser = (session, userId, [userInfo]) {
      print('User Hung up');
      session.closeCurrentSession();
      maybePop(context);
    };
  }

  _leave() async {
    await widget.callSession.closeCurrentSession();
    maybePop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: buildUi(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _leave();
          },
          child: const Icon(
            Icons.close,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  buildUi() {
    return Stack(
      alignment: Alignment.center,
      children: [
        if (remotevideoView == null && localvideoView == null) connecting(),
        remoteStream(),
        localStream(),
        toolBar()
      ],
    );
  }

  Widget toolBar() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  isMuted = !isMuted;
                  widget.callSession.setMicrophoneMute(isMuted);
                });
              },
              icon: Icon(isMuted ? Icons.mic_off_outlined : Icons.mic))
        ],
      ),
    );
  }

  Widget connecting() {
    return const Center(
      child: Text('Connecting'),
    );
  }

  Widget remoteStream() {
    var size = MediaQuery.of(context).size;
    return remotevideoView != null
        ? SizedBox(
            width: size.width,
            height: size.height,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: remotevideoView!,
            ),
          )
        : const SizedBox();
  }

  Widget localStream() {
    var size = MediaQuery.of(context).size;
    print(localvideoView == null ? 'is Null' : 'not null');
    return localvideoView != null
        ? Align(
            alignment: Alignment.topRight,
            child: Container(
                color: Colors.blue,
                height: size.height * 0.1,
                width: size.width * 0.1,
                child: localvideoView!),
          )
        : const SizedBox();
  }

  @override
  void dispose() {
    _leave();
    super.dispose();
  }
}

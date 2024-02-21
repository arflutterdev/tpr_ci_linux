import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import "package:webview_universal/webview_universal.dart";
import 'package:http/http.dart' as http;

class FaceDetectionPreview extends StatefulWidget {
  const FaceDetectionPreview({super.key});

  @override
  State<FaceDetectionPreview> createState() => _FaceDetectionPreviewState();
}

const videoFeed = 'http://10.71.172.171:5000/video_feed';

class _FaceDetectionPreviewState extends State<FaceDetectionPreview> {
  WebViewController webViewController = WebViewController();
  @override
  void initState() {
    super.initState();
    task();
  }

  Future<void> task() async {
    await webViewController.init(
      context: context,
      uri: Uri.parse(videoFeed),
      setState: (void Function() fn) {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: SizedBox(
            height: size.height*0.7,
            width: size.width*0.7,
        child: WebView(
          controller: webViewController,
        ),
      )),
    );
  }
}

// class ImageStream extends StatefulWidget {
//   final String url;

//   ImageStream({required this.url});

//   @override
//   _ImageStreamState createState() => _ImageStreamState();
// }

// class _ImageStreamState extends State<ImageStream> {
//   late http.Client _client;
//   late StreamController<Image> _streamController;

//   @override
//   void initState() {
//     super.initState();
//     _client = http.Client();
//     _streamController = StreamController<Image>();
//     _startStream();
//   }

//   @override
//   void dispose() {
//     _client.close();
//     _streamController.close();
//     super.dispose();
//   }

//   void _startStream() async {
//     var response =
//         await _client.send(http.Request('GET', Uri.parse(widget.url)));
//     print(response);
//     var stream = response.stream;
//     var boundary = response.headers['content-type']!.split('boundary=')[1];

//     Uint8List? imageData;
//     await for (var chunk in stream) {
//       var data = chunk as List<int>;
//       for (var i = 0; i < data.length - boundary.length; i++) {
//         if (String.fromCharCodes(data.sublist(i, i + boundary.length)) ==
//             boundary) {
//           if (imageData != null) {
//             var image = Image.memory(Uint8List.fromList(imageData));
//             _streamController.add(image);
//           }
//           imageData = [] as Uint8List?;
//           i += boundary.length;
//         }
//         imageData!.add(data[i]);
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<Image>(
//       stream: _streamController.stream,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return snapshot.data!;
//         } else {
//           return CircularProgressIndicator();
//         }
//       },
//     );
//   }
// }

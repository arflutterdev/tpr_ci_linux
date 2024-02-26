import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tpr_control_interface_linux/services/ros_service.dart';

class FaceDetectionPreview extends StatefulWidget {
  const FaceDetectionPreview({super.key});

  @override
  State<FaceDetectionPreview> createState() => _FaceDetectionPreviewState();
}

class _FaceDetectionPreviewState extends State<FaceDetectionPreview> {
  RosService rosService = RosService();
  ValueNotifier<String> src = ValueNotifier('');
  @override
  void initState() {
    rosService.suscribeCameraPreview((img) async {
      src.value = img;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Preview'),
      ),
      body: Center(
          child: ValueListenableBuilder(
        valueListenable: src,
        builder: (context, value, child) {
          if (value.isEmpty) {
            return const Text('Unavilable');
          } else {
            return Image.memory(base64Decode(value),gaplessPlayback: true,);
          }
        },
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


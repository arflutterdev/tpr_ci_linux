import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:roslibdart/roslibdart.dart';
import 'package:tpr_control_interface_linux/models/robot_state.dart';
import '../models/navigate_saved_locations.dart';

const rosUrl = 'ws://localhost:9090';
//const rosUrl = 'ws://10.71.172.254:9090';//current
//const rosUrl = 'ws://10.42.0.1:9090';

class RosService {
  static final Ros _ros = Ros(url: rosUrl);
  static RosService? _instance;
  late Timer timer;

  var isRosConnected = ValueNotifier(false);

  ///state idle/interacting
  var currentRobotStateLog = ValueNotifier('initial');

  RosService._internal() {
    //autoConnect();
    //connect();
  }

  autoConnect() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      isRosConnected.value = isConnected;
      if (!isConnected) {
        connect();
      }
    });
  }

  disposeTimer() {
    timer.cancel();
  }

  connect() {
    print('Ros - connecting');
    _ros.connect();
  }

  bool get isConnected {
    return _ros.status == Status.connected;
  }

  factory RosService() {
    _instance ??= RosService._internal();
    return _instance!;
  }

  // topics
  var cmdVel = Topic(
    ros: _ros,
    name: '/cmd_vel',
    type: "geometry_msgs/Twist",
    reconnectOnClose: true,
  );

  var saveLoc = Topic(
    ros: _ros,
    name: '/save_location',
    type: "std_msgs/String",
    reconnectOnClose: true,
  );

  var locations = Topic(
    ros: _ros,
    name: '/locations',
    type: "std_msgs/String",
    reconnectOnClose: true,
  );
  var gotToLocation = Topic(
    ros: _ros,
    name: '/send_goal',
    type: "geometry_msgs/Pose",
    reconnectOnClose: true,
  );

  var robotState = Topic(
    ros: _ros,
    name: '/robot_state',
    type: "std_msgs/String",
    reconnectOnClose: true,
  );
  var faces = Topic(
    ros: _ros,
    name: '/faces',
    type: "std_msgs/String",
   // type: "sensor_msgs/Image",
    reconnectOnClose: true,
  );

//publish
  sendJoyStickCoordinates({required double x, required double y}) async {
    var linear = {'x': y, 'y': 0.0, 'z': 0.0};
    var angular = {'x': 0.0, 'y': 0.0, 'z': x};
    Map<String, dynamic> json = {'linear': linear, 'angular': angular};
    return await cmdVel.publish(json);
  }

//publish
  saveLocation(String label) async {
    Map<String, dynamic> json = {"data": label.replaceAll(' ', '_')};
    return await saveLoc.publish(json);
  }

//suscribe
  getSavedLoactions(Function onLocationRecived) {
    locations.subscribe((args) async {
      //  print(args);
      print(args['data']);
      onLocationRecived(args['data']);
    });
  }

//Publish
  goToLocation(RSavedLocations loc) async {
    var pos = {
      "position": {"x": loc.c1, "y": loc.c2, "z": 0.0},
      "orientation": {"x": loc.c3, "y": loc.c4, "z": loc.c5, "w": loc.c6}
    };
    var time = DateTime.now();
    // Map<String, dynamic> json = {
    //   "pose": pos
    // };
    return await gotToLocation.publish(pos);
  }

  //suscribe
  suscribeToRobotState(Function(RobotState state) onStateChange) async {
    robotState.subscribe((args) async {
      print(args['data']);
      currentRobotStateLog.value='${args['data']}';
      onStateChange(RobotState.fromString(args['data']));
    });
  }

  suscribeCameraPreview(Function(String src) onFrameChange) async {
    faces.subscribe((args) async {
      print("camera: ${args["data"]}");
      onFrameChange(args['data']);
    });
  }

  unsuscribeSavedLocations() {
    locations.unsubscribe();
  }

  unsuscribeRobotState() {
    robotState.unsubscribe();
  }

  unsuscribeCameraPreview() {
    faces.unsubscribe();
  }
}

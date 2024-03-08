import 'dart:io';

import 'package:connectycube_sdk/connectycube_sdk.dart';
import '../config/connectycube_creds.dart';
import '../config/users.dart';

class ConnectyCubeService {
  initConectyCube() {
    init(appId, authKey, authSecret);
    CubeSettings.instance.isDebugEnabled = false;
  }

  Future<CubeUser?> login() async {
    try {
      await createSession(users.first);
      var user = users.first;
      print(user);
      return await CubeChatConnection.instance.login(user);
    } catch (e) {
      print(e);
    }
  }
}

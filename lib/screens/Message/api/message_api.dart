import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/friend_model.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/utils/end_points.dart';

class MessageApi {
  static Future<FriendModel?> friendApi() async {
    try {
      String url = EndPoints.userFriendList;
      http.Response? response = await HttpService.postApi(
        url: url,
        body: jsonEncode({}),
      );

      if (response != null && response.statusCode == 200) {
        return friendModelFromJson(response.body);
      }
      return null;
    } catch (e) {

      errorToast(e.toString());
      return null;
    }
  }
}

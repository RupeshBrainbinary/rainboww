import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rainbow_new/model/list_of_friend_request_model.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class ListOfFriendRequestApi {
  static Future<ListOfFriendRequestModel?> postRegister() async {
    String accessToken = PrefService.getString(PrefKeys.registerToken);
    try {
      String url = EndPoints.listOfFriendRequest;

      http.Response? response =
          await HttpService.postApi(url: url, body: {}, header: {
        /*"Content-Type": "application/json"*/
        "x-access-token": accessToken
      });
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          // flutterToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          // flutterToast( jsonDecode(response.body)["message"]);
        }

        return listOfFriendRequestModelFromJson(response.body);
      }
      return null;
    } catch (e) {

      return null;
    }
  }
}

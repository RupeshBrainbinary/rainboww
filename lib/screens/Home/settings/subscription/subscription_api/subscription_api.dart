import 'dart:convert';

import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/subscription_model.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/utils/pref_keys.dart';

class SubscriptionApi{
  static Future subscriptionApi() async {
    try {
      String url = EndPoints.subscriptionUser;
      String accessToken = PrefService.getString(PrefKeys.registerToken);
      Map<String, String> param = {};
      http.Response? response =
      await HttpService.getApi(url: url,header:{
        "Content-Type": "application/json",
        "x-access-token": accessToken,
      });

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast("Error", title: jsonDecode(response.body)["message"]);
          return null;
        }
        return subscriptionModelFromJson(response.body);
      }
      return null;
    } catch (e) {
      /*errorToast("Error", title: e.toString());*/
      return null;
    }
  }
}
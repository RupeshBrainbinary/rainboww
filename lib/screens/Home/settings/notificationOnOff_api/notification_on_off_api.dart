import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/notification_on_off_model.dart';
import 'package:rainbow_new/model/notofication_data_model.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class NotificationOnOffApi {
  static Future notificationGetData() async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);

    try {
      String url = EndPoints.notificationGetData;
      http.Response? response = await HttpService.getApi(
          url: url, header: {"x-access-token": accesToken});
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          /*flutterToast(jsonDecode(response.body)["message"]);*/
        }
        return notificationDataModelFromJson(response.body);
      }
    } catch (e) {
      return [];
    }
  }

  static Future notificationOn() async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);

    try {
      String url = EndPoints.notificationOn;
      http.Response? response = await HttpService.postApi(
          url: url, body: {}, header: {"x-access-token": accesToken});
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return notificationModelFromJson(response.body);
      }
    } catch (e) {
      return [];
    }
  }

  static Future notificationOff() async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);

    try {
      String url = EndPoints.notificationOff;
      http.Response? response = await HttpService.postApi(
          url: url, body: {}, header: {"x-access-token": accesToken});
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return notificationModelFromJson(response.body);
      }
    } catch (e) {
      return [];
    }
  }
}

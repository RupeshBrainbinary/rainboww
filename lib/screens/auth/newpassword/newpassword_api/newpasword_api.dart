import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/screens/auth/login/login_screen.dart';
import 'package:rainbow_new/screens/auth/newpassword/newpassword_api/newpassword_model.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class CreateNewPasswordApi {
  static Future postRegister(
    String newPassword,
  ) async {
    try {
      String url = EndPoints.createPassword;
      int id = PrefService.getInt(PrefKeys.userId);
      Map<String, String> param = {
        'id': id.toString(),
        'password': newPassword,
      };


      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          Get.offAll(() => LoginScreen());
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return createNewPasswordFromJson(response.body);
      } else if (response!.statusCode == 400) {
        errorToast(jsonDecode(response.body)["message"]);
      }

      /*  message == "Failed! Email is already in use!"
          ? errorToast(message)
          : */

    } catch (e) {

      return [];
    }
  }

  static Future createPasswordAdvertisement(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      String url = EndPoints.createPasswordForAdvertiser;
      String accesToken = PrefService.getString(PrefKeys.registerToken);
      Map<String, String> paramPassword = {
        "current_password": currentPassword,
        "new_password": newPassword
      };


      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(paramPassword),
          header: {
            "Content-Type": "application/json",
            "x-access-token": accesToken
          });
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          Get.offAll(() => LoginScreen());
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return createNewPasswordFromJson(response.body);
      } else if (response!.statusCode == 400) {
        errorToast(jsonDecode(response.body)["message"]);
      }

      /*  message == "Failed! Email is already in use!"
          ? errorToast(message)
          : */

    } catch (e) {

      return [];
    }
  }
}

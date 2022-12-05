import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/logout_model.dart';
import 'package:rainbow_new/screens/auth/auth_dashboard/auth_dashboard.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class LogOutApi {
  static Future postRegister() async {
    try {
      String url = EndPoints.logOut;
      String accesToken = PrefService.getString(PrefKeys.registerToken);

      http.Response? response = await HttpService.postApi(
          url: url, body: {}, header: {"x-access-token": accesToken});
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          flutterToast(jsonDecode(response.body)["message"]);
          /*    await PrefService.clear();*/
          PrefService.setValue(PrefKeys.skipBoardingScreen, true);
          await PrefService.setValue(PrefKeys.loginRole, "");
          await PrefService.setValue(PrefKeys.register, false);
          await PrefService.setValue(PrefKeys.uid, "");
          await PrefService.setValue(PrefKeys.isLogin, false);

          Get.offAll(() => AuthDashboard());
        }
        return logOutModelFromJson(response.body);
      }
    } catch (e) {
      return [];
    }
  }
}

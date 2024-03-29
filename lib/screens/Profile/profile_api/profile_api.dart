import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/screens/Profile/profile_api/profile_model.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class ViewProfileApi {
  static Future postRegister() async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);

    int userId = PrefService.getInt(PrefKeys.userId);
    try {
      String url = EndPoints.viewProfile;

      Map<String, String> param = {"userId": userId.toString()};


      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {
            "Content-Type": "application/json",
            "x-access-token": accesToken
          });

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          /*  errorToast(jsonDecode(response.body)["message"]);*/
        } else if (status == true) {
          // flutterToast( jsonDecode(response.body)["message"]);
          // Get.back();
        }
        return viewProfileFromJson(response.body);
      }
    } catch (e) {

      return [];
    }
  }
}

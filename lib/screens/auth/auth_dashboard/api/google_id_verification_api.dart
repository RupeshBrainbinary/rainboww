import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:rainbow_new/screens/auth/login/login_api/login_api.dart';
import 'package:rainbow_new/screens/auth/login/login_api/login_json.dart';
import 'package:rainbow_new/screens/auth/register/register_controller.dart';
import 'package:rainbow_new/screens/auth/register/register_screen.dart';
import 'package:rainbow_new/screens/dashboard/dash_board.dart';
import 'package:rainbow_new/screens/idVerification/idverification_screen.dart';
import 'package:rainbow_new/screens/selfie_verification/selfie_verification_controller.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class GoogleIdVerification {
  static Future<LoginModel?> postRegister(String id,
      {User? user, String? email}) async {
    try {
      String url = EndPoints.verificationSocial;
      Map<String, String> param = {'id_social': id, 'email': email.toString()};

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});
      if (response != null && response.statusCode == 200) {

        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          //flutterToast(jsonDecode(response.body)["message"]);
          final RegisterController controller = Get.put(RegisterController());
          controller.isSocial = true;
          controller.socialId = id;
          controller.emailController.text = user!.email ?? "";
         /* controller.fullNameController.text = (user.displayName==null? "":user.displayName)!;*/
          controller.phoneController.text = user.phoneNumber ?? "";
          Get.to(() => RegisterScreen());
        } else {
          await PrefService.setValue(PrefKeys.referrallCode,
              jsonDecode(response.body)["data"]["referrall_code"]);
          await PrefService.setValue(
              PrefKeys.userId, jsonDecode(response.body)["data"]["id"]);
          await PrefService.setValue(PrefKeys.registerToken,
              jsonDecode(response.body)["token"].toString());
          if (jsonDecode(response.body)["data"]["status"] == "pending") {
            await PrefService.setValue(PrefKeys.registerToken,
                jsonDecode(response.body)["token"].toString());
            LoginApi.updateDeviceToken();
            if (jsonDecode(response.body)["data"]["id_status"] == "pending") {
              Get.to(() => IdVerificationScreen());
            } else if (jsonDecode(response.body)["data"]["selfi_status"] ==
                "pending") {
              SelfieController selfieController = Get.put(SelfieController());
              selfieController.onNextTap();
              // Get.to(() => ScanYourFaceScreen());
            }
          } else {
            await PrefService.setValue(PrefKeys.isLogin, true);
            Get.offAll(() => const Dashboard());
          }
        }
        return loginModelFromJson(response.body);
      } else if (response!.statusCode == 500) {
        // flutterToast(jsonDecode(response.body)["message"]);
      }
      return null;
    } catch (e) {


      return null;
    }
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/screens/auth/phonenumber/phonenumber_api/phonenumber_json.dart';
import 'package:rainbow_new/screens/auth/register/widget/RegisterVerifyOtp_Screen.dart';
import 'package:rainbow_new/screens/auth/verify_phone/verify_controller.dart';
import 'package:rainbow_new/screens/auth/verify_phone/verifyphone_screen.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class PhoneNumberApi {
  static Future postRegister(
    String email,
  ) async {
    // List<PhoneNumber> phoneList = [];
    try {
      String url = EndPoints.mobileCheck;
      Map<String, String> param = {
        'email': email,
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
        /*  await PrefService.setValue(PrefKeys.register, true);*/
          await PrefService.setValue(
              PrefKeys.userId, jsonDecode(response.body)["data"]["id"]);
          VerifyPhoneController controller = Get.put(VerifyPhoneController());
          controller.startTimer();
          Get.to(() => const VerifyPhoneScreen());
          flutterToast(jsonDecode(response.body)["message"]);
        }
        VerifyPhoneController controller = Get.put(VerifyPhoneController());
        controller.startTimer();
        return phoneNumberFromJson(response.body);
      }

      /*  message == "Failed! Email is already in use!"
          ? errorToast(message)
          : */
    } catch (e) {
      return [];
    }
  }

  static Future sendOtp(
    String phoneNumber,
  ) async {
    try {
      String url = EndPoints.mobileCheck;
      Map<String, String> param = {
        'phoneNumber': phoneNumber,
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
         /* await PrefService.setValue(PrefKeys.register, true);*/
          await PrefService.setValue(
              PrefKeys.phoneId, jsonDecode(response.body)["data"]["id"]);
          Get.to(() => const RegisterOtpScreen());
          flutterToast(jsonDecode(response.body)["message"]);
        }

        return phoneNumberFromJson(response.body);
      }

      /*  message == "Failed! Email is already in use!"
          ? errorToast(message)
          : */
    } catch (e) {
      return [];
    }
  }

  static Future resendOtp(
    String phoneNumber,
  ) async {
    try {
      String url = EndPoints.mobileCheck;
      Map<String, String> param = {
        'phoneNumber': phoneNumber,
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
          // await PrefService.setValue(PrefKeys.register, true);
          await PrefService.setValue(
              PrefKeys.phoneId, jsonDecode(response.body)["data"]["id"]);
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return phoneNumberFromJson(response.body);
      }

      /*  message == "Failed! Email is already in use!"
          ? errorToast(message)
          : */
    } catch (e) {
      return [];
    }
  }

  static Future advertiserSendOtp(
    String phoneNumber,
  ) async {
    try {
      String url = EndPoints.mobileCheck;
      Map<String, String> param = {
        'email': phoneNumber,
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
          // await PrefService.setValue(PrefKeys.register, true);
          await PrefService.setValue(
              PrefKeys.phoneId, jsonDecode(response.body)["data"]["id"]);

          flutterToast(jsonDecode(response.body)["message"]);
        }
        return phoneNumberFromJson(response.body);
      }

      /*  message == "Failed! Email is already in use!"
          ? errorToast(message)
          : */
    } catch (e) {
      //errorToast("No internet connection");

      return [];
    }
  }
}

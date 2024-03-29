import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/screens/advertisement/AdvertiserTermsAndConditions_Screen/advertiserTerms_screen.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/change_password/advertiser_verify_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/change_password/advertiser_verify_otp_screen.dart';
import 'package:rainbow_new/screens/advertisement/change_password_advertiser_screen.dart';
import 'package:rainbow_new/screens/auth/registerfor_adviser/adviser_api/adviser_json.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class AdvirtisersApi {
  static Future postRegister(
      String fullName,
      String email,
      String password,
      String houseNumber,
      String streetName,
      String phoneNumber,
      String city,
      String idCountry,
      String postalCode,
      String profession,
      String comanyName,
      String companyNumber,
      String streetNam,
      String companyCity,
      String country,
      String comapanyPostalCode,
      String website) async {
    try {
      String url = EndPoints.advirtisersRegister;
      Map<String, dynamic> param = {
        "fullName": fullName,
        "email": email,
        "password": password,
        "houseNumber": houseNumber,
        "streetName": streetName,
        "phoneNumber": phoneNumber,
        "city": city,
        "id_country": idCountry,
        "postalCode": postalCode,
        "role": "advertisers",
        "company": {
          "profession": profession,
          "companyName": comanyName,
          "companyNumber": companyNumber,
          "streetName": streetName,
          "city": companyCity,
          "id_country": country,
          "postalCode": comapanyPostalCode,
          "website": website
        }
      };


      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {"Content-Type": "application/json"});
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          // errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {

          /*PrefService.setValue(PrefKeys.register, true);*/
          await PrefService.setValue(PrefKeys.phonSaveNumberAdvertiser,
              jsonDecode(response.body)["data"]["phone_number"]);


         /* advertiserVerifyController.phoneNumber =
              jsonDecode(response.body)["data"]["phone_number"];*/

          AdvertiserVerifyController adController = Get.put(AdvertiserVerifyController());
          adController.backScreen = 'DoctorRegisterScreen';

          //adController.backScreen = 'AdvertisementDashBord';
          //advertiserVerifyController.phoneNumberRegister();
          //Get.to(() => const AdvertiserVerifyOtpScreen());

          await PrefService.setValue(PrefKeys.loginRole, jsonDecode(response.body)["data"]["role"]);


          if (adController.backScreen == "AdvertisementDashBord") {
            Get.to(() => const AdvertiserChangePasswordScreen());
          } else {
            Get.to(() => const AdvertiserTermsAndConditionsScreen());
          }

          await PrefService.setValue(PrefKeys.companyRegister, true);
          // flutterToast(jsonDecode(response.body)["message"]);
        }
        return advertiserRegisterFromJson(response.body);

      } else if (response!.statusCode == 500) {
        errorToast("Please enter valid country name");

        // errorToast(jsonDecode(response.body)["message"]);
      } else {
        errorToast(jsonDecode(response.body)["message"]);
      }
      /*  message == "Failed! Email is already in use!"
          ? errorToast(message)
          : */
      // return
    } catch (e) {

      return advertiserRegisterFromJson("");
    }
  }
}

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/create_advertiser_model.dart';
import 'package:rainbow_new/screens/Home/settings/payment/payment_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/screen/payment_successful/payment_successful_screen.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class AddAdvertisement {
  static Future addAdvertisementApi({
    List? tagUser,
    String? title,
    List? idItem,
    String? location,
    String? description,
    String? date,
    String? urlLink,
    String? postalCode,
    String? province,
    String? startDate,
    String? endDate,
    String? city,
    String? street,
    String? countryCode,
    String? callAction,
    int? amount,
  }) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    // int userId = PrefService.getInt(PrefKeys.userId);
    try {
      String url = EndPoints.createAdvertisement;
      Map<String, dynamic> param = {
        "tags": tagUser!,
        "id_item": idItem!,
        "title": title.toString(),
        "location": location.toString(),
        "city": city.toString(),
        "street": street.toString(),
        "id_country": countryCode.toString(),
        "postal_code": postalCode.toString(),
        "province": province.toString(),
        "date": date.toString(),
        "description": description.toString(),
        "call_action": callAction.toString(),
        "start_date": startDate.toString(),
        "end_date": endDate.toString(),
        "url_link": urlLink.toString(),
        "amount": amount,
      };

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(param),
          header: {
            "Content-Type": "application/json",
            "x-access-token": accesToken
          });

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == true) {
          final PaymentController controller = Get.find();
          await controller.transactionApiPagination();
          //adHomeController.myAdvertiserListData();

          Get.to(() => PaymentSuccessfulScreen());

          flutterToast(jsonDecode(response.body)["message"]);
        }
        return advertisersCreateModelFromJson(response.body);
      }
      /* else if(response!.statusCode == 500){
        errorToast("Please enter valid country name");
      }*/
    } catch (e) {
      return [];
    }
  }
}

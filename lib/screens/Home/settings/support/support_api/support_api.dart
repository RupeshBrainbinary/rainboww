import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/list_support_ticket_model.dart';
import 'package:rainbow_new/model/View_support_ticket_model.dart';
import 'package:rainbow_new/model/send_support_model.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class SupportApi {
  static Future supportListApi() async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);

    try {
      String url = EndPoints.supportListTicket;

      Map<String, String> param = {};


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
          //errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          /*    flutterToast(jsonDecode(response.body)["message"]);*/
        }
        return listSupportTicketModelFromJson(response.body);
      }
    } catch (e) {
      //errorToast("No internet connection");
      return [];
    }
  }

  static Future viewSupportTicket({String? id}) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);

    try {
      String url = EndPoints.viewSupportTicket;

      Map<String, String> param = {"id_support": id.toString()};

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
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          //flutterToast(jsonDecode(response.body)["message"]);
        }
        return viewSupportTicketModelFromJson(response.body);
      }
    } catch (e) {

      return ViewSupportTicketModel();
    }
  }

  static Future sendSupportApi(
      {String? id, String? description, List<int>? item}) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);

    try {
      String url = EndPoints.sendSupport;

      Map<String, dynamic> param = {
        "type": "user",
        "id_support": id,
        "description": description,
        "id_item": item,
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
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return sendSupportModelFromJson(response.body);
      }
    } catch (e) {

      return [];
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';

import 'package:rainbow_new/model/default_crad_model.dart';

import 'package:rainbow_new/model/list_card_model.dart';
import 'package:rainbow_new/model/remove_card_model.dart';
import 'package:rainbow_new/model/transaction_model.dart';

import 'package:rainbow_new/model/view_cardM_model.dart';

import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class ListCartApi {
  static Future listCardsApi({bool? showToast}) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    try {
      String url = EndPoints.listCartDetails;

      http.Response? response = await HttpService.postApi(url: url, header: {
        "Content-Type": "application/json",
        "x-access-token": accesToken
      });
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          //errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          //showToast ? flutterToast(jsonDecode(response.body)["message"]) : SizedBox();
        }
        return listCardModelFromJson(response.body);
      }
    } catch (e) {
      return [];
    }
  }

  static Future viewCardsApi({int? id}) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    try {
      String url = EndPoints.viewCard;

      Map<String, dynamic> data = {"id_card": id};

      http.Response? response = await HttpService.postApi(
          url: url,
          body: jsonEncode(data),
          header: {
            "Content-Type": "application/json",
            "x-access-token": accesToken
          });
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          //errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {}
        return viewCardModelFromJson(response.body);
      }
    } catch (e) {
      return null;
    }
  }

  static Future removeCardApi({int? id}) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    try {
      String url = EndPoints.removeCard;

      Map<String, dynamic> param = {
        "id_card": id,
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
        return removeCardModelFromJson(response.body);
      }
    } catch (e) {
      return [];
    }
  }

  static Future transactionApi(int page) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    try {
      String url = EndPoints.transaction;
      Map<String, dynamic> param = {"page": page, "limit": 10};
      http.Response? response =
          await HttpService.postApi(url: url, body: jsonEncode(param), header: {
        "Content-Type": "application/json",
        "x-access-token": accesToken
      });
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          // errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          //flutterToast(jsonDecode(response.body)["message"]);

        }
        return transactionModelFromJson(response.body);
      }
    } catch (e) {
      return [];
    }
  }

  static Future defaultCardApi({int? id}) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    try {
      String url = EndPoints.defaultCard;

      Map<String, dynamic> param = {
        "id_card": id,
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
        return defaultCradModelFromJson(response.body);
      }
    } catch (e) {
      return [];
    }
  }
}

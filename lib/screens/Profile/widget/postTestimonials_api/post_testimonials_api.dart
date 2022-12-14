import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/list_testimonials_model.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class PostTestimonialsApi {
  static Future postTestimonials(
      String id, String textTestimonials, BuildContext context) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    // int userId = PrefService.getInt(PrefKeys.userId);
    try {
      String url = EndPoints.testimonial;
      Map<String, dynamic> param = {
        "id_reciever": id,
        "testimonial": textTestimonials
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
          Navigator.pop(context);
          flutterToast(jsonDecode(response.body)["message"]);
          
        }
        return postTestimonialsModelFromJson(response.body);
      }
    } catch (e) {

      return [];
    }
  }
}

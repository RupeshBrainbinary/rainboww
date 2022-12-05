import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/comment_story_delete_model.dart';
import 'package:rainbow_new/service/http_services.dart';

import 'package:rainbow_new/utils/end_points.dart';

class CommentStoryDeleteApi {
  static Future postRegister(String id) async {
    try {
      String url = EndPoints.commentStoryDelete;

      Map<String, String> param = {"id_comment_story": id.toString()};
      if (kDebugMode) {
        print(param);
      }
      http.Response? response = await HttpService.postApi(
        url: url,
        body: jsonEncode(param),
      );
      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return commentStoryDeleteModelFromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}

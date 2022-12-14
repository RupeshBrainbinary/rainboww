// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/create_post_model.dart';
import 'package:rainbow_new/model/friend_stroy_model.dart';
import 'package:rainbow_new/model/my_post_list_model.dart';
import 'package:rainbow_new/screens/Home/view_story/view_story_controller.dart';
import 'package:rainbow_new/service/http_services.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/end_points.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class FriendStoryApi {
  static Future postRegister() async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    // int userId = PrefService.getInt(PrefKeys.userId);
    try {
      String url = EndPoints.friendStory;

      http.Response? response = await HttpService.getApi(
          url: url, header: {"x-access-token": accesToken});

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          /*  flutterToast(jsonDecode(response.body)["message"]);*/
        } else if (status == true) {
          // flutterToast( jsonDecode(response.body)["message"]);
        }
        return storyModelFromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  static Future getMyPostList() async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    // int userId = PrefService.getInt(PrefKeys.userId);
    try {
      String url = EndPoints.myPostList;

      http.Response? response = await HttpService.postApi(url: url, header: {
        "Content-Type": "application/json",
        "x-access-token": accesToken
      });

      if (response != null && response.statusCode == 200) {
        bool? status = jsonDecode(response.body)["status"];
        if (status == false) {
          errorToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          // flutterToast( jsonDecode(response.body)["message"]);
        }
        return myPostListModelFromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }

  static Future createPost(BuildContext context, List listItems, String tittle,
      String description, List<Map<String, dynamic>> list) async {
    String accesToken = PrefService.getString(PrefKeys.registerToken);
    // int userId = PrefService.getInt(PrefKeys.userId);
    try {
      String url = EndPoints.createPost;
      Map<String, dynamic> param = {
        "title": tittle,
        "description": description,
        "id_item": listItems,
        "tag": list
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
          flutterToast(jsonDecode(response.body)["message"]);
        } else if (status == true) {
          ViewStoryController viewStoryController = Get.find();
          viewStoryController.writeSomethings.clear();
          viewStoryController.image.clear();
          viewStoryController.tagUserList.clear();
          Get.back(result: true);
          flutterToast(jsonDecode(response.body)["message"]);
        }
        return createPostModelFromJson(response.body);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return [];
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/model/friend_stroy_model.dart';
import 'package:rainbow_new/screens/Home/home_controller.dart';

class StoryCommentsController extends GetxController {
  RxBool loader = false.obs;
  List<StoryCommentList> comments = [];
  MyStory story = MyStory();
  TextEditingController commentController = TextEditingController();
  HomeController homeController = Get.put(HomeController());
  List<bool> reply = [
    true,
    true,
    false,
    true,
    false,
    true,
    true,
    false,
    true,
    true
  ];

  void init() {}

  void onCommentSend() {
    // if(commentController.text.trim().isEmpty){
    //   return;
    // }
    // StoryCommentApi.sendNewComment(story.id.toString(), commentController.text);
  }
}

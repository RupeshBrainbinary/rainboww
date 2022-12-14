import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/addStroy/add_story_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

Widget addStoryAppBar(AddStoryController controller) {
  return Padding(
    padding: const EdgeInsets.only(top: 20),
    child: Row(
      children: [
        const SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Image.asset(
            AssetRes.backIcon,
            height: 16,
            width: 35,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: Get.width * 0.28,
        ),
        Text(
          Strings.addToStory,
          style: beVietnamProMediumTextStyle(
              fontSize: 16, color: ColorRes.color_252525),
        ),
        SizedBox(
          width: Get.width * 0.22,
        ),
        Text(
          Strings.post,
          style: beVietnamProMediumTextStyle(
              fontSize: 13, color: ColorRes.color_252525),
        )
      ],
    ),
  );
}

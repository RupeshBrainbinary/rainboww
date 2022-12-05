import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/addStroy/add_story_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

Widget addStoryCamera(AddStoryController controller) {
  return Container(
    width: Get.width * 0.328,
    color: ColorRes.colorF4F4F4,
    child: InkWell(
      onTap: () {
        controller.camera();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 19.5,
            width: 19.5,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetRes.shapeCamera),
                    fit: BoxFit.cover)),
          ),
          Text(
            Strings.camera,
            style: beVietnamSemiBoldTextStyle(
                fontSize: 12, color: ColorRes.color_252525),
          )
        ],
      ),
    ),
  );
}

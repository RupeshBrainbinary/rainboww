import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_profile/connections_profile_controller.dart';
import 'package:rainbow_new/utils/strings.dart';
import 'package:readmore/readmore.dart';

import '../../../../../../common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Profile/profile_api/profile_model.dart' as model;

import '../../../../../../utils/color_res.dart';

class HobbiesArea extends StatelessWidget {
  final ConnectionsProfileController controller = Get.find();

  HobbiesArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    model.Data? data = controller.profileController.viewProfile.data;

    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: Get.height * 0.04926),
          Text(
            Strings.hobbies,
            style: beVietnamProBoldTextStyle(fontSize: 18),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: ReadMoreText(
              data!.hobbiesAndInterest.toString() == ""
                  ? ""
                  : data.hobbiesAndInterest.toString(),
              /* aboutMe,*/
              trimLines: 3,
              trimMode: TrimMode.Line,
              delimiter: " ",
              trimCollapsedText: Strings.seeMore,
              trimExpandedText: Strings.seeLess,
              style: beVietnamProRegularTextStyle(
                  color: ColorRes.white.withOpacity(0.70), fontSize: 18),
              moreStyle: beVietnamProRegularTextStyle(
                color: ColorRes.colorFF6B97,
              ),
              lessStyle: beVietnamProRegularTextStyle(
                color: ColorRes.colorFF6B97,
              ),
            ),
          ),
          SizedBox(height: Get.height * 0.04926),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/buttons.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

class AdvertisementApprovedScreen extends StatelessWidget {
  String? traId;
   AdvertisementApprovedScreen({Key? key, required this.traId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorRes.color_50369C,
              ColorRes.color_50369C,
              ColorRes.colorD18EEE,
              ColorRes.colorD18EEE,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              textDetails(),
              SizedBox(
                height: Get.height * 0.08,
              ),
              imageShow(),
              SizedBox(
                height: Get.height * 0.1,
              ),
              backToHome(),
              SizedBox(
                height: Get.height * 0.1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textDetails() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.1219,
        ),
        SizedBox(
            height: 64,
            width: 264,
            child: Text(
              Strings.advertisementApproved,
              style: gilroyBoldTextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            )),
        const SizedBox(
          height: 22,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 43, right: 41),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.transactionNumber,
                    style: gilroyMediumTextStyle(
                        color: ColorRes.colorC4C4C4, fontSize: 12),
                  ),
                  Text(
                    "$traId",
                    style: gilroyMediumTextStyle(fontSize: 14),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.service,
                    style: gilroyMediumTextStyle(
                        color: ColorRes.colorC4C4C4, fontSize: 12),
                  ),
                  Text(
                    Strings.postAds,
                    style: gilroyMediumTextStyle(fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Container(
          height: 25,
          width: 282,
          decoration: BoxDecoration(
            /*      gradient: const LinearGradient(
                  colors: [
                    // ColorRes.color_50369C,
                    ColorRes.color_50369C,
                    ColorRes.colorB57BDD,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),*/
            boxShadow: [
              BoxShadow(
                color: ColorRes.colorB57BDD.withOpacity(0.3),
                spreadRadius: 12,
                blurRadius: 12,
                offset: const Offset(4, 5),
              ),
            ],
          ),
          child: Text(
            Strings.approvedByRainbowAdmin,
            style: gilroyMediumTextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }

  Widget imageShow() {
    return Image.asset(
      AssetRes.baby,
      height: Get.height * 0.377,
      width: 245,
    );
  }

  Widget backToHome() {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: const SubmitButton(
        text: Strings.backToHome,
      ),
    );
  }
}

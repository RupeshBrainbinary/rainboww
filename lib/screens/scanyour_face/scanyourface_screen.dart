import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/scanyour_face/scanyourface_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

class ScanYourFaceScreen extends StatelessWidget {
  ScanYourFaceScreen({Key? key}) : super(key: key);
  final ScanYourFaceController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanYourFaceController>(
      id: "imagePicker",
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Obx(
            () {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: EdgeInsets.all(Get.width * 0.02669),
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: Get.height - (Get.width * 0.05338)),
                      decoration: BoxDecoration(
                        color: ColorRes.color_4F359B,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: Get.height * 0.03),
                          GestureDetector(
                            onTap: Get.back,
                            child:  Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Image.asset(AssetRes.backIcon,height: 16,width: 35,),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.03),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              Strings.selfie,
                              style: gilroyBoldTextStyle(fontSize: 26),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.009),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 29,
                                width: 29,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorRes.colorB279DB,
                                ),
                              ),
                              Container(
                                height: 5,
                                width: Get.width * 0.25,
                                color: ColorRes.colorB279DB,
                              ),
                              Container(
                                height: 29,
                                width: 29,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorRes.colorB279DB,
                                ),
                              ),
                              Container(
                                height: 5,
                                width: Get.width * 0.25,
                                color: ColorRes.colorB279DB,
                              ),
                              Container(
                                height: 29,
                                width: 29,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorRes.colorB279DB,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.03),
                          Padding(
                            padding: EdgeInsets.only(left: Get.height * 0.028),
                            child: SizedBox(
                              height: Get.height * 0.046,
                              width: Get.width * 0.836619,
                              child: Center(
                                child: Text(
                                  Strings.scanYourFace,
                                  style: gilroyBoldTextStyle(
                                    fontSize: 26,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.03),

                          // buildCameraFunction(context, controller),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Center(
                                child: Image.asset(AssetRes.scanYourFace,
                                    width: Get.width),
                              ),
                              Center(
                                child: controller.imageFront == null
                                    ? const SizedBox()
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(300),
                                        child: Image.file(
                                          File(
                                              controller.imageFront.toString()),
                                          width: Get.width * 0.62,
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          SizedBox(height: Get.height * 0.05),
                          InkWell(
                            onTap: controller.takePicForFront,
                            child: Center(
                              child: Container(
                                width: Get.width * 0.84788,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: ColorRes.colorE7D01F,
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorRes.colorFFEC5C,
                                      ColorRes.colorDFC60B
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    Strings.next,
                                    style: gilroyBoldTextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: Get.height * 0.02956),
                        ],
                      ),
                    ),
                  ),
                  controller.loader.isTrue
                      ? const FullScreenLoader()
                      : const SizedBox(),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

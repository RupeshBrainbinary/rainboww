import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_field.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/auth/newpassword/newpassword_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewPasswordController controller = Get.put(NewPasswordController());
    return GetBuilder<NewPasswordController>(
      id: "newPassword",
      builder: (controller) {
        return Scaffold(
            backgroundColor: Colors.white,
            body: Obx(() {
              return Stack(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              /*  height: Get.height * 0.96,
                          width: Get.width * 0.946666,*/
                              margin: EdgeInsets.all(Get.width * 0.02669),
                              decoration: BoxDecoration(
                                  color: ColorRes.color_4F359B,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.03,
                                  ),
                                  GestureDetector(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        height: 16,
                                        child: Image.asset(
                                          AssetRes.backIcon,
                                          height: 16,
                                          width: 35,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                  SizedBox(
                                    height: Get.height * 0.07,
                                  ),
                                  Center(
                                    child: Container(
                                      height: 137.39,
                                      width: 137,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(AssetRes.lock),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.04,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      height: 39.9,
                                      child: Text(
                                        Strings.newPassword,
                                        style: gilroySemiBoldTextStyle(
                                            fontSize: 30),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      height: 49,
                                      child: Text(
                                        Strings.newPasswordChange,
                                        style: gilroyMediumTextStyle(
                                            color:
                                                ColorRes.white.withOpacity(0.5),
                                            fontSize: 16),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.05,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: Get.width * 0.85,
                                      child: AppTextFiled(
                                        controller:
                                            controller.newPasswordController,
                                        title: Strings.newPassword,
                                        hintText: Strings.passwordExample,
                                        suffix: InkWell(
                                            onTap: () {
                                              controller.onTapShowNewPwd();
                                              controller
                                                  .update(["newPassword"]);
                                            },
                                            child: controller.showNewPwd == true
                                                ? const Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    color: Colors.grey,
                                                  )
                                                : const Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.grey,
                                                  )),
                                        obscure: controller.showNewPwd == true
                                            ? false
                                            : true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.01,
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: Get.width * 0.85,
                                      child: AppTextFiled(
                                        controller: controller
                                            .confirmPasswordController,
                                        title: Strings.confirmPassword,
                                        suffix: InkWell(
                                            onTap: () {
                                              controller.onTapShowConfirmPwd();
                                              controller
                                                  .update(["newPassword"]);
                                            },
                                            child: controller.showConfirmPwd ==
                                                    true
                                                ? const Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    color: Colors.grey,
                                                  )
                                                : const Icon(
                                                    Icons.remove_red_eye,
                                                    color: Colors.grey,
                                                  )),
                                        hintText: Strings.passwordExample,
                                        obscure:
                                            controller.showConfirmPwd == true
                                                ? false
                                                : true,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.018,
                                  ),
                                  GestureDetector(
                                    onTap: controller.onRegisterTap,
                                    child: Center(
                                      child: Container(
                                        width: Get.width * 0.8450,
                                        height: Get.height * 0.07624,
                                        decoration: BoxDecoration(
                                            color: ColorRes.colorE7D01F,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                          child: Text(
                                            Strings.submit,
                                            style: gilroyBoldTextStyle(
                                                color: Colors.black,
                                                fontSize: 16),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: Get.height * 0.18),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  controller.loader.isTrue
                      ? const FullScreenLoader()
                      : const SizedBox()
                ],
              );
            }));
      },
    );
  }
}

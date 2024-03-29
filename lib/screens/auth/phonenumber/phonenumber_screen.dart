import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_field.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/auth/phonenumber/phonenumber_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

class PhoneNumberScreen extends StatelessWidget {
  PhoneNumberScreen({Key? key}) : super(key: key);

  final PhoneNumberController controller = Get.put(PhoneNumberController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(
        () {
          return Stack(
            children: [
              GetBuilder<PhoneNumberController>(
                id: "Phone",
                builder: (controller) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: Get.height * 0.96,
                          width: Get.width,
                          margin: EdgeInsets.fromLTRB(
                            Get.width * 0.02667,
                            Get.width * 0.02667,
                            Get.width * 0.02667,
                            0,
                          ),
                          decoration: BoxDecoration(
                            color: ColorRes.color_4F359B,
                            borderRadius: BorderRadius.circular(36),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: Get.height * 0.07,
                                  ),
                                  logo(),
                                  SizedBox(
                                    height: Get.height * 0.09,
                                  ),
                                  // phoneTextField(context),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                                    child: AppTextFiled(
                                      controller: controller.emailController,
                                      title: Strings.email,
                                      hintText: Strings.naranataliEmail,
                                      textInputType: TextInputType.emailAddress,
                                      fontsize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: Get.height * 0.06,
                                  ),
                                  loginButton()
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              controller.loader.isTrue
                  ? const FullScreenLoader()
                  : const SizedBox()
            ],
          );
        },
      ),
    );
  }

  Widget logo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          height: Get.height * 0.2,
        ),
        Center(
          child: Container(
            height: Get.height * 0.1207,
            width: Get.width * 0.84,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AssetRes.rainBowLogo),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget phoneTextField(BuildContext context) {
    return GetBuilder<PhoneNumberController>(
      id: 'Phone',
      builder: (controller) {
        return Center(
          child: SizedBox(
            width: Get.width * 0.83,
            child: AppTextFiled(
              controller: controller.phoneNumber,
              title: Strings.phoneNumber,
              hintText: Strings.phoneNumber,
              textInputType: TextInputType.phone,
              prefix: countryCodePicker(context),
              inputPadding: EdgeInsets.only(left: Get.width * 0.04),
              fontsize: 16,
            ),
          ),
        );
      },
    );
  }

  Widget countryCodePicker(BuildContext context) {
    return InkWell(
      onTap: () => controller.onCountryTap(context),
      child: Row(
        children: [
          Text(controller.countryModel.flagEmoji),
          const SizedBox(width: 9),
          Text(
            "+${controller.countryModel.phoneCode}",
            style: gilroyMediumTextStyle(fontSize: 14, color: Colors.black),
          ),
          SizedBox(width: Get.width * 0.04533),
          Image.asset(AssetRes.dropdown, height: 6),
          SizedBox(width: Get.width * 0.024),
        ],
      ),
    );
  }

  Widget loginButton() {
    return GestureDetector(
      onTap: controller.onRegisterTap,
      child: Center(
        child: Container(
          width: Get.width * 0.8450,
          height: 60,
          decoration: BoxDecoration(
            color: ColorRes.colorE7D01F,
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [ColorRes.colorFFEC5C, ColorRes.colorDFC60B],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
              child: Text(
            Strings.submit,
            style: gilroyBoldTextStyle(color: Colors.black, fontSize: 16),
          )),
        ),
      ),
    );
  }
}

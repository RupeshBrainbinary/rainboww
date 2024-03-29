import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/change_password/advertiser_verify_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

import '../../../../common/Widget/loaders.dart';
import '../../../../common/Widget/text_styles.dart';
import '../../../../utils/color_res.dart';
import '../../../../utils/strings.dart';

class AdvertiserVerifyOtpScreen extends StatefulWidget {
  const AdvertiserVerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<AdvertiserVerifyOtpScreen> createState() =>
      _AdvertiserVerifyOtpScreenState();
}

class _AdvertiserVerifyOtpScreenState extends State<AdvertiserVerifyOtpScreen> {
  AdvertiserVerifyController controller = Get.put(AdvertiserVerifyController());
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AdHomeController adHomeController = Get.put(AdHomeController());

  @override
  void initState() {
    controller.startTimer();
    controller.verifyController = TextEditingController();
    /*  controller.phoneNumberRegister();*/
    super.initState();
  }

  @override
  void dispose() {
    //controller.verifyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AdvertiserVerifyController controller = Get.put(AdvertiserVerifyController());
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: Container(
                          height: Get.height * 0.94,
                          width: Get.width * 0.946666,
                          /*  margin: EdgeInsets.all(Get.width * 0.02669),*/
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
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, top: 10),
                                  child: Image.asset(
                                    AssetRes.backIcon,
                                    height: 16,
                                    width: 35,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.09,
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    Strings.verifyPhone,
                                    style: gilroyBoldTextStyle(fontSize: 26),
                                  )),
                              SizedBox(
                                height: Get.height * 0.009,
                              ),
                              GetBuilder<AdvertiserVerifyController>(
                                builder: (controller) {
                                  return Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: Get.width * 0.85,
                                            child: Text(
                                              "${Strings.codeSent} ${adHomeController.viewAdvertiserModel.data!.email.toString()}",
                                              style: TextStyle(
                                                  overflow: TextOverflow.ellipsis,
                                                  color: ColorRes.white
                                                      .withOpacity(0.5),
                                                  fontSize: 14,
                                                  fontFamily: "Gilroy-Light",
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          // Text(
                                          //   "${Strings.codeSent} ${PrefService.getString(PrefKeys.phonSaveNumberAdvertiser).toString()}",
                                          //   style: TextStyle(
                                          //       color: ColorRes.white
                                          //           .withOpacity(0.5),
                                          //       fontSize: 14,
                                          //       fontFamily: "Gilroy-Light",
                                          //       fontWeight: FontWeight.w600),
                                          // ),
                                        ],
                                      ));
                                },
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              Form(
                                key: formKey,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: PinCodeTextField(
                                      appContext: context,
                                      textStyle:
                                          const TextStyle(color: Colors.black),
                                      pastedTextStyle: TextStyle(
                                        color: Colors.green.shade600,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      length: 4,
                                      // obscureText: true,
                                      // obscuringCharacter: '*',
                                      blinkWhenObscuring: true,
                                      animationType: AnimationType.fade,
                                      validator: (v) {
                                        if (v!.length < 4) {
                                          return Strings.enterYourOtp;
                                        } else {
                                          return null;
                                        }
                                      },
                                      pinTheme: PinTheme(
                                          inactiveFillColor: Colors.white,
                                          inactiveColor: Colors.white,
                                          shape: PinCodeFieldShape.circle,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          borderWidth: 1,
                                          fieldHeight: 60,
                                          fieldWidth: 60,
                                          activeColor: Colors.black,
                                          selectedColor: Colors.yellow,
                                          activeFillColor: Colors.white,
                                          selectedFillColor: Colors.white),
                                      cursorColor: Colors.black,
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      enableActiveFill: true,
                                      enabled: true,
                                      // errorAnimationController: controller.errorController,
                                      controller: controller.verifyController,
                                      keyboardType: TextInputType.number,
                                      boxShadows: const [
                                        BoxShadow(
                                          offset: Offset(0, 1),
                                          color: Colors.black12,
                                          blurRadius: 10,
                                        )
                                      ],
                                      onCompleted: (v) {},
                                      onChanged: (value) {},
                                      beforeTextPaste: (text) {
                                        return true;
                                      },
                                    )),
                              ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              GetBuilder<AdvertiserVerifyController>(
                                id: 'count_timer',
                                builder: (controller) {
                                  return Center(
                                      child: Text(
                                          "${controller.seconds.toString()} Seconds"));
                                },
                              ),
                              Center(
                                child: Text(
                                  Strings.receivedCode,
                                  style: gilroyMediumTextStyle(
                                      color: ColorRes.white.withOpacity(0.5),
                                      fontSize: 16),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.022,
                              ),
                              GetBuilder<AdvertiserVerifyController>(
                                id: "time",
                                builder: (controller) => controller.seconds == 0
                                    ? InkWell(
                                        onTap: () {
                                          controller.startTimer();
                                          controller.phoneNumberRegister();
                                        },
                                        child: Center(
                                          child: Text(
                                            Strings.resendOtp,
                                            style: gilroyBoldTextStyle(
                                              fontSize: 16,
                                              color: ColorRes.color_69C200,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          Strings.resendOtp,
                                          style: gilroyBoldTextStyle(
                                            fontSize: 16,
                                            color:
                                                ColorRes.white.withOpacity(0.2),
                                          ),
                                        ),
                                      ),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (formKey.currentState!.validate()) {
                                    controller.verifyCode();
                                  }
                                },
                                child: Center(
                                  child: Container(
                                    width: Get.width * 0.84788,
                                    height: Get.height * 0.07575,
                                    decoration: BoxDecoration(
                                        color: ColorRes.colorE7D01F,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                        child: Text(
                                      Strings.verifyAccount,
                                      style: gilroyBoldTextStyle(
                                          color: Colors.black, fontSize: 16),
                                    )),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            controller.loader.isTrue
                ? const FullScreenLoader()
                : const SizedBox(),
          ],
        );
      }),
    );
  }
}

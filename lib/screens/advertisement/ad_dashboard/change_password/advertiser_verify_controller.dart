import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/screens/auth/phonenumber/phonenumber_api/phonenumber_api.dart';
import 'package:rainbow_new/screens/auth/verify_phone/verifyPhone_api/verify_phone_json.dart';
import 'package:rainbow_new/screens/auth/verify_phone/verifyPhone_api/verifyphone_api.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/pref_keys.dart';
import 'package:rainbow_new/utils/strings.dart';

class AdvertiserVerifyController extends GetxController {
  TextEditingController verifyController = TextEditingController();
  RxBool loader = false.obs;
  int seconds = 60;
  Timer? _countDown;
  String phoneNumber = "";
  String backScreen = "";



  bool validation() {
    if (verifyController.text.isEmpty) {
      errorToast(Strings.enterYourOtp);
      return false;
    }
    return true;
  }

  VerifyCode verifyCodeModel = VerifyCode();

  Future<void> verifyCode() async {
    try {
      loader.value = true;
      await VerifyCodeApi.advertiserVerifyCode(verifyController.text)
          .then((value) => verifyCodeModel = value!);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  AdHomeController adHomeController = Get.put(AdHomeController());

  Future<void> phoneNumberRegister() async {
    try {
      loader.value = true;
      // await PhoneNumberApi.advertiserSendOtp(phoneNumber == ""
      //     ? PrefService.getString(PrefKeys.phonSaveNumberAdvertiser).toString()
      //     : phoneNumber);

      await PhoneNumberApi.advertiserSendOtp(adHomeController.viewAdvertiserModel.data!.email.toString());

      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future startTimer() async {
    seconds = 60;
    update(['count_timer']);
    const oneSec = Duration(seconds: 1);
    _countDown = Timer.periodic(
      oneSec,
      (timer) {
        if (seconds == 0) {
          _countDown!.cancel();
          timer.cancel();
          update(['count_timer']);
          update(["time"]);
        } else {
          seconds--;
          update(['count_timer']);
        }
      },
    );
    update(['count_timer']);
  }
}

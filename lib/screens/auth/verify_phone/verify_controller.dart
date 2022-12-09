import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/screens/auth/verify_phone/verifyPhone_api/verify_phone_json.dart';
import 'package:rainbow_new/screens/auth/verify_phone/verifyPhone_api/verifyphone_api.dart';
import 'package:rainbow_new/utils/strings.dart';

class VerifyPhoneController extends GetxController {
  TextEditingController verifyController = TextEditingController();
  RxBool loader = false.obs;
  Timer? _countDown;
  int seconds = 60;
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
      await VerifyCodeApi.postRegister(verifyController.text)
          .then((value) => verifyCodeModel = value!);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }
/* Future<void> phoneNumberRegister() async {
    try {
      loader.value = true;
      await PhoneNumberApi.postRegister(
          "+${countryModel.phoneCode + phoneNumber.text}")
          .then((value) => phoneNumberModel = value);
      await PrefService.setValue(
          PrefKeys.id, phoneNumberModel.data!.id.toString());
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }*/

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
          update(["time"]);
        }
      },
    );
    update(['count_timer']);
    update(["time"]);
  }
}

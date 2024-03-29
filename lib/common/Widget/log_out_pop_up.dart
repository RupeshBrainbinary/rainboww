import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/settings/logOut_Api/log_out_api.dart';

import 'package:rainbow_new/screens/Home/settings/payment/payment_controller.dart';
import 'package:rainbow_new/screens/Home/settings/settings_controller.dart';
import 'package:rainbow_new/screens/account_Information/account_information_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/ad_dashboard.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/advertisement_controlle.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/widget/advertisement_list.dart';

import 'package:rainbow_new/screens/auth/auth_dashboard/auth_dashboard.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

logoutPopup({required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "Logout",
            style: gilroySemiBoldTextStyle(fontSize: 18, color: Colors.black),
          ),
          content: Text(
            "Do you want to logout ?",
            style: gilroyMediumTextStyle(fontSize: 14, color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
              height: 20,
              width: 0.5,
              color: Colors.grey,
            ),
            GetBuilder<SettingsController>(
              id: "setting",
              builder: (controller) {
                return TextButton(
                  child: const Text('yes'),
                  onPressed: () async {
                    /* HomeController homeController = Get.put(HomeController());

                  await homeController.viewProfileApi();*/
/*

                  ViewProfile viewProfile = ViewProfile();

                  TestimonialsList tes = TestimonialsList();

                  viewProfile.data = null;
                  tes.id = null;
                  tes.createdAt = null;
                  tes.testimonial = null;
                  tes.userSender = null;
*/
                    SettingsController controller =
                        Get.put(SettingsController());

                    controller.loader.value = true;

                    PaymentController paymentController =
                        Get.put(PaymentController());
                    paymentController.listCardModel.data = [];
                    paymentController.transactionModel.data = [];

                    Navigator.of(context).pop();
                    await controller.logOutDetails();

                    PrefService.clear();
                    controller.loader.value = false;
                  },
                );
              },
            ),
          ],
        );
      });
}

deletePopup({required BuildContext context}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "Delete account successfully",
            style: gilroySemiBoldTextStyle(fontSize: 18, color: Colors.black),
          ),
          content: Text(
            "Your account will delete in 24 hours",
            style: gilroyMediumTextStyle(fontSize: 14, color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
              height: 20,
              width: 0.5,
              color: Colors.grey,
            ),
            GetBuilder<SettingsController>(
              id: "setting",
              builder: (controller) {
                return TextButton(
                  child: const Text('yes'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Get.offAll(AuthDashboard());
                  },
                );
              },
            ),
          ],
        );
      });
}

deletePopupAdvertise({required BuildContext context, required GlobalKey<ScaffoldState> key}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "Delete account successfully",
            style: gilroySemiBoldTextStyle(fontSize: 18, color: Colors.black),
          ),
          content: Text(
            "Your account will delete in 24 hours",
            style: gilroyMediumTextStyle(fontSize: 14, color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
            Container(
              height: 20,
              width: 0.5,
              color: Colors.grey,
            ),
            GetBuilder<SettingsController>(
              id: "setting",
              builder: (controller) {
                return TextButton(
                  child: const Text('yes'),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    Get.offAll(AuthDashboard());
                  },
                );
              },
            ),
          ],
        );
      });
}

logoutPopupAdvertise(
    {required BuildContext context, required GlobalKey<ScaffoldState> key}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.white,
          title: Text(
            "Logout",
            style: gilroySemiBoldTextStyle(fontSize: 18, color: Colors.black),
          ),
          content: Text(
            "Do you want to logout ?",
            style: gilroyMediumTextStyle(fontSize: 14, color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
              height: 20,
              width: 0.5,
              color: Colors.grey,
            ),
            TextButton(
              child: const Text('yes'),
              onPressed: () async {
                //await PrefService.clear();

                //Get.offAndToNamed("/AuthDashboard");

                //Get.offNamed("/AuthDashboard");
                //Get.offNamedUntil("/AuthDashboard");
                // Get.deleteAll();
                Get.back();
                key.currentState!.closeDrawer();
                AdvertisementController advertisementController =
                    Get.put(AdvertisementController());
                AdHomeController adHomeController = Get.put(AdHomeController());
                adHomeController.loader.value = true;
                advertisementController.update(['settings']);
                await LogOutApi.postRegister();
                adHomeController.loader.value = false;

                advertisementController.update(['settings']);
                // Get.offAll(() => AuthDashboard());

                //Get.reset();
                PrefService.setValue(PrefKeys.userId, "");
                PrefService.setValue(PrefKeys.accessToken, "");
                PrefService.setValue(PrefKeys.skipBoardingScreen, true);
                //AdHomeController adHomeController = AdHomeController();
                // adHomeController.myAdvertiserModel.data = null;
                PaymentController paymentController =
                    Get.put(PaymentController());
                Get.deleteAll();
                //adHomeController.viewAdvertiserModel.data!.profileImage = '';
                AccountInformationController accountController =
                    AccountInformationController();
                accountController.imagePath = null;
                //accountController.update(["Getpic"]);
                paymentController.listCardModel.data = [];
                paymentController.transactionModel.data = [];
                AdHomeController adHomecon = Get.put(AdHomeController());

                /*adHomecon.onClose();
                adHomecon.page = 0;
                adHomecon.myAdList = [];*/
              },
            ),
          ],
        );
      });
  /*return showDialog(context: context, builder: (BuildContext context){
    return Padding(
      padding: EdgeInsets.only(top: 240, left: 40, right: 40, bottom: 240),
      child: Container(
        //height: Get.height / 4,
        width: Get.width / 1.3,
        decoration: BoxDecoration(
          color: ColorRes.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            const SizedBox(
              width: 130,
              child: Text(
                "Subscribe to our Premium Version",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: FontRes.gilroySemiBold,
                    color: ColorRes.appBlack,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "£9.99",
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w100,
                    color: ColorRes.appBlack,
                    fontFamily: FontRes.gilroySemiBold,
                  ),
                ),
                Text(
                  "/",
                  style: TextStyle(color: ColorRes.appBlack, fontSize: 35),
                ),
                Text(
                  "month",
                  style: TextStyle(
                    fontSize: 35,
                    color: ColorRes.appBlack,
                    fontFamily: FontRes.gilroySemiBold,
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Get.to(PaymentScreen());
                subscribePopUp = false;
              },
              child: Container(
                height: Get.height / 18,
                width: Get.width / 2.5,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        ColorRes.colorB279DB,
                        ColorRes.color_4F359B,
                      ],
                    )),
                child: const Text(
                  "Subscribe",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: FontRes.gilroySemiBold,
                      color: ColorRes.white),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  });*/
}

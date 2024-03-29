// ignore_for_file: sort_child_properties_last

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/buttons.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/log_out_pop_up.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/screens/Home/settings/payment/payment_screen.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/advertisement_controlle.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/change_password/advertiser_verify_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_dashboard/change_password/advertiser_verify_otp_screen.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_screen.dart';
import 'package:rainbow_new/screens/advertisement/ad_notification/ad_notification_screen.dart';
import 'package:rainbow_new/screens/advertisement/ad_support/ad_support_screen.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class AdvertisementDashBord extends StatefulWidget {
  AdvertisementDashBord({Key? key}) : super(key: key);

  @override
  State<AdvertisementDashBord> createState() => _AdvertisementDashBordState();
}

class _AdvertisementDashBordState extends State<AdvertisementDashBord> {
  final AdvertisementController advertisementController =
      Get.put(AdvertisementController());
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
   AdHomeController adHomeController = Get.put(AdHomeController());
  @override
  void initState() {
    super.initState();
// adHomeController. refreshCode();
    drawerKey = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvertisementController>(
        id: "bottom_bar",
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              if (controller.currentTab == 0) {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Are you sure you want exit app",
                          style: gilroyBoldTextStyle(
                              fontSize: 20, color: Colors.black),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text(
                              "No",
                              style: gilroyBoldTextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          TextButton(
                            child: Text(
                              "Yes",
                              style: gilroyBoldTextStyle(
                                  fontSize: 18, color: Colors.black),
                            ),
                            onPressed: () {
                              SystemNavigator.pop();
                            },
                          )
                        ],
                      );
                    });
              } else {
                controller.onBottomBarChange(0);
              }
              return false;
            },
            child: Scaffold(
              key: drawerKey,
              drawer: GetBuilder<AdvertisementController>(
                  id: "settings",
                  builder: (controller) {
                    return Stack(
                      children: [
                        Drawer(
                          backgroundColor: ColorRes.white,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: Get.height * 0.0775,
                                left: Get.width * 0.05210),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GetBuilder<AdHomeController>(
                                  id: "dashBoard",
                                  builder: (controller) {
                                    return Row(
                                      children: [
                                        adHomeController
                                                    .viewAdvertiserModel.data ==
                                                null
                                            ? const SizedBox()
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                child: adHomeController
                                                        .viewAdvertiserModel
                                                        .data!
                                                        .profileImage
                                                        .toString()
                                                        .isEmpty
                                                    ? Image.asset(
                                                        AssetRes
                                                            .portraitPlaceholder,
                                                        height:
                                                            Get.width * 0.1730,
                                                        width:
                                                            Get.width * 0.1730,
                                                      )
                                                    : CachedNetworkImage(
                                                        imageUrl: adHomeController
                                                            .viewAdvertiserModel
                                                            .data!
                                                            .profileImage
                                                            .toString(),
                                                        placeholder: ((context,
                                                                url) =>
                                                            Image.asset(AssetRes
                                                                .portraitPlaceholder)),
                                                        errorWidget: ((context,
                                                                url, error) =>
                                                            Image.asset(AssetRes
                                                                .portraitPlaceholder)),
                                                        fit: BoxFit.cover,
                                                        height:
                                                            Get.width * 0.1730,
                                                        width:
                                                            Get.width * 0.1730,
                                                      )),
                                        SizedBox(
                                          width: Get.width * 0.0255,
                                        ),
                                        Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.9,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        adHomeController
                                                                .viewAdvertiserModel
                                                                .data
                                                                ?.fullName ??
                                                            "",
                                                        style: gilroyRegularTextStyle(
                                                            fontSize: 24,
                                                            color: ColorRes
                                                                .color_09110E),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              /*Text(
                                            adHomeController.viewAdvertiserModel.data
                                                ?.fullName ??
                                                "",
                                            style: gilroyRegularTextStyle(
                                                fontSize: 24,
                                                color: ColorRes.color_09110E),
                                          ),*/
                                              SizedBox(
                                                height: Get.height * 0.0086,
                                              ),
                                              Text(
                                                adHomeController
                                                        .viewAdvertiserModel
                                                        .data
                                                        ?.email ??
                                                    "",
                                                style: gilroyBoldTextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        ColorRes.color_09110E),
                                              )
                                            ]),
                                        const Spacer(),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                drawerKey.currentState!
                                                    .closeDrawer();
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Get.width * 0.0293,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: ColorRes.black,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: Get.height * 0.0555,
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: Get.height * 0.0467,
                                ),

                                ///Change Password
                                GetBuilder<AdHomeController>(
                                    id: "network",
                                    builder: (controller) {
                                      adHomeController.checkUserConnection();
                                      return InkWell(
                                        onTap:
                                            adHomeController.activeConnection ==
                                                    false
                                                ? () {
                                                    errorToast(
                                                        "No internet connection");
                                                    adHomeController
                                                        .update(["network"]);
                                                  }
                                                : () {
                                                    AdvertiserVerifyController
                                                        adController = Get.put(
                                                            AdvertiserVerifyController());

                                                    adController.backScreen =
                                                        'AdvertisementDashBord';
                                                    // adController.startTimer();
                                                    adController
                                                        .phoneNumberRegister();
                                                    Get.to(() =>
                                                            const AdvertiserVerifyOtpScreen())!
                                                        .then((value) =>
                                                            adHomeController
                                                                .checkUserConnection());
                                                  },
                                        child: SizedBox(
                                          height: Get.height * 0.06,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                AssetRes.lockicon,
                                                width: Get.width * 0.04706,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.0853,
                                              ),
                                              Text(
                                                Strings.changePassword,
                                                style: gilroyMediumTextStyle(
                                                  fontSize: 16,
                                                  color: ColorRes.color_09110E,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                //Account Information
                                GetBuilder<AdHomeController>(
                                    id: "network",
                                    builder: (controller) {
                                      adHomeController.checkUserConnection();
                                      return InkWell(
                                        onTap:
                                            adHomeController.activeConnection ==
                                                    false
                                                ? () => errorToast(
                                                    "No internet connection")
                                                : () => advertisementController
                                                    .inTapAccountInfo(),
                                        child: SizedBox(
                                          height: Get.height * 0.06,
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                AssetRes.profileicon,
                                                width: Get.width * 0.04706,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.0853,
                                              ),
                                              Text(
                                                Strings.accountInformation,
                                                style: gilroyMediumTextStyle(
                                                  fontSize: 16,
                                                  color: ColorRes.color_09110E,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                // Notification
                                GetBuilder<AdvertisementController>(
                                  id: 'settings',
                                  builder: (controller) => InkWell(
                                    onTap: controller.notification,
                                    child: SizedBox(
                                      height: Get.height * 0.06,
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            AssetRes.notificationicon,
                                            color: ColorRes.colorEDB933,
                                            width: Get.width * 0.04706,
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.0853,
                                          ),
                                          Text(
                                            Strings.notification,
                                            style: gilroyMediumTextStyle(
                                              fontSize: 16,
                                              color: ColorRes.color_09110E,
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: Get.width * 0.09066,
                                            height: Get.height * 0.02545,
                                            child: Transform.scale(
                                              scale: .7,
                                              child: CupertinoSwitch(
                                                value: controller.isSwitched!,
                                                onChanged: adHomeController
                                                            .activeConnection ==
                                                        false
                                                    ? (value) {
                                                        errorToast(
                                                            "No internet connection");
                                                      }
                                                    : (value) {
                                                        controller.isSwitched =
                                                            value;
                                                        controller
                                                            .notificationOnOffApi();
                                                        controller.update(
                                                            ["settings"]);
                                                      },
                                                activeColor:
                                                    ColorRes.colorCE8CEC,
                                                trackColor:
                                                    Colors.grey.shade300,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.0483)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: Get.width * 0.0498),
                                  child: SubmitButton(
                                    onTap: () =>
                                        logoutPopupAdvertise(context: context,key :drawerKey),
                                    child: Row(
                                      children: [
                                        const Spacer(),
                                        Image.asset(
                                          AssetRes.logouticon,
                                          height: 22,
                                        ),
                                        const SizedBox(
                                          width: 26,
                                        ),
                                        Text(
                                          Strings.logout02,
                                          style: gilroyBoldTextStyle(
                                              fontSize: 16,
                                              color: ColorRes.black),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.0265,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: Get.width * 0.0498),
                                  child: SubmitButton(
                                    onTap: () =>
                                        deletePopupAdvertise(context: context,key :drawerKey),
                                    child: Text(
                                      Strings.deleteAccount,
                                      style: gilroyBoldTextStyle(
                                          fontSize: 16,
                                          color: ColorRes.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.0665,
                                )
                              ],
                            ),
                          ),
                          width: Get.width - (Get.width * 0.0853),
                        ),
                        controller.loader.value == true
                            ? const FullScreenLoader()
                            : const SizedBox(),
                      ],
                    );
                  }),
              backgroundColor: ColorRes.white,
              body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      ColorRes.color_50369C,
                      ColorRes.colorD18EEE,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: GetBuilder<AdvertisementController>(
                  id: 'bottom_bar',
                  builder: (controller) {
                    if (controller.currentTab == 0) {
                      return AdHomeScreen(
                        drawerKey: drawerKey,
                      );
                    } else if (controller.currentTab == 1) {
                      return PaymentScreen(
                        showBackArrow: false,
                      );
                      // const AdPaymentScreen();
                    } else if (controller.currentTab == 2) {
                      return AdNotificationsScreen();
                    } else if (controller.currentTab == 3) {
                      return AdSupportScreen();
                    } else {
                      return AdHomeScreen(
                        drawerKey: drawerKey,
                      );
                    }
                  },
                ),
              ),
              bottomNavigationBar: GetBuilder<AdHomeController>(
                  id: "network",
                  builder: (adHomeController) {
                    adHomeController.checkUserConnection();
                    return GetBuilder<AdvertisementController>(
                      id: 'bottom_bar',
                      builder: (_) => SalomonBottomBar(
                        margin: const EdgeInsets.all(12),
                        selectedItemColor: ColorRes.color_2F80ED,
                        unselectedItemColor: ColorRes.color_9597A1,
                        currentIndex: advertisementController.currentTab,
                        onTap: adHomeController.activeConnection == false
                            ? (i) {
                                errorToast("No internet connection");
                              }
                            : (i) =>
                                advertisementController.onBottomBarChange(i),
                        items: [
                          /// Home
                          SalomonBottomBarItem(
                            icon: Image.asset(
                              AssetRes.home,
                              height: 16,
                              color: advertisementController.currentTab == 0
                                  ? ColorRes.color_2F80ED
                                  : ColorRes.color_9597A1,
                            ),
                            title: Text(
                              "Home",
                              style: gilroyBoldTextStyle(
                                  color: ColorRes.color_2F80ED, fontSize: 14),
                            ),
                          ),

                          /// search
                          SalomonBottomBarItem(
                            icon: Image.asset(
                              AssetRes.paymentIcon,
                              height: 16,
                              color: advertisementController.currentTab == 1
                                  ? ColorRes.color_2F80ED
                                  : ColorRes.color_9597A1,
                            ),
                            title: Text(
                              "Payment",
                              style: gilroyBoldTextStyle(
                                  color: ColorRes.color_2F80ED, fontSize: 14),
                            ),
                          ),

                          /// message
                          SalomonBottomBarItem(
                            icon: Image.asset(
                              AssetRes.adeNotificationIcon,
                              height: 20,
                              color: advertisementController.currentTab == 2
                                  ? ColorRes.color_2F80ED
                                  : ColorRes.color_9597A1,
                            ),
                            title: Text(
                              "Notification",
                              style: gilroyBoldTextStyle(
                                  color: ColorRes.color_2F80ED, fontSize: 14),
                            ),
                          ),

                          /// support
                          SalomonBottomBarItem(
                            icon: Image.asset(
                              AssetRes.supportIcon,
                              height: 16,
                              color: advertisementController.currentTab == 3
                                  ? ColorRes.color_2F80ED
                                  : ColorRes.color_9597A1,
                            ),
                            title: Text(
                              "Support",
                              style: gilroyBoldTextStyle(
                                  color: ColorRes.color_2F80ED, fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          );
        });
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/log_out_pop_up.dart';
import 'package:rainbow_new/common/Widget/premiumPopUpBox/premium_pop_up_box.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/home_controller.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_controller.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_screen.dart';
import 'package:rainbow_new/screens/Home/settings/payment/payment_controller.dart';
import 'package:rainbow_new/screens/Home/settings/payment/payment_screen.dart';
import 'package:rainbow_new/screens/Home/settings/settings_controller.dart';
import 'package:rainbow_new/screens/Home/settings/subscription/subscription_screen.dart';

import 'package:rainbow_new/screens/Message/message_controller.dart';
import 'package:rainbow_new/screens/Message/message_screen.dart';
import 'package:rainbow_new/screens/Profile/profile_controller.dart';
import 'package:rainbow_new/screens/Profile/profile_screen.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  final SettingsController controller = Get.put(SettingsController());
  final ProfileController profileController = Get.put(ProfileController());
  final HomeController homeController = Get.put(HomeController());
  final MessageController messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
/*    controller.notification();*/
    controller.getRefferralsCode();
    return Scaffold(
      body: GetBuilder<SettingsController>(
        id: "settings",
        builder: (controller) {
          return Obx(() {
            return Container(
              width: Get.width,
              padding: const EdgeInsets.only(bottom: 5),
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
              child: Stack(
                children: [
                  Column(
                    children: [
                      appBar(context),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              profile(),
                              settingsProperties(context: context),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  controller.loader.isTrue
                      ? const FullScreenLoader()
                      : const SizedBox()
                ],
              ),
            );
          });
        },
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Container(
      width: Get.width,
      color: ColorRes.color_4F359B,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.05),
                  child: Container(
                    height: 25,
                    width: 35,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(AssetRes.backIcon),
                    ),
                    // decoration: const BoxDecoration(
                    //     image: DecorationImage(
                    //   image: AssetImage(
                    //     AssetRes.backIcon,
                    //   ),
                    // )),
                  ),
                ),
              ),
              Center(
                child: Text(
                  Strings.others,
                  style: gilroyBoldTextStyle(),
                ),
              ),
            ],
          ),
          SizedBox(
            height: Get.height * 0.04,
          ),
        ],
      ),
    );
  }

  Widget profile() {
    return Container(
      height: 97,
      width: Get.width,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.only(left: Get.width * 0.08),
            child: Row(
              children: [
                (profileController.viewProfile.data?.profileImage?.toString() ??
                            "")
                        .isEmpty
                    ? Container(
                        height: 56,
                        width: 56,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image:
                                    AssetImage(AssetRes.portraitPlaceholder))),
                      )
                    : SizedBox(
                        height: 56,
                        width: 56,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: profileController
                                .viewProfile.data!.profileImage!
                                .toString(),
                            fit: BoxFit.cover,
                            errorWidget: ((context, url, error) =>
                                Image.asset(AssetRes.portraitPlaceholder)),
                            placeholder: (context, url) =>
                                Image.asset(AssetRes.portraitPlaceholder),
                          ),
                        ),
                      ),
                const SizedBox(
                  width: 20,
                ),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          profileController.viewProfile.data?.fullName ?? "",
                          style: gilroyBoldTextStyle(
                              color: Colors.black, fontSize: 26),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(() => ProfileScreen(
                                      i: 2,
                                    ))!
                                .then((value) async {
                              await profileController.viewProfileDetails();
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 15.35,
                                width: 15.35,
                                child: Image.asset(
                                  AssetRes.profileSettinges,
                                  color: ColorRes.color_4F359B,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                Strings.viewProfile,
                                style: gilroyBoldTextStyle(
                                    fontSize: 15, color: ColorRes.color_4F359B),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget settingsProperties({context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: Get.height * 0.025,
        ),
        //Messages
        InkWell(
          onTap: () async {
            await messageController.init();

            homeController.viewProfile.data?.userType == "free"
                ? premiumPopUpBox(context: context)
                : Get.to(() => MessageScreen(
                      backArrow: true,
                    ));
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.08,
                ),
                SizedBox(
                    height: 18.98,
                    width: 20.83,
                    child: Image.asset(AssetRes.messages)),
                SizedBox(
                  width: Get.width * 0.06,
                ),
                Text(
                  Strings.messages,
                  style: textStyleFont15White,
                ),
                const Spacer(),
                SizedBox(
                    height: 10, width: 6, child: Image.asset(AssetRes.next)),
                const SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ColorRes.color_4F359B.withOpacity(0.4),
        ),
        //Connections
        InkWell(
          onTap: () {
            ConnectionsController connectionController =
                Get.put(ConnectionsController());
            connectionController.init();
            homeController.viewProfile.data?.userType == "free"
                ? premiumPopUpBox(context: context)
                : Get.to(() => ConnectionsScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.08,
                ),
                SizedBox(
                    height: 18.98,
                    width: 20.83,
                    child: Image.asset(AssetRes.connections)),
                SizedBox(
                  width: Get.width * 0.06,
                ),
                Text(
                  Strings.connections,
                  style: textStyleFont15White,
                ),
                const Spacer(),
                SizedBox(
                    height: 10, width: 6, child: Image.asset(AssetRes.next)),
                const SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ColorRes.color_4F359B.withOpacity(0.4),
        ),
        //Support
        InkWell(
          onTap: () {
            homeController.viewProfile.data?.userType == "free"
                ? premiumPopUpBox(context: context)
                : controller.onTapSupport();
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.08,
                ),
                SizedBox(
                    height: 18.98,
                    width: 20.83,
                    child: Image.asset(AssetRes.support)),
                SizedBox(
                  width: Get.width * 0.06,
                ),
                Text(
                  Strings.support,
                  style: textStyleFont15White,
                ),
                const Spacer(),
                SizedBox(
                    height: 10, width: 6, child: Image.asset(AssetRes.next)),
                const SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ColorRes.color_4F359B.withOpacity(0.4),
        ),
        //payment
        InkWell(
          onTap: () {
            PaymentController controller = Get.put(PaymentController());
            controller.transactionPageModel.clear();
            controller.page = 1;
            controller.transactionApiPagination();
            Get.to(() => PaymentScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.08,
                ),
                SizedBox(
                    height: 18.98,
                    width: 20.83,
                    child: Image.asset(AssetRes.payment)),
                SizedBox(
                  width: Get.width * 0.06,
                ),
                Text(
                  Strings.payment,
                  style: textStyleFont15White,
                ),
                const Spacer(),
                SizedBox(
                    height: 10, width: 6, child: Image.asset(AssetRes.next)),
                const SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ColorRes.color_4F359B.withOpacity(0.4),
        ),
        //Privacy
        InkWell(
          onTap: controller.onPrivacyScreenTap,
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.08,
                ),
                SizedBox(
                    height: 18.98,
                    width: 20.83,
                    child: Image.asset(
                      AssetRes.profileSettinges,
                      color: Colors.yellow,
                    )),
                SizedBox(
                  width: Get.width * 0.06,
                ),
                Text(
                  Strings.privacy,
                  style: textStyleFont15White,
                ),
                const Spacer(),
                SizedBox(
                    height: 10, width: 6, child: Image.asset(AssetRes.next)),
                const SizedBox(
                  width: 25,
                )
              ],
            ),
          ),
        ),
        Divider(
          thickness: 1,
          color: ColorRes.color_4F359B.withOpacity(0.4),
        ),
        //notification
        Row(
          children: [
            SizedBox(
              width: Get.width * 0.08,
            ),
            SizedBox(
                height: 18.98,
                width: 20.83,
                child: Image.asset(
                  AssetRes.adeNotificationIcon,
                  color: Colors.yellow,
                )),
            SizedBox(
              width: Get.width * 0.06,
            ),
            Text(
              Strings.notifications,
              style: textStyleFont15White,
            ),
            SizedBox(
              width: Get.width * 0.395,
            ),

            /// Notification
            GetBuilder<SettingsController>(
              id: "switch",
              builder: (controller) {
                return Transform.scale(
                  scale: 0.7,
                  child: CupertinoSwitch(
                    value: controller.isSwitched!,
                    onChanged: (value) {
                      controller.isSwitched = value;
                      controller.notificationOnOffApi();
                      controller.update(["switch"]);
                    },
                    activeColor: Colors.yellow,
                    trackColor: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: ColorRes.color_4F359B.withOpacity(0.4),
        ),
        //Subscription
        InkWell(
          onTap: () {
            homeController.viewProfile.data?.userType == "free"
                ? premiumPopUpBox(context: context)
                : Get.to(() => SubscriptionScreen());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 5, bottom: 5),
            child: Row(
              children: [
                SizedBox(
                  width: Get.width * 0.08,
                ),
                SizedBox(
                    height: 18.98,
                    width: 20.83,
                    child: Image.asset(
                      AssetRes.profileSettinges,
                      color: Colors.yellow,
                    )),
                SizedBox(
                  width: Get.width * 0.06,
                ),
                Text(
                  Strings.subscription,
                  style: textStyleFont15White,
                ),
                SizedBox(
                  width: Get.width * 0.5,
                ),
                SizedBox(
                    height: 10, width: 6, child: Image.asset(AssetRes.next))
              ],
            ),
          ),
        ),
        SizedBox(
          height: Get.height * 0.03,
        ),
       ///ReferralCode
       /* Text(
          Strings.yourReferralCode,
          style: textStyleFont15White,
        ),
        SizedBox(
          height: Get.height * 0.01,
        ),
        Text(
          controller.refferalCode.toString(),
          style: gilroyBoldTextStyle(fontSize: 32),
        ),
        SizedBox(
          height: Get.height * 0.02,
        ),
        InkWell(
          onTap: () {
            controller.share();
          },
          child: Container(
            height: 44.43,
            width: Get.width * 0.312,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.67),
                color: ColorRes.color_6306B2),
            child: Center(
                child: Text(
              Strings.inviteNow,
              style: gilroyBoldTextStyle(fontSize: 11.9619),
            )),
          ),
        ),*/
        SizedBox(
          height: Get.height * 0.045,
        ),
        GestureDetector(
          onTap: () async {
            //controller.logOutDetails();
            deletePopup(context: context);
          },
          child: Container(
            alignment: Alignment.center,
            height: 60,
            width: Get.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.67),
                color: ColorRes.colorFFEC5C),
            child: Text(Strings.deleteAccount,
                style: gilroyMediumTextStyle(
                    color: Colors.black, fontSize: 16)),
          ),
        ),
        SizedBox(
          height: Get.height * 0.025,
        ),
        GestureDetector(
          onTap: () async {
            //controller.logOutDetails();
            logoutPopup(context: context);
          },
          child: Container(
            height: 60,
            width: Get.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.67),
                color: ColorRes.colorFFEC5C),
            child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        height: 15, width: 15, child: Image.asset(AssetRes.logout)),
                    const SizedBox(
                      width: 11,
                    ),
                    Text(Strings.logout,
                        style: gilroyMediumTextStyle(
                            color: Colors.black, fontSize: 16)),
                  ],
                )),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}

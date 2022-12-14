import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/premiumPopUpBox/premium_pop_up_box.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/home_controller.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_controller.dart';
import 'package:rainbow_new/screens/Profile/profile_controller.dart';

import 'package:rainbow_new/screens/Profile/widget/edit_profile/edit_profile_contoller.dart';
import 'package:rainbow_new/screens/Profile/widget/edit_profile/edit_profile_screen.dart';

import 'package:rainbow_new/screens/notification/notification_controller.dart';
import 'package:rainbow_new/screens/notification/notification_screen.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';

ConnectionsController controller = Get.put(ConnectionsController());
HomeController homeController = Get.put(HomeController());
ProfileController profileController = Get.put(ProfileController());

Widget profileAppbar(
    String text,
    bool show,
    bool show2,
    context,
    int i,
    VoidCallback? onTap,
    {VoidCallback? onTap2}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10, left: 18.50, right: 18.50),
    child: Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 3),
          width: Get.width - 38,
          alignment: Alignment.center,
          child: Text(
            text,
            style: gilroyBoldTextStyle(fontSize: 18),
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: () {

               if(show2 == true){
                 Get.back();
               }
               else{
                 if (i == 2) {
                   if (onTap2 == null) {
                     Navigator.of(context).pop();
                   } else {
                     profileController.screen.value = false;
                     profileController.viewProfileDetails();
                     i=1;
                   }
                 } else if (i == 1) {
                   onTap!();
                 }
               }

              },
              child: Image.asset(
                AssetRes.backIcon,
                height: 16,width: 35,
              ),
            ),
            const Spacer(),
            show
                ? GetBuilder<HomeController>(builder: (controller) {
                  return InkWell(
                    onTap: () {
                      EditProfileController editController =
                      Get.put(EditProfileController());
                      editController.init();
                      controller.viewProfile.data?.userType == "free"
                          ? premiumPopUpBox(context: context)
                          : Get.to(() => const EditProfileScreen());
                      //Get.to(() => const EditProfileScreen());
                    },
                    child: SizedBox(
                      height: 31,
                      width: 31,
                      child: Image.asset(AssetRes.editIcon),
                    ),
                  );
                },)
                : const SizedBox(),
            const SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                NotificationsController notificationController =
                    Get.put(NotificationsController());
                notificationController.init();
                homeController.viewProfile.data?.userType == "free"
                    ? premiumPopUpBox(context: context)
                    : Get.to(() => NotificationScreen());
              },
              child: Stack(
                children: [
                  const SizedBox(
                    height: 30,
                    width: 30,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Image.asset(AssetRes.notificationIcon),
                    ),
                  ),
                  (controller.requestUsers.length.toString() == '0')
                      ? const SizedBox()
                      : Positioned(
                          top: 0,
                          right: 0,
                          child: GetBuilder<NotificationsController>(
                            id: 'notification_badge',
                            builder: (notificationController) {
                              return Container(
                                height: 16,
                                width: 16,
                                alignment: Alignment.center,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ColorRes.colorFF6B97),
                                child: Text(
                                  controller.requestUsers.length.toString(),
                                  style: const TextStyle(
                                    color: ColorRes.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

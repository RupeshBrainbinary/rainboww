import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/model/notification_model.dart';

import 'package:rainbow_new/screens/Home/settings/connections/connections_profile/connections_profile_controller.dart';
import 'package:rainbow_new/screens/Profile/profile_controller.dart';
import 'package:rainbow_new/screens/notification/notification_controller.dart';
import 'package:rainbow_new/utils/color_res.dart';

import '../../../common/Widget/text_styles.dart';
import '../../../utils/asset_res.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({Key? key}) : super(key: key);
  final NotificationsController controller = Get.put(NotificationsController());
  final ProfileController profileController = Get.put(ProfileController());
  final ConnectionsProfileController connectionsProfileController =
      Get.put(ConnectionsProfileController());

  @override
  Widget build(BuildContext context) {
    controller.notificationReadApi();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorRes.color_50369C,
                  ColorRes.color_50369C,
                  ColorRes.colorD18EEE,
                  ColorRes.colorD18EEE,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              children: [
                appBar(),
                (controller.notificationList.length == 0)
                    ? SizedBox(
                        height: Get.height * 0.7,
                        child: Center(
                          child: Text("Notification not available",
                              style: gilroyMediumTextStyle(
                                  fontSize: 16, color: Colors.white)),
                        ),
                      )
                    : GetBuilder<NotificationsController>(id: "Notification",
                  builder: (controller) {
                      return Expanded(
                        child: ListView.builder(padding: EdgeInsets.zero,
                          itemCount: controller.notificationList.length,
                          itemBuilder: (BuildContext context, int index) {
                            NotificationData model =
                            controller.notificationList[index];
                            return Column(
                              children: [
                                SizedBox(
                                  height: 100,
                                  width: Get.width,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Get.width * 0.05,
                                        right: Get.width * 0.16),
                                    child: InkWell(
                                      onTap: () {
                                        /* connectionsProfileController.callApi(
                                      controller.notificationList[index]
                                          .idUserSender
                                          .toString());*/

                                        /*(controller.notificationList[index].type.toString() == "Post")
                                      ? Get.to(HomeScreen())
                                      :
                                  );*/
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 54,
                                            width: 54,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: ColorRes.white,
                                                  width: 1),
                                            ),
                                            child: profileController
                                                .viewProfile.data ==
                                                null ||
                                                profileController
                                                    .viewProfile
                                                    .data!
                                                    .profileImage!
                                                    .isEmpty
                                                ? ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50),
                                              child: Container(
                                                height: 53,
                                                width: 53,
                                                decoration:
                                                const BoxDecoration(
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        AssetRes
                                                            .portraitPlaceholder,
                                                      ),
                                                      fit: BoxFit.cover),
                                                ),
                                              ),
                                            )
                                                : ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(
                                                  50),
                                              child: SizedBox(
                                                height: 53,
                                                width: 53,
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                  profileController
                                                      .viewProfile
                                                      .data!
                                                      .profileImage
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  placeholder: ((context,
                                                      url) =>
                                                      Image.asset(
                                                        AssetRes
                                                            .portraitPlaceholder,
                                                        height: 53,
                                                        width: 53,
                                                        fit: BoxFit.cover,
                                                      )),
                                                  errorWidget: ((context,
                                                      url, error) =>
                                                      Image.asset(
                                                        AssetRes
                                                            .portraitPlaceholder,
                                                        height: 53,
                                                        width: 53,
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 35,
                                                ),
                                                Text(
                                                  model.createdAt == null
                                                      ? ''
                                                      : DateFormat('dd/MM/yyyy')
                                                      .format(
                                                      model.createdAt!),
                                                  style:
                                                  gilroySemiBoldTextStyle(
                                                      fontSize: 12),
                                                ),
                                                Text(
                                                  model.description
                                                      ?.toString() ??
                                                      "",
                                                  style: gilroyMediumTextStyle(
                                                      fontSize: 14,
                                                      letterSpacing: -0.03),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Divider(
                                  height: 1,
                                  color: ColorRes.white.withOpacity(0.5),
                                )
                              ],
                            );
                          },
                        ),
                      );
                    },),
              ],
            ),
          ),
          Obx(() {
            if (controller.loader.isTrue) {
              return const FullScreenLoader();
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          SizedBox(height: 40),
          Stack(
            children: [
              Center(
                child: Text(
                  "Notification",
                  style: gilroyBoldTextStyle(),
                ),
              ),
              Positioned(
                left: Get.height * 0.03,
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    AssetRes.backIcon,
                    height: 16,
                    width: 35,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/settings/support/support_controller.dart';
import 'package:rainbow_new/screens/Profile/profile_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_support/screen/support_create/support_create_screen.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({Key? key}) : super(key: key);
  final SupportController controller = Get.put(SupportController());
  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    controller.getListOfUserTicket();
    return Scaffold(
      body: GetBuilder<SupportController>(
        id: "Support",
        builder: (controller) {
          return Container(
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
            child: Obx(() {
              return Stack(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: Get.height * 0.035,
                          ),
                          appBar(),
                        ],
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              supports(),
                              SizedBox(
                                height: Get.height * 0.07,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      sendNewMessage(),
                      SizedBox(
                        height: Get.height * 0.02,
                      ),
                    ],
                  ),
                  controller.loader.isTrue
                      ? const FullScreenLoader()
                      : const SizedBox()
                ],
              );
            }),
          );
        },
      ),
    );
  }

  Widget appBar() {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: Get.height * 0.03,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.05,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 22,
                  width: 22,

                  padding : EdgeInsets.all(3),
                  child: Image.asset(
                    AssetRes.backIcon,


                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.31,
              ),
              Text(
                Strings.support,
                style: gilroyBoldTextStyle(),
              ),
              SizedBox(
                width: Get.width * 0.05,
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

  Widget supports() {
    return GetBuilder<SupportController>(
      id: "Support",
      builder: (controller) {
        return Column(
          children: [
            ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.listSupportTicketModel.data == null
                  ? 0
                  : controller.listSupportTicketModel.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.onTap(
                              id: controller
                                  .listSupportTicketModel.data![index].id
                                  .toString(),
                              status: controller
                                  .listSupportTicketModel.data![index].status
                                  .toString(),
                              code: controller
                                  .listSupportTicketModel.data![index].tickit
                                  .toString());
                        },
                        child: Container(
                          height: 104,
                          width: Get.width * 0.8933,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.white),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: profileController
                                        .viewProfile.data!.profileImage!.isEmpty
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          height: 46,
                                          width: 46,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  AssetRes.portraitPlaceholder,
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: SizedBox(
                                          height: 46,
                                          width: 46,
                                          child: CachedNetworkImage(
                                            imageUrl: profileController
                                                .viewProfile.data!.profileImage
                                                .toString(),
                                            placeholder: ((context, url) =>
                                                Image.asset(
                                                  AssetRes.portraitPlaceholder,
                                                )),
                                            errorWidget: ((context, url,
                                                    error) =>
                                                Image.asset(
                                                  AssetRes.portraitPlaceholder,
                                                )),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                /* ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    profileController.viewProfile
                                        .data!.profileImage
                                        .toString(),
                                    height: Get.width * 0.144,
                                    width: Get.width * 0.144,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        AssetRes.portraitPlaceholder,
                                        height: Get.width * 0.144,
                                        width: Get.width * 0.144,
                                      );
                                    },
                                  ),
                                ),*/
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, top: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat("dd/MM/yyyy").format(controller
                                          .listSupportTicketModel
                                          .data![index]
                                          .createdAt!),
                                      style: gilroyMediumTextStyle(
                                          color: ColorRes.color_9597A1,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.listSupportTicketModel
                                          .data![index].tickit
                                          .toString(),
                                      style: gilroyMediumTextStyle(
                                          color: ColorRes.color_6306B2,
                                          fontSize: 16),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        controller.listSupportTicketModel
                                            .data![index].title
                                            .toString(),
                                        style: gilroyMediumTextStyle(
                                            color: Colors.black,
                                            fontSize: 13.11),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 55),
                                child: Text(
                                  controller.listSupportTicketModel.data![index]
                                      .status
                                      .toString(),
                                  style: controller.listSupportTicketModel
                                              .data![index].status
                                              .toString() ==
                                          "pending"
                                      ? gilroyMediumTextStyle(
                                          color: ColorRes.colorFFA800,
                                          fontSize: 16)
                                      : gilroyMediumTextStyle(
                                          color: ColorRes.color_49A510,
                                          fontSize: 16),
                                ),
                              ),
                              const SizedBox(
                                width: 18,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        );
      },
    );
  }

  Widget sendNewMessage() {
    return InkWell(
      onTap: () {
        Get.to(() => SupportcreateScreen());
      },
      child: Container(
        height: 60,
        width: 300,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13.67),
            color: ColorRes.colorFFED62),
        child: Text(
          Strings.sendNewMessage,
          style: gilroyBoldTextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
    );
  }
}

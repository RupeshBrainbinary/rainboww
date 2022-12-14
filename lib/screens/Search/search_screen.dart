import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/premiumPopUpBox/premium_pop_up_box.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/home_controller.dart';
import 'package:rainbow_new/screens/Search/search_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';

class SearchScreen extends StatelessWidget {
  final SearchController controller = Get.put(SearchController());
  final HomeController homeController = Get.put(HomeController());

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<SearchController>(
        id: "Search",
        builder: (controller) {
          return GestureDetector(
            onTap: controller.onScreenTap,
            child: Obx(() {
              return Stack(
                children: [
                  SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      children: [
                        Container(
                          color: ColorRes.white,
                          child: Column(
                            children: [
                              appBar(context: context),
                              textField(context: context),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        profile(),
                      ],
                    ),
                  ),
                  GetBuilder<SearchController>(
                    id: "Search",
                    builder: (controller) {
                      return controller.advance == true
                          ? Positioned(
                              top: Get.height * 0.105,
                              left: Get.width * 0.58,
                              child: Container(
                                height: 200,
                                width: 142,
                                padding: EdgeInsets.zero,
                                color: ColorRes.color_4F359B,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        controller.onTapAdvanceSearchMenu(index);
                                      },
                                      child: Container(
                                        width: 142,
                                        height: 37,
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            controller.advanceSearch[index]
                                                .toString(),
                                            style: gilroyBoldTextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider(
                                      thickness: 1,
                                      color: ColorRes.white,
                                      height: 2,
                                    );
                                  },
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: controller.advanceSearch.length,
                                  padding: const EdgeInsets.only(top: 0),
                                ),
                              ),
                            )
                          : const SizedBox();
                    },
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

  Widget appBar({context}) {
    return GetBuilder<SearchController>(
      id: "Search",
      builder: (controller) {
        return AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Row(
              children: [
                Text(
                  Strings.search,
                  style: gilroyBoldTextStyle(fontSize: 20, color: Colors.black),
                ),
                SizedBox(
                  width: Get.width * 0.47,
                ),
                GestureDetector(
                  onTap: () {
                    homeController.viewProfile.data?.userType == "free"
                        ? premiumPopUpBox(context: context)
                        : controller.advanceSearchOnTap();
                  },
                  child: Text(
                    Strings.advancedSearch,
                    style: gilroyBoldTextStyle(
                            fontSize: 12, color: ColorRes.color_9597A1)
                        .copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                SizedBox(
                  width: Get.width * 0.05,
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget textField({context}) {
    return Container(
      height: 56,
      width: Get.width * 0.9066,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorRes.color_9597A1.withOpacity(0.1),
      ),
      child: InkWell(
        onTap: () {
          homeController.viewProfile.data?.userType == "free"
              ? premiumPopUpBox(context: context)
              : const SizedBox();
        },
        child: Row(
          children: [
            SizedBox(
              width: Get.width * 0.04,
            ),
            const Image(
              image: AssetImage(AssetRes.search),
              color: Colors.black,
              height: 16,
              width: 16,
            ),
            SizedBox(
              width: Get.width * 0.03,
            ),
            SizedBox(
              height: 56,
              width: Get.width * 0.7,
              child: TextField(
                controller: controller.searchBar,
                obscureText: false,
                style: textFieldText,
                minLines: 1,
                onChanged: (value) => controller.runFilter(value),
                onSubmitted: (value) => controller.runFilter(value),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 6),
                  border: InputBorder.none,
                  hintStyle: textStyleFont16Grey,
                  hintText: Strings.discoverOtherConnections,
                  /*   filled: true,
                        fillColor: ColorRes.color_9597A1.withOpacity(0.1)*/
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profile() {
    return Expanded(
      child: GetBuilder<SearchController>(
        id: "Search",
        builder: (controller) {
          return ListView.builder(
            padding: const EdgeInsets.only(top: 16),
            controller: controller.scrollController,
            itemCount: controller.listUserData.length,
            // itemCount: controller.search.length,
            itemBuilder: (context, index) {
              return homeController.viewProfile.data?.userType == "free"
                  ? InkWell(
                      onTap: () {
                        premiumPopUpBox(context: context);
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              controller.listUserData[index].backgroundImage
                                          .toString() ==
                                      ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height: 232,
                                        width: Get.width * 0.90133,
                                        child: Image.asset(
                                          AssetRes.placeholderImage,
                                          height: 232,
                                          width: Get.width * 0.90133,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        controller
                                            .listUserData[index].backgroundImage
                                            .toString(),
                                        height: 232,
                                        width: Get.width * 0.90133,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            AssetRes.placeholderImage,
                                            height: 232,
                                            fit: BoxFit.cover,
                                            width: Get.width * 0.90133,
                                          );
                                        },
                                      ),
                                    ),
                              Positioned(
                                top: Get.height * 0.03,
                                left: Get.width * 0.05,
                                child: controller
                                            .listUserData[index].profileImage
                                            .toString() !=
                                        ""
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          controller
                                              .listUserData[index].profileImage
                                              .toString(),
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Image.asset(
                                                AssetRes.portraitPlaceholder,
                                                fit: BoxFit.cover,
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: SizedBox(
                                              height: 40,
                                              width: 40,
                                              child: Image.asset(
                                                AssetRes.portraitPlaceholder,
                                                fit: BoxFit.cover,
                                              ),
                                            )),
                                      ),
                              ),
                              Container(
                                  height: 232,
                                  width: Get.width * 0.90133,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorRes.color_141414.withOpacity(0.1),
                                        ColorRes.color_141414.withOpacity(0.1),
                                        ColorRes.color_141414.withOpacity(0.5),
                                        ColorRes.color_141414.withOpacity(0.8),
                                        ColorRes.color_141414
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  )),
                              Positioned(
                                  // top: Get.height * 0.255,
                                  bottom: 35,
                                  left: 15,
                                  child: Text(
                                    controller.listUserData[index].fullName
                                        .toString(),
                                    style: textStyleFont14WhiteBold,
                                  )),
                              Positioned(
                                  // top: Get.height * 0.28,
                                  bottom: 20,
                                  left: 15,
                                  child: Text(
                                    controller.listUserData[index].userStatus
                                        .toString(),
                                    style: textStyleFont12White400,
                                  )),
                              Positioned(
                                top: Get.height * 0.04,
                                left: Get.width * 0.8,
                                child: GestureDetector(
                                  onTap: () {
                                    premiumPopUpBox(context: context);
                                  },
                                  child: const Icon(Icons.more_horiz),
                                ),
                              ),
                              controller.listConnectBlock[index] == true
                                  ? Positioned(
                                      top: Get.height * 0.07,
                                      left: Get.width * 0.58,
                                      child: Container(
                                        height: 69,
                                        width: 105,
                                        color: ColorRes.color_50369C
                                            .withOpacity(0.45),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            controller.listUserData[index]
                                                        .isFriends
                                                        .toString() ==
                                                    "no"
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .sendFriendRequest(
                                                              controller
                                                                  .listUserData[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                      controller
                                                              .listConnectBlock[
                                                          index] = false;
                                                      controller
                                                          .update(["Search"]);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image.asset(
                                                          AssetRes.profilep,
                                                          height: 22,
                                                          width: 22,
                                                          color: ColorRes
                                                              .colorFFB2B2,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          Strings.connect,
                                                          style:
                                                              gilroyBoldTextStyle(
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : controller.listUserData[index]
                                                            .isFriends
                                                            .toString() ==
                                                        "sent"
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          controller.cancelFriendRequest(
                                                              controller
                                                                  .listUserData[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                          controller
                                                                  .listConnectBlock[
                                                              index] = false;
                                                          controller.update(
                                                              ["Search"]);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Image.asset(
                                                              AssetRes.profilep,
                                                              height: 22,
                                                              width: 22,
                                                              color: ColorRes
                                                                  .colorFFB2B2,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              height: 26,
                                                              width: 54,
                                                              child: Text(
                                                                Strings
                                                                    .cancelRequest,
                                                                style:
                                                                    gilroyBoldTextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : controller
                                                                .listUserData[
                                                                    index]
                                                                .isFriends
                                                                .toString() ==
                                                            "yes"
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              controller.unFriendRequest(
                                                                  controller
                                                                      .listUserData[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                              controller
                                                                      .listConnectBlock[
                                                                  index] = false;
                                                              controller.update(
                                                                  ["Search"]);
                                                            },
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Image.asset(
                                                                  AssetRes
                                                                      .profilep,
                                                                  height: 22,
                                                                  width: 22,
                                                                  color: ColorRes
                                                                      .colorFFB2B2,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  Strings
                                                                      .unFriend,
                                                                  style: gilroyBoldTextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : controller
                                                                    .listUserData[
                                                                        index]
                                                                    .isFriends
                                                                    .toString() ==
                                                                "accept"
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  controller.acceptFriendRequest(controller
                                                                      .listUserData[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                                  controller.listConnectBlock[
                                                                          index] =
                                                                      false;
                                                                  controller
                                                                      .update([
                                                                    "Search"
                                                                  ]);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Image.asset(
                                                                      AssetRes
                                                                          .profilep,
                                                                      height:
                                                                          22,
                                                                      width: 22,
                                                                      color: ColorRes
                                                                          .colorFFB2B2,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      Strings
                                                                          .accept,
                                                                      style: gilroyBoldTextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  controller.cancelFriendRequest(controller
                                                                      .listUserData[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                                  controller.listConnectBlock[
                                                                          index] =
                                                                      false;
                                                                  controller
                                                                      .update([
                                                                    "Search"
                                                                  ]);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Image.asset(
                                                                      AssetRes
                                                                          .profilep,
                                                                      height:
                                                                          22,
                                                                      width: 22,
                                                                      color: ColorRes
                                                                          .colorFFB2B2,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      Strings
                                                                          .cancel,
                                                                      style: gilroyBoldTextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                            const Divider(
                                              thickness: 1.5,
                                              color: Colors.white,
                                            ),
                                            controller.listUserData[index]
                                                        .isBlock
                                                        .toString() ==
                                                    "no"
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller.blockOnTap(
                                                          controller
                                                              .listUserData[
                                                                  index]
                                                              .id
                                                              .toString());
                                                      controller
                                                              .listConnectBlock[
                                                          index] = false;
                                                      controller
                                                          .update(["Search"]);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image.asset(
                                                          AssetRes.block,
                                                          height: 22,
                                                          width: 22,
                                                          color: ColorRes
                                                              .colorFFB2B2,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          Strings.block,
                                                          style:
                                                              gilroyBoldTextStyle(
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      controller.unblockOnTap(
                                                          controller
                                                              .listUserData[
                                                                  index]
                                                              .id
                                                              .toString());
                                                      controller
                                                              .listConnectBlock[
                                                          index] = false;
                                                      controller
                                                          .update(["Search"]);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image.asset(
                                                          AssetRes.block,
                                                          height: 22,
                                                          width: 22,
                                                          color: ColorRes
                                                              .colorFFB2B2,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          Strings.unBlock,
                                                          style:
                                                              gilroyBoldTextStyle(
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.026,
                          ),
                        ],
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        controller.listConnectBlock[index] = false;
                        controller.onTapViewProfile(
                            controller.listUserData[index].id.toString());
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              controller.listUserData[index].backgroundImage
                                          .toString() ==
                                      ""
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: SizedBox(
                                        height: 232,
                                        width: Get.width * 0.90133,
                                        child: Image.asset(
                                          AssetRes.placeholderImage,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Image.network(
                                        controller
                                            .listUserData[index].backgroundImage
                                            .toString(),
                                        height: 232,
                                        width: Get.width * 0.90133,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            AssetRes.placeholderImage,
                                            height: 232,
                                            width: Get.width * 0.90133,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                              Positioned(
                                  top: Get.height * 0.03,
                                  left: Get.width * 0.05,
                                  child: controller
                                              .listUserData[index].profileImage
                                              .toString() !=
                                          ""
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.network(
                                            controller.listUserData[index]
                                                .profileImage
                                                .toString(),
                                            height: 40,
                                            width: 40,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                AssetRes.portraitPlaceholder,
                                                height: 40,
                                                width: 40,
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: Image.asset(
                                              height: 40,
                                              width: 40,
                                              AssetRes.portraitPlaceholder,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        )),
                              Container(
                                  height: 232,
                                  width: Get.width * 0.90133,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      colors: [
                                        ColorRes.color_141414.withOpacity(0.1),
                                        ColorRes.color_141414.withOpacity(0.1),
                                        ColorRes.color_141414.withOpacity(0.5),
                                        ColorRes.color_141414.withOpacity(0.8),
                                        ColorRes.color_141414
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  )),
                              Positioned(
                                  // top: Get.height * 0.255,
                                  left: 15,
                                  bottom: 35,
                                  child: Text(
                                    controller.listUserData[index].fullName
                                        .toString(),
                                    style: textStyleFont14WhiteBold,
                                  )),
                              Positioned(
                                  // top: Get.height * 0.28,
                                  left: 15,
                                  bottom: 20,
                                  child: Text(
                                    controller.listUserData[index].userStatus
                                        .toString(),
                                    style: textStyleFont12White400,
                                  )),
                              Positioned(
                                  top: Get.height * 0.04,
                                  left: Get.width * 0.8,
                                  child: GestureDetector(
                                      onTap: () {
                                        controller.onMoreButtonTap(index);
                                      },
                                      child: const Icon(Icons.more_horiz))),
                              controller.listConnectBlock[index] == true
                                  ? Positioned(
                                      top: Get.height * 0.07,
                                      left: Get.width * 0.58,
                                      child: Container(
                                        height: 69,
                                        width: 105,
                                        color: ColorRes.color_50369C
                                            .withOpacity(0.45),
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            controller.listUserData[index]
                                                        .isFriends
                                                        .toString() ==
                                                    "no"
                                                ? GestureDetector(
                                                    onTap: () {
                                                      FocusScopeNode currentfocus = FocusScope.of(context);
                                                      if (!currentfocus.hasPrimaryFocus) {
                                                        currentfocus.unfocus();
                                                      }
                                                      controller
                                                          .sendFriendRequest(
                                                              controller
                                                                  .listUserData[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                      controller
                                                              .listConnectBlock[
                                                          index] = false;
                                                      controller
                                                          .update(["Search"]);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image.asset(
                                                          AssetRes.profilep,
                                                          height: 22,
                                                          width: 22,
                                                          color: ColorRes
                                                              .colorFFB2B2,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          Strings.connect,
                                                          style:
                                                              gilroyBoldTextStyle(
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : controller.listUserData[index]
                                                            .isFriends
                                                            .toString() ==
                                                        "sent"
                                                    ? GestureDetector(
                                                        onTap: () {
                                                          FocusScopeNode currentfocus = FocusScope.of(context);
                                                          if (!currentfocus.hasPrimaryFocus) {
                                                            currentfocus.unfocus();
                                                          }
                                                          controller.cancelFriendRequest(
                                                              controller
                                                                  .listUserData[
                                                                      index]
                                                                  .id
                                                                  .toString());
                                                          controller
                                                                  .listConnectBlock[
                                                              index] = false;
                                                          controller.update(
                                                              ["Search"]);
                                                        },
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Image.asset(
                                                              AssetRes.profilep,
                                                              height: 22,
                                                              width: 22,
                                                              color: ColorRes
                                                                  .colorFFB2B2,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            SizedBox(
                                                              height: 26,
                                                              width: 54,
                                                              child: Text(
                                                                Strings
                                                                    .cancelRequest,
                                                                style:
                                                                    gilroyBoldTextStyle(
                                                                        fontSize:
                                                                            12),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )
                                                    : controller
                                                                .listUserData[
                                                                    index]
                                                                .isFriends
                                                                .toString() ==
                                                            "yes"
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              controller.unFriendRequest(
                                                                  controller
                                                                      .listUserData[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                              controller
                                                                      .listConnectBlock[
                                                                  index] = false;
                                                              controller.update(
                                                                  ["Search"]);
                                                            },
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Image.asset(
                                                                  AssetRes
                                                                      .profilep,
                                                                  height: 22,
                                                                  width: 22,
                                                                  color: ColorRes
                                                                      .colorFFB2B2,
                                                                ),
                                                                const SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  Strings
                                                                      .unFriend,
                                                                  style: gilroyBoldTextStyle(
                                                                      fontSize:
                                                                          12),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : controller
                                                                    .listUserData[
                                                                        index]
                                                                    .isFriends
                                                                    .toString() ==
                                                                "accept"
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  controller.acceptFriendRequest(controller
                                                                      .listUserData[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                                  controller.listConnectBlock[
                                                                          index] =
                                                                      false;
                                                                  controller
                                                                      .update([
                                                                    "Search"
                                                                  ]);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Image.asset(
                                                                      AssetRes
                                                                          .profilep,
                                                                      height:
                                                                          22,
                                                                      width: 22,
                                                                      color: ColorRes
                                                                          .colorFFB2B2,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      Strings
                                                                          .accept,
                                                                      style: gilroyBoldTextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  ],
                                                                ),
                                                              )
                                                            : GestureDetector(
                                                                onTap: () {
                                                                  controller.cancelFriendRequest(controller
                                                                      .listUserData[
                                                                          index]
                                                                      .id
                                                                      .toString());
                                                                  controller.listConnectBlock[
                                                                          index] =
                                                                      false;
                                                                  controller
                                                                      .update([
                                                                    "Search"
                                                                  ]);
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Image.asset(
                                                                      AssetRes
                                                                          .profilep,
                                                                      height:
                                                                          22,
                                                                      width: 22,
                                                                      color: ColorRes
                                                                          .colorFFB2B2,
                                                                    ),
                                                                    const SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      Strings
                                                                          .cancel,
                                                                      style: gilroyBoldTextStyle(
                                                                          fontSize:
                                                                              12),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                            const Divider(
                                              thickness: 1.5,
                                              color: Colors.white,
                                            ),
                                            controller.listUserData[index]
                                                        .isBlock
                                                        .toString() ==
                                                    "no"
                                                ? GestureDetector(
                                                    onTap: () {
                                                      controller.blockOnTap(
                                                          controller
                                                              .listUserData[
                                                                  index]
                                                              .id
                                                              .toString());
                                                      controller
                                                              .listConnectBlock[
                                                          index] = false;
                                                      controller
                                                          .update(["Search"]);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image.asset(
                                                          AssetRes.block,
                                                          height: 22,
                                                          width: 22,
                                                          color: ColorRes
                                                              .colorFFB2B2,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          Strings.block,
                                                          style:
                                                              gilroyBoldTextStyle(
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      controller.unblockOnTap(
                                                          controller
                                                              .listUserData[
                                                                  index]
                                                              .id
                                                              .toString());
                                                      controller
                                                              .listConnectBlock[
                                                          index] = false;
                                                      controller
                                                          .update(["Search"]);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Image.asset(
                                                          AssetRes.block,
                                                          height: 22,
                                                          width: 22,
                                                          color: ColorRes
                                                              .colorFFB2B2,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          Strings.unBlock,
                                                          style:
                                                              gilroyBoldTextStyle(
                                                                  fontSize: 12),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.026,
                          ),
                        ],
                      ),
                    );
            },
          );
        },
      ),
    );
  }
}

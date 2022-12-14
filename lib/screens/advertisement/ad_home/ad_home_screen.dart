import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/screen/update_advertisement/update_advertisement_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/widget/advertisement_list.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/widget/appbar.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/widget/no_advertisement.dart';
import 'package:rainbow_new/utils/color_res.dart';

import '../../dashboard/dashboard_controller.dart';

class AdHomeScreen extends StatefulWidget {
  const AdHomeScreen({Key? key, this.drawerKey}) : super(key: key);
  final Key? drawerKey;

  @override
  State<AdHomeScreen> createState() => _AdHomeScreenState();
}

class _AdHomeScreenState extends State<AdHomeScreen> {
  DashboardController dashboardController = Get.put(DashboardController());

  AdHomeController adHomeController = Get.put(AdHomeController());

  UpdateAdvertiseController updateAdvertiseController =
      Get.put(UpdateAdvertiseController());

  // myInit() async {
  //   /*adHomeController.page = 1;
  //   adHomeController.myAdList = [];
  //   await adHomeController.myAdvertiserListData();*/

  //   await adHomeController.viewAdvertiserData();
  // }

  @override
  void initState() {
    super.initState();
    // adHomeController.myAdList.clear();
    // adHomeController.init();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // myInit();

    //adHomeController.init();
    //adHomeController.myAdvertiserListData();

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: Get.width,
          //height: Get.height - 80,
          //padding: const EdgeInsets.only(left: 30,right: 30,top: 40),
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
          child: Obx(() {
            return Stack(
              children: [
                Column(
                  children: [
                    appbar(context: context, key: widget.drawerKey),
                    GetBuilder<AdHomeController>(
                        id: 'list',
                        builder: (controller) {
                          return (controller.myAdList == null ||
                                  controller.myAdList.length == 0)
                              ? noAdvertisement()
                              : advertisementList();
                        }),
                  ],
                ),
                adHomeController.loader.isTrue
                    ? const FullScreenLoader()
                    : const SizedBox(),
                updateAdvertiseController.loader.value == true
                    ? const FullScreenLoader()
                    : const SizedBox(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

/*
RefreshIndicator(
            onRefresh: () => adHomeController.onRefresh(),
 */

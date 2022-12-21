import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rainbow_new/common/helper.dart';
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/notification_model.dart';
import 'package:rainbow_new/model/notification_on_off_model.dart';
import 'package:rainbow_new/model/notofication_data_model.dart';
import 'package:rainbow_new/screens/Home/settings/notificationOnOff_api/notification_on_off_api.dart';
import 'package:rainbow_new/screens/Home/settings/payment/payment_controller.dart';
import 'package:rainbow_new/screens/account_Information/account_Information_screen.dart';
import 'package:rainbow_new/screens/account_Information/account_information_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_home/ad_home_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_notification/ad_notification_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_payment/ad_payment_controller.dart';
import 'package:rainbow_new/screens/advertisement/ad_support/ad_support_controller.dart';
import 'package:rainbow_new/screens/auth/register/list_nationalites/list_nationalites_api.dart';

import 'package:rainbow_new/screens/auth/registerfor_adviser/listOfCountry/list_of_country_api.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class AdvertisementController extends GetxController {
  int currentTab = 0;
  final AdHomeController homeController = Get.put(AdHomeController());
  GlobalKey<ScaffoldState>? key ;
  final PaymentController paymentController =
      Get.put(PaymentController());
  final AdNotificationsController notificationsController =
      Get.put(AdNotificationsController());
  final AdSupportController supportController = Get.put(AdSupportController());

  RxBool loader = false.obs;
  bool? isSwitched = true;

  @override
  void onInit() {
    init();
    countryName();
    countryNationalites();
  
    super.onInit();
  }

  void init(){
    notificationGetData();
    key = GlobalKey<ScaffoldState>();
  }

  Future<void> countryName() async {
    try {
      await ListOfCountryApi.postRegister()
          .then((value) => listCountryModel = value!);

      getCountry();
    } catch (e) {
      //errorToast(e.toString());
      //errorToast("No internet connection");
      debugPrint(e.toString());
    }
  }

  Future<void> countryNationalites() async {
    try {
      await ListOfNationalitiesApi.postRegister()
          .then((value) => listNationalities = value!);

      getCountryNation();
    } catch (e) {
      //errorToast("No internet connection");
      debugPrint(e.toString());
    }
  }

  /*Future<void> countryNationalites() async {
    try {
      await ListOfNationalitiesApi.postRegister()
          .then((value) => listNationalities = value!);

      getCountryNation();
    } catch (e) {
      //errorToast("No internet connection");
      debugPrint(e.toString());
    }
  }*/

  void onBottomBarChange(int index) {
    currentTab = index;
    if (index == 0) {
      homeController.init();
    } else if (index == 1) {
      paymentController.transactionApiPagination();
    } else if (index == 2) {
      notificationsController.init();
    } else {
      supportController.init();
    }
    update(['bottom_bar']);
  }

  void fun(bool flage) {}

  Future<void> inTapAccountInfo() async {
    final AccountInformationController accountInformationController =
        Get.put(AccountInformationController());
    accountInformationController.onGetData();
    accountInformationController.update(['phone']);
    Get.to(() => AccountInformationScreen());
  }

  void notification() {
    AdHomeController adHomeController = Get.find();
    adHomeController.checkUserConnection();
    isSwitched = PrefService.getBool(PrefKeys.notification);

    update(["settings"]);
  }
  NotificationOnOffModel notificationOnOffModel = NotificationOnOffModel();
  Future<void> notificationOnOffApi() async {
    try {
      loader.value = true;
      if (isSwitched == false) {
        PrefService.setValue(PrefKeys.notification, false);

        await NotificationOnOffApi.notificationOff();
      } else {
        PrefService.setValue(PrefKeys.notification, true);
        await NotificationOnOffApi.notificationOn();
      }
      update(["settings"]);

      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }
  NotificationDataModel notificationModel = NotificationDataModel();
  Future<void> notificationGetData() async {
    try {
      loader.value = true;
      notificationModel = await NotificationOnOffApi.notificationGetData();
      isSwitched = notificationModel.data == false ? false : true;
      update(["switch"]);

      loader.value = false;
    } catch (e) {

      loader.value = false;
    }
  }
  onTapNetwork() {
    errorToast("No internet connection");
  }
}

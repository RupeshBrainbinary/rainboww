import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/popup.dart';
import 'package:rainbow_new/model/default_crad_model.dart';
import 'package:rainbow_new/model/list_card_model.dart';
import 'package:rainbow_new/model/transaction_model.dart' as tr;
import 'package:rainbow_new/model/remove_card_model.dart';
import 'package:rainbow_new/model/transaction_model.dart';

import 'package:rainbow_new/model/view_cardM_model.dart';
import 'package:rainbow_new/screens/Home/home_controller.dart';
import 'package:rainbow_new/screens/Home/settings/payment/widget/remove_dialog.dart';
import 'package:rainbow_new/screens/advertisement/ad_payment/ad_payment_api/ad_payment_api.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/pref_keys.dart';
import 'add_cart/add_cart_controller.dart';

class PaymentController extends GetxController {
  PageController pageController =
      PageController(initialPage: 0, viewportFraction: 0.86, keepPage: true);
  ScrollController scrollController = ScrollController();

  int selectedIndex = 0;
  RxBool loader = false.obs;

  AddCartController addCartController = Get.put(AddCartController());

  HomeController homeController = Get.put(HomeController());

  @override
  void onInit() {
    listCardApi(showToast: true);
    // transactionApiPagination();
    init();
    // UserSubscriptionAddApi.userSubscriptionAddApi();
    update();
    super.onInit();
  }

  init() {
    scrollController.addListener(pagination);
  }

  void pagination() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await transactionApiPagination();
      update();
    }
    update();
  }
  /*changeIndex(int index) {
    selectedIndex = index;
    viewCardApi();
    update(["more"]);
  }*/

  ListCardModel listCardModel = ListCardModel();
  ViewCardModel? viewCardModel = ViewCardModel();
  RemoveCardModel removeCardModel = RemoveCardModel();
  TransactionModel transactionModel = TransactionModel();
  List<tr.Datum> transactionPageModel = [];
  DefaultCradModel defaultCradModel = DefaultCradModel();

  navigateToRemove(
      {required BuildContext context,
      String? expiryDate,
      String? expiryYear,
      String? endingNumber}) async {
    await showDialog(
        context: context,
        builder: (context) => RemoveDialog(
              expiryDate: expiryDate,
              expiryYear: expiryYear,
              endingNumber: endingNumber,
            ));
  }

  int page = 1;

  transactionApiPagination() async {
    try {
      loader.value = true;

      transactionModel = await ListCartApi.transactionApi(page);
      page++;
      print(page);
      transactionPageModel.addAll(transactionModel.data!);
      transactionPageModel.toSet();

      update(['more']);
      update(['payment']);

      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
    update();
  }

  transactionApi() async {
    loader.value = true;
    try {
      transactionModel = await ListCartApi.transactionApi(page);
      update(['more']);
      update(['payment']);
      loader.value = false;
    } catch (e) {
      loader.value = false;
      // errorToast("No internet connection");
      debugPrint(e.toString());
    }
  }

  listCardApi({required bool showToast}) async {
    try {
      loader.value = true;
      listCardModel = await ListCartApi.listCardsApi(showToast: showToast);

      if (listCardModel.data?[selectedIndex].isPrimary == true) {
        await PrefService.setValue(
            PrefKeys.defaultCard, listCardModel.data?[selectedIndex].id);
      }

      viewCardApi();
      loader.value = false;
      update(['more']);
      update(['payment']);

      HomeController homeController = Get.put(HomeController());
      listCardModel.data?.length == null
          ? homeController.viewProfile.data!.userType = "free"
          : homeController.viewProfile.data!.userType = "premium";
      // viewCardApi();
      update(['more']);
    } catch (e) {
      loader.value = false;
      //errorToast("No internet connection");
      await PrefService.setValue(
          PrefKeys.defaultCard, listCardModel.data?[selectedIndex].id);

      debugPrint(e.toString());
    }
  }

  void viewCardApi() async {
    try {
      loader.value = true;
      viewCardModel = await ListCartApi.viewCardsApi(
          id: listCardModel.data?[selectedIndex].id ?? 0);
      loader.value = false;
      update(['more']);
      update(['payment']);

    } catch (e) {
      loader.value = false;
      // errorToast("No internet connection");
      debugPrint(e.toString());
    }
  }

  void removeCardApi() async {
    loader.value = true;
    try {
      removeCardModel = await ListCartApi.removeCardApi(
          id: listCardModel.data?[selectedIndex].id ?? 0);
      update(['more']);
      update(['payment']);

      loader.value = false;
      await listCardApi(showToast: false);
    } catch (e) {
      loader.value = false;
      errorToast("No internet connection");
      debugPrint(e.toString());
    }
  }

  defaultCardApi() async {
    loader.value = true;
    try {
      if (listCardModel.data?[selectedIndex].id == null) {
        errorToast("Card not available");
        loader.value = false;
      } else {
        transactionModel = await ListCartApi.defaultCardApi(
            id: listCardModel.data?[selectedIndex].id ?? 0);
        //await PrefService.setValue(PrefKeys.defaultCard, listCardModel.data?[selectedIndex].id);
        update(['more']);
        loader.value = false;
      }
    } catch (e) {
      debugPrint(e.toString());
      loader.value = false;
      //errorToast("No internet connection");
    }
  }

  String timeAgo(DateTime d) {
    Duration diff = DateTime.now().difference(d);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
    }
    if (diff.inDays > 0) {
      return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
    }
    if (diff.inHours > 0) {
      return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
    }
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "minute" : "minutes"} ago";
    }
    return "just now";
  }
}

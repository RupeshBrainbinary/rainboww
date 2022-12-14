import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/model/accept_friend_request_model.dart';
import 'package:rainbow_new/model/block_model.dart';
import 'package:rainbow_new/model/cancle_fried_request_model.dart';
import 'package:rainbow_new/model/profile_model.dart';
import 'package:rainbow_new/model/send_friend_request_model.dart';
import 'package:rainbow_new/model/unfriend_model.dart';
import 'package:rainbow_new/model/unblock_model.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_profile/api/OtherProfileApi.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_profile/connections_profile_screen.dart';
import 'package:rainbow_new/screens/Profile/acceptFriendRequest_api/accaept_fried_request_api.dart';
import 'package:rainbow_new/screens/Profile/profile_api/profile_model.dart';
import 'package:rainbow_new/screens/Profile/profile_controller.dart';
import 'package:rainbow_new/screens/Profile/sendFriendRequest_api/send_friend_request_api.dart';
import 'package:rainbow_new/screens/Profile/unFriendRequest_api/unfriend_request_api.dart';
import 'package:rainbow_new/screens/Profile/widget/block_unblock%20_Api/block_api.dart';
import 'package:rainbow_new/screens/Profile/widget/block_unblock%20_Api/unblock_api.dart';
import 'package:rainbow_new/screens/Profile/widget/profile_appbar.dart';


class ConnectionsProfileController extends GetxController {
/*
  Future<void> init(userId) async {
    await callApi(userId);
  }
*/
  // ProfileModel profileModel = ProfileModel();
  BlockModel blockModel = BlockModel();
  UnblockModel unblockModel = UnblockModel();
  SendFriendRequest sendFriendRequest = SendFriendRequest();
  AcceptFriendRequest acceptFriendRequest = AcceptFriendRequest();

  // HomeController homeController = Get.put(HomeController());
  CancelFriendRequestModel cancelFriendRequestModel =
      CancelFriendRequestModel();
  ProfileController profileController = Get.put(ProfileController());

  UnFriendModel unFriendModel = UnFriendModel();

  @override
  void onInit() {
    update(["connections"]);
    super.onInit();
  }

  // void checkStatusForBlockUser() {
  //   for (int i = 0; i < homeController.blockListModel.data!.length; i++) {
  //     homeController.blockListModel.data![i].id == profileModel.data!.id;
  //   }
  // }

  RxBool loader = false.obs;

  Future<void> callApi(String? userId) async {

    profileController.loader.value = true;
    // int userId= PrefService.getInt(PrefKeys.userId);

    /*Get.to(() => ConnectionsProfileScreen())?.then((value) {
      if (kDebugMode) {
        print("PROFILE SCREEN BACK 2");
      }
      profileModel = ProfileModel();
    });*/
    profileController.viewProfile = await OtherProfileApi.getOtherUerData(userId.toString());
    /*profileModel = await OtherProfileApi.getOtherUerData(userId.toString())
        .then((value) => profileModel = value!);*/
    profileController.loader.value = false;
  }

  Future<void> blockUserDetails(String? id) async {
    try {
      loader.value = true;
      await BlockApi.postRegister(id.toString())
          .then((value) => blockModel = value);
      await callApi(id);
      /*await profileController.viewProfileDetails();

      await homeController.blockListDetailes();*/
      update(["connections"]);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> unBlockUserDetails(String id) async {
    try {
      loader.value = true;
      await UnBlockApi.postRegister(id).then((value) => unblockModel = value);
      await callApi(id);
      /*await homeController.blockListDetailes();
      await profileController.viewProfileDetails();*/
      update(["connections"]);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> sendFriendRequestDetails(String id) async {
    try {
      loader.value = true;
      await SendFriendRequestApi.postRegister(id)
          .then((value) => sendFriendRequest = value);
      await callApi(id);
      // homeController.listOfFriedRequestDetails();
      update(["connections"]);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> acceptFriendRequestDetails(String id) async {
    try {
      loader.value = true;
      await AcceptFriendRequestApi.postRegister(id);
      await callApi(id);
      update(["connections"]);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> cancelFriendRequestDetails(String id) async {
    try {
      loader.value = true;
      cancelFriendRequestModel = (await OtherProfileApi.cancelRequest(id)) ??
          CancelFriendRequestModel();
      await callApi(id);
      update(["connections"]);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  Future<void> unFriendRequestDetails(String id) async {
    try {
      loader.value = true;
      unFriendModel = await UnFriendRequestApi.postRegister(id);
      await callApi(id);
      update(["connections"]);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  void onTapGetBack() {
    profileController.viewProfile= ViewProfile();
    Get.back();
  }

  void onTapGetBack2(context) {
    profileController.viewProfile = ViewProfile();
    Navigator.of(context).pop();
  }
}

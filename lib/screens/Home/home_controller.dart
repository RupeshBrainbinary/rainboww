import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/premiumPopUpBox/premium_pop_up_box.dart';
import 'package:rainbow_new/common/blocList_api/block_list_api.dart';
import 'package:rainbow_new/common/helper.dart';
import 'package:rainbow_new/model/advertisement_list%5Buser%5D.dart';
import 'package:rainbow_new/model/block_list_model.dart';
import 'package:rainbow_new/model/friend_post_view_model.dart';
import 'package:rainbow_new/model/list_of_friend_request_model.dart';
import 'package:rainbow_new/model/list_user_tag_model.dart';
import 'package:rainbow_new/model/my_post_list_model.dart';
import 'package:rainbow_new/model/notification_model.dart';
import 'package:rainbow_new/model/post_like_model.dart';
import 'package:rainbow_new/model/post_view_model.dart';
import 'package:rainbow_new/model/share_post_model.dart';
import 'package:rainbow_new/model/unlike_post_model.dart';

import 'package:rainbow_new/screens/Home/Story/friendStory_api/friend_story_api.dart';
import 'package:rainbow_new/screens/Home/addStroy/add_story_screen.dart';
import 'package:rainbow_new/screens/Home/home_screen.dart';
import 'package:rainbow_new/screens/Home/myPost_Api/my_post_api.dart';
import 'package:rainbow_new/screens/Home/my_story/my_story_controller.dart';
import 'package:rainbow_new/screens/Home/my_story/my_story_screen.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_controller.dart';
import 'package:rainbow_new/screens/Home/settings/connections/connections_profile/connections_profile_controller.dart';
import 'package:rainbow_new/screens/Home/settings/payment/payment_controller.dart';
import 'package:rainbow_new/screens/Home/settings/settings_screen.dart';

import 'package:rainbow_new/screens/Home/view_story/view_story_controller.dart';
import 'package:rainbow_new/screens/Home/view_story/view_story_screen.dart';
import 'package:rainbow_new/screens/Home/view_story/widgets/postLike_listScreen.dart';
import 'package:rainbow_new/screens/Home/view_story/widgets/postView_bottomshit.dart';
import 'package:rainbow_new/screens/Profile/profile_api/profile_api.dart';
import 'package:rainbow_new/screens/Profile/profile_api/profile_model.dart';
import 'package:rainbow_new/screens/Profile/profile_controller.dart';
import 'package:rainbow_new/screens/Profile/widget/listOfFriendRequest_api/list_of_friend_request_api.dart';
import 'package:rainbow_new/screens/auth/register/list_nationalites/list_nationalites_api.dart';
import 'package:rainbow_new/screens/auth/registerfor_adviser/listOfCountry/list_of_country_api.dart';
import 'package:rainbow_new/screens/notification/api/notification_api.dart';
import 'package:rainbow_new/screens/notification/notification_controller.dart';
import 'package:rainbow_new/screens/notification/notification_screen.dart';
import 'package:uni_links/uni_links.dart';

import 'advertise_api/advertise_api.dart';

class HomeController extends GetxController {
  RxBool loader = false.obs;
  ProfileController controller = Get.put(ProfileController());
  ListOfFriendRequestModel listOfFriendRequestModel =
      ListOfFriendRequestModel();
  ViewStoryController viewStoryController = Get.put(ViewStoryController());
  List<bool> isAd = List.generate(10, (index) => Random().nextInt(2) == 1);
  MyStoryController myStoryController = Get.put(MyStoryController());

  // RefreshController? refreshController;

  MyPostListModel myPostListModel = MyPostListModel();
  TextEditingController comment = TextEditingController();
  List<UserData> tagUserList = [];
  PostUnlikeModel postUnlikeModel = PostUnlikeModel();
  PostLikeModel postLikeModel = PostLikeModel();
  BlockListModel blockListModel = BlockListModel();
  SharePostModel sharePostModel = SharePostModel();
  PostViewModel postViewModel = PostViewModel();
  FriendPostViewModel friendPostViewModel = FriendPostViewModel();

/*  PostCommentListModel postCommentListModel = PostCommentListModel();*/
  String? deepLinkPath;
  List<FriendPost> friendPostListData = [];
  List listOfUserView = [];
  String? address;
  String? addCountry;
  String? addCity;
  String? addStreet;

  //List<AdvertiseAndPostModel> adAndPost = []

  ScrollController scrollController = ScrollController();
  int page = 1;
  int limit = 10;

  int pageIndex = 0;

  RxBool premiumBox = false.obs;

  // final storyController = EditStoryController();
  ConnectionsController connectionsController =
      Get.put(ConnectionsController());

  bool activeConnection = false;

  String T = "";

  Future checkUserConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        activeConnection = true;
        T = "Turn off the data and repress again";
        update(["network"]);
      }
    } on SocketException catch (_) {
      activeConnection = false;
      T = "Turn On the data and repress again";
      update(["network"]);
    }
  }

  @override
  void onInit() async {
  /*  await init();*/

    await deepLinkInt();
    update(['home']);
    super.onInit();
  }

  void onTapSetting() {
    Get.to(() => SettingsScreen())!.then((value) async {
      await controller.viewProfileDetails();
    });
  }

  NotificationModel? notificationModel = NotificationModel();

  void pagination() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      await friendPostData();
    }
    update(['home']);
  }

  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    // loader.value = true;
    if (permission == LocationPermission.denied) {
      LocationPermission result = await Geolocator.requestPermission();
      if (result == LocationPermission.always ||
          result == LocationPermission.whileInUse) {
        getCurrentLocation();
      }
    } else {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

      Placemark place = placemarks[0];

      addCity = place.locality;
      addCountry = place.country;
      addStreet = place.street;
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

      update(["advertiser"]);
    }
    // loader.value = false;
  }

  Future<void> countryName() async {
    try {
      await ListOfCountryApi.postRegister()
          .then((value) => listCountryModel = value!);
      debugPrint(listCountryModel.toJson().toString());
      getCountry();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void onNewStoryTap() {
    // if (myStoryController.myStoryModel.data!.isNotEmpty) {
    Get.to(() => const MyStoryScreen());
    /*   } else {
      Get.to(() => AddStoryScreen());
    }*/
    // Get.to(() => AddStoryScreen());
  }

  Future<void> countryNationalites() async {
    try {
      await ListOfNationalitiesApi.postRegister()
          .then((value) => listNationalities = value!);

      getCountryNation();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> blockListDetailes() async {
    try {
      await BlockListApi.postRegister()
          .then((value) => blockListModel = value!);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> myStoryList() async {
    try {
      myPostListModel = await FriendStoryApi.getMyPostList();
      update(['home']);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List<PostLikeUser>? postLikeUser = [];
  List<PostUser>? postViewUser = [];

  /// post like list
  void onLikeBtnTap({required FriendPost friendPost, String? postId}) {
    postLikeUser = friendPost.postLikeUser ?? [];

    Get.bottomSheet(
      const PostLikeListScreen(),
      isScrollControlled: true,
    ).then((value) {});
  }

  void onPostViewUser({required FriendPost friendPost, String? postId}) {
    postViewUser = friendPost.postViewUser ?? [];

    Get.bottomSheet(
      const PostViewBottomScreen(),
      isScrollControlled: true,
    ).then((value) {});
  }

  ///On Share

  Future<void> deepLinkInt() async {
    Uri? uri = await getInitialUri();
    if (uri != null) {
      deepLinkPath = uri.path;
    }
    uriLinkStream.listen((event) {
      if (event != null) {
        Get.to(() => const HomeScreen());
      }
    });
  }

  Future<void> share(String? id) async {
    await FlutterShare.share(
        title: 'rainbow_new',
        text: 'rainbow_new',
        linkUrl: "https://www.rainbow_new.com/rainbow_new/$id",
        chooserTitle: 'rainbow_new');
  }

  Future<void> sharePostData(String id) async {
    try {
      loader.value = true;
      sharePostModel = await MyPostApi.sharPostApi(id);
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        await friendPostDataWithOutPagination();
      });
      update(['home']);
      loader.value = false;
    } catch (e) {
      debugPrint(e.toString());
      loader.value = false;
    }
  }

  Future<void> likePostData(String id) async {
    try {
      loader.value = true;
      postLikeModel = await MyPostApi.postLikeApi(id);
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        await friendPostDataWithOutPagination();
      });
      update(['home']);
      loader.value = false;
    } catch (e) {
      loader.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> unLikePostData(String id) async {
    try {
      loader.value = true;
      postUnlikeModel = await MyPostApi.postUnLikeApi(id);
      Future.delayed(const Duration(seconds: 1)).then((value) async {
        await friendPostDataWithOutPagination();
      });
      update(['home']);
      loader.value = false;
    } catch (e) {
      debugPrint(e.toString());
      loader.value = false;
    }
  }

  Future<void> postViewData(String id) async {
    if (listOfUserView.contains(id)) {
      return;
    }
    try {
      postViewModel = await MyPostApi.postViewApi(id);
      listOfUserView.add(id);
      await friendPostDataWithOutPagination();
      update(['home']);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> friendPostData() async {
    try {
      loader.value = true;
      friendPostViewModel = await MyPostApi.friendPostApi(page, limit);
      page++;
      friendPostListData.addAll(friendPostViewModel.data!);
 /*     update(['home']);*/
      loader.value = false;
    } catch (e) {
      debugPrint(e.toString());
      loader.value = false;
    }
  }

  Future<void> friendPostDataWithOutPagination({int? pageLength}) async {
    try {
      loader.value = true;
      friendPostViewModel = await MyPostApi.friendPostApi(
          1, pageLength ?? friendPostListData.length);
      friendPostListData = friendPostViewModel.data!;
  /*    update(['home']);*/
      loader.value = false;
    } catch (e) {
      debugPrint(e.toString());
      loader.value = false;
    }
  }

/*  Future<void> commentPostListData(String idPost) async {
    try {

      postCommentListModel = await MyPostApi.commentPostListApi(idPost);
      update(['home']);
      loader.value = false;
    } catch (e) {
      loader.value = false;
      debugPrint(e.toString());
    }
  }*/

  Future<void> listOfFriedRequestDetails() async {
    try {
      changeLoader(true);
      listOfFriendRequestModel = (await ListOfFriendRequestApi.postRegister())!;
      update(["connections"]);
      changeLoader(false);
    } catch (e) {
      changeLoader(false);
    }
  }

  Future<void> refreshCode() async {
    page = 1;
    friendPostListData = [];
    await controller.viewProfileDetails();
    await onStory();
    await getNotifications();

    /*  await friendPostDataWithOutPagination();*/
    await friendPostData();

    await connectionsController.callRequestApi();
  }

  Future<void> init() async {
    PaymentController paymentController = Get.put(PaymentController());

    await friendPostData();
    await friendPostDataWithOutPagination();
    await onStory();
    await getNotifications();
    /*   changeLoader(true);*/
    await checkUserConnection();
    // without loder
    await viewProfileApi();
    // with loder

    // without loder
    await advertisementListUser();
    paymentController.transactionApiPagination();
    await paymentController.listCardApi(showToast: false);
    paymentController.listCardModel.data?.length == null
        ? viewProfile.data!.userType = "free"
        : viewProfile.data!.userType = "premium";
     getCurrentLocation();
    await controller.viewProfileDetails();

    countryName();
    countryNationalites();
    // without loder


    await connectionsController.callRequestApi();
    /*  changeLoader(false);*/
  }

  Future<void> onStory() async {
    loader.value = true;
    await viewStoryController.friendStoryApiData();
    // await myStoryController.init();
    update(['home']);
    loader.value = false;
  }

  myStoryOnTap() async {
    Get.to(() => const AddStoryScreen());
    /*MyStoryController myStoryController = Get.put(MyStoryController());
    loader.value = true;
    await myStoryController.init();
    loader.value = false;
    if (myStoryController.myStoryModel.data!.isNotEmpty) {
      Get.to(() => const MyStoryScreen());
    } else {
      Get.to(() => AddStoryScreen());
    }*/
  }

  Future<void> getNotifications() async {
    loader.value = true;
    notificationModel = await NotificationApi.getNotificationList();

    update(['notification_badge']);
    loader.value = false;
  }

  Future<void> onRefresh() async {
    /*await init()*/
    await refreshCode();
    // refreshController!.refreshCompleted();
  }

  void changeLoader(bool status) {
    /*if (refreshController == null || refreshController!.headerMode == null) {
      loader.value = status;
      return;
    }
    if (refreshController!.headerMode!.value == RefreshStatus.refreshing) {
      return;
    }
    loader.value = status;*/
  }

  void onNotyIconBtnTap({context}) {
    NotificationsController notificationsController =
        Get.put(NotificationsController());
    notificationsController.init();
    viewProfile.data!.userType == "free"
        ? premiumPopUpBox(context: context)
        : Get.to(() => NotificationScreen());
    // Get.to(() => NotificationScreen());
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Future<void> onFriedStoryTap(int index) async {
    viewStoryController.currentPage = index;
    viewStoryController.storyIndex = 0;
    viewStoryController.init();
    /*loader.value = true;
    for (var data in viewStoryController.friendStoryModel.data!) {
      for (var story in data.storyList!) {
        String url = story.storyItem.toString();
        await DefaultCacheManager().downloadFile(url);
      }
    }
    loader.value = false;*/
    Get.to(() => const ViewStoryScreen());
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

  bool isToday(DateTime time) {
    DateTime now = DateTime.now();

    if (now.day == time.day &&
        now.month == time.month &&
        now.year == time.year) {
      return true;
    } else {
      return false;
    }
  }

  void onTagTap(String? userId) {
    ConnectionsProfileController connectionsProfileController =
        Get.put(ConnectionsProfileController());
    connectionsProfileController.callApi(userId);
  }

  ViewProfile viewProfile = ViewProfile();

  Future<void> viewProfileApi() async {
    try {
      /*loader.value = true;*/
      viewProfile = await ViewProfileApi.postRegister();
      controller.update(["settings"]);
     /* loader.value = false;*/
    } catch (e) {
      /*loader.value = false;*/
    }
  }

  AdvertisementListUserModel advertisementListUserModel =
      AdvertisementListUserModel();

  Future<void> advertisementListUser() async {
    try {
      /*loader.value = true;*/
      advertisementListUserModel =
          await AdvertiseListUser.advertiseListUserApi();
      update(["settings"]);
     /* loader.value = false;*/
    } catch (e) {
   /*   loader.value = false;*/
    }
  }
}

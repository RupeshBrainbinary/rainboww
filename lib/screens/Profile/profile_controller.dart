import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rainbow_new/screens/Home/settings/settings_controller.dart';
import 'package:rainbow_new/screens/Profile/profile_api/profile_api.dart';
import 'package:rainbow_new/screens/Profile/profile_api/profile_model.dart';
import 'package:rainbow_new/screens/Profile/widget/postTestimonials_api/post_testimonials_api.dart';
import 'package:rainbow_new/screens/Profile/widget/testimonials.dart';
import 'package:rainbow_new/screens/dashboard/dashboard_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileController extends GetxController {
  RxBool loader = false.obs;
  bool seeMoreAndLess = false;
  TextEditingController postTestimonials = TextEditingController();
  String? url;
  bool change = false;

  List<String> image = [
    AssetRes.lt1,
    AssetRes.lt2,
    AssetRes.lt3,
    AssetRes.se,
    AssetRes.homePro,
    AssetRes.lt1,
  ];
  List<String> imageName = [
    "Amber Davis",
    "Lyka Keen",
    "Liz Mcguire",
    "Riku Tanida",
    "Natalie Nara ",
    "Sally Wilson",
  ];
  ViewProfile viewProfile = ViewProfile();

  RxBool screen = false.obs;

  @override
  void onInit() async {
    init();
    viewProfileDetails();
    update(["profile"]);
    super.onInit();
  }

  Future<void> init() async {
    count = 1;
/*    loader.value = true;*/
  }

  void onShowMoreTap(bool value) {
    seeMoreAndLess = value;
  }

  SettingsController controller = Get.put(SettingsController());

  Future<void> viewProfileDetails() async {
    try {

      loader.value = true;
      viewProfile = await ViewProfileApi.postRegister();

      controller.update(["settings"]);
      loader.value = false;
    } catch (e) {
      loader.value = false;
    }
  }

  void _launchUrl(String? url) async {
    if (!await launchUrl(Uri.parse(url!))) {
      throw 'Could not launch $url';
    }
  }

  onTapToHomeScreen() {
    DashboardController dashboardController = Get.find();
    dashboardController.onBottomBarChange(0);
  }

  RxBool loaderTestimonials = false.obs;

  Future<void> postTestimonialsApi(String id, BuildContext context) async {
    try {
      loaderTestimonials.value = true;
      await PostTestimonialsApi.postTestimonials(
          id, postTestimonials.text, context);
      postTestimonials.clear();

      update(["testimonials"]);
      loaderTestimonials.value = false;
    } catch (e) {
      loaderTestimonials.value = false;
    }
  }

  int count = 1;

  Widget viewTestimonials() {
    List? testimonialsData = [];
    testimonialsData.add(viewProfile.data!.testimonialsList![(2 * count) - 2]);

    if (viewProfile.data!.testimonialsList!.length >= (count * 2)) {
      testimonialsData
          .add(viewProfile.data!.testimonialsList![(2 * count) - 1]);
    }
/*    if((viewProfile.data!.testimonialsList!.length % 2) == 0){
      testimonialsData
          .add(viewProfile.data!.testimonialsList![(2 * count) - 2]);
    }*/
    update(["profile"]);
    return ListView.separated(
      padding: const EdgeInsets.only(top: 15),
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return listOfTestimonials(
            title: testimonialsData[index].userSender!.fullName.toString(),
            subtitle: testimonialsData[index].userSender!.userStatus.toString(),
            descriptions: testimonialsData[index].testimonial.toString(),
            date: DateFormat("dd/MM/yyyy").format(testimonialsData[index].createdAt!),
            profile: testimonialsData[index].userSender!.profileImage.toString());
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 24,
          color: ColorRes.white.withOpacity(0.7),
        );
      },
      itemCount: testimonialsData.length,
      shrinkWrap: true,
    );
  }
}

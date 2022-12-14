import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/screens/Home/home_controller.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';

// ignore: must_be_immutable
class LearnMoreDetails extends StatelessWidget {
  int? index;

  LearnMoreDetails({required this.index, Key? key}) : super(key: key);

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        height: Get.height,
        width: Get.width,
        color: ColorRes.white,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              appBar(context),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  children: [
                    (homeController.advertisementListUserModel.data?[index!]
                                    .userDetails?.profileImage ==
                                null ||
                            homeController.advertisementListUserModel
                                    .data?[index!].userDetails?.profileImage ==
                                "")
                        ? Container(
                            height: 40,
                            width: 40,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage(
                                        AssetRes.portraitPlaceholder))),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: CachedNetworkImage(
                                  imageUrl: homeController
                                          .advertisementListUserModel
                                          .data?[index!]
                                          .userDetails
                                          ?.profileImage ??
                                      "",
                                  placeholder: ((context, url) => Image.asset(
                                      AssetRes.portraitPlaceholder)),
                                  errorWidget: ((context, url, error) =>
                                      Image.asset(
                                          AssetRes.portraitPlaceholder)),
                                  fit: BoxFit.cover),
                            ),
                          ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(top: 9),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            homeController.advertisementListUserModel
                                    .data?[index!].userDetails?.fullName
                                    .toString() ??
                                "",
                            style: gilroyBoldTextStyle(
                                fontSize: 16, color: ColorRes.black),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Row(
                            children: [
                              Text(
                                "Sponsored.",
                                style: gilroyBoldTextStyle(
                                    fontSize: 16,
                                    color: ColorRes.black.withOpacity(0.4)),
                              ),
                              Image.asset(
                                AssetRes.worldIcon,
                                height: 10,
                                width: 10,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GetBuilder<HomeController>(
                  id: "img",
                  builder: (controller) {
                    return Container(
                      height: Get.width * 0.51,
                      //width: Get.width * 0.98833,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 12, left: 15, right: 15),
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        child: Stack(
                          children: [
                            (homeController.advertisementListUserModel
                                        .data?[index!].itemsList!.length ==
                                    0)
                                ? Image.asset(
                                    AssetRes.placeholderImage,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                  )
                                : PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: homeController
                                        .advertisementListUserModel
                                        .data?[index!]
                                        .itemsList!
                                        .length,
                                    onPageChanged: (index) {
                                      homeController.pageIndex = index;
                                      homeController.update(["img"]);
                                    },
                                    itemBuilder: (context, index1) {
                                      return SizedBox(
                                        width: Get.width,
                                        child: FadeInImage(
                                          placeholder: const AssetImage(
                                              AssetRes.placeholderImage),
                                          image: NetworkImage(
                                            homeController
                                                .advertisementListUserModel
                                                .data![index!]
                                                .itemsList![index1]
                                                .toString(),
                                          ),
                                          width: Get.width - 60,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                (homeController
                                                .advertisementListUserModel
                                                .data?[index!]
                                                .itemsList!
                                                .length ==
                                            1 ||
                                        homeController
                                                .advertisementListUserModel
                                                .data?[index!]
                                                .itemsList!
                                                .length ==
                                            0)
                                    ? const SizedBox()
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(top: 100),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: CarouselIndicator(
                                            cornerRadius: 30,
                                            height: 6,
                                            width: 6,
                                            count: homeController
                                                .advertisementListUserModel
                                                .data?[index!]
                                                .itemsList!
                                                .length,
                                            index: homeController.pageIndex,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                height: 19,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        homeController.advertisementListUserModel.data?[index!]
                                .description ??
                            "",
                        style: beVietnamSemiBoldTextStyle(
                          color: ColorRes.darkBlue.withOpacity(0.6),
                          fontSize: 14,
                        ).copyWith(
                          letterSpacing: 0,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget appBar(BuildContext context) {
    return Container(
      width: Get.width,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Stack(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(left: Get.width * 0.05),
                  child: Container(
                    height: 25,
                    width: 35,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image.asset(AssetRes.backIcon,color: Colors.black,),
                    ),

                  ),
                ),
              ),
              Center(
                child: Text(
                 "Details",
                  style: gilroyBoldTextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/common/helper.dart';
import 'package:rainbow_new/screens/Message/message_controller.dart';
import 'package:rainbow_new/screens/dashboard/dashboard_controller.dart';
import 'package:rainbow_new/service/pref_services.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/pref_keys.dart';

class MessageScreen extends StatelessWidget {
  final bool? backArrow;

  MessageScreen({this.backArrow, Key? key}) : super(key: key);
  final MessageController messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    /* messageController.getChatUserId();*/
    messageController.getUid();
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          height: Get.height,
          width: Get.width,
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
          child: GetBuilder<MessageController>(
            id: "message",
            builder: (controller) {
              return Stack(
                children: [
                  SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // (backArrow == true)
                        //     ?
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if(backArrow==true){
                                  Navigator.pop(context);
                                }else
                                  {
                                    DashboardController dashboardController =
                                    Get.find();
                                    dashboardController.onBottomBarChange(0);
                                  }

                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.05, top: 20),
                                child: Container(
                                  height: 15,
                                  width: 35,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                    image: AssetImage(
                                      AssetRes.backIcon,
                                    ),
                                  )),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 50, top: 20),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    height: 50,
                                    child: Center(
                                      child: Text(
                                        "Chats",
                                        style:
                                            gilroyMediumTextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // :
                        //  Padding(
                        //     padding: const EdgeInsets.only(top: 20),
                        //     child: SizedBox(
                        //       height: 50,
                        //       child: Center(
                        //         child: Text(
                        //           "Chats",
                        //           style:
                        //               gilroyMediumTextStyle(fontSize: 18),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 20),

                              /// Search Text Field
                              Expanded(
                                child: TextFormField(
                                  controller: controller.msgController,
                                  onChanged: (value) {
                                    controller.update(["message"]);
                                  },
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Search",
                                    hintStyle: sfProTextReguler(
                                      fontSize: 17,
                                      color: ColorRes.color_8E8E93,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// Online / Offline
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                StreamBuilder<
                                    QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance
                                      .collection('chats')
                                      .where("uidList",
                                      arrayContains: controller.userUid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null ||
                                        snapshot.hasData == false) {
                                      return const SizedBox();
                                    }
                                    return SizedBox(
                                      width: Get.width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: snapshot.data!.docs
                                              .map<Widget>((e) {
                                            List<dynamic> idList =
                                                e.data()['uidList'];
                                            String userId = "";
                                            for (var value in idList) {
                                              if (value != controller.userUid) {
                                                userId = value;
                                              }
                                            }
                                            return StreamBuilder<
                                                DocumentSnapshot<
                                                    Map<String, dynamic>>>(
                                              stream: FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(userId)
                                                  .snapshots(),
                                              builder: (context, snapshot2) {
                                                Map<String, dynamic>? data =
                                                    snapshot2.data?.data();
                                                if (data == null) {
                                                  return const SizedBox();
                                                }
                                                return data['online'] == true
                                                    ? Column(
                                                        children: [
                                                          const SizedBox(
                                                              height: 10),
                                                          Stack(
                                                            children: [
                                                              data['image']
                                                                      .toString()
                                                                      .isEmpty
                                                                  ? Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      decoration: const BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          image:
                                                                              DecorationImage(image: AssetImage(AssetRes.portraitPlaceholder))),
                                                                    )
                                                                  : Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            const BorderRadius.all(
                                                                          Radius.circular(
                                                                              50),
                                                                        ),
                                                                        child:
                                                                            CachedNetworkImage(
                                                                          fit: BoxFit
                                                                              .cover,
                                                                          imageUrl:
                                                                              data['image'].toString(),
                                                                          errorWidget: ((context, url, error) =>
                                                                              Image.asset(
                                                                                AssetRes.portraitPlaceholder,
                                                                                height: 50,
                                                                                width: 50,
                                                                                fit: BoxFit.cover,
                                                                              )),
                                                                          placeholder: ((context, url) =>
                                                                              Image.asset(
                                                                                AssetRes.portraitPlaceholder,
                                                                                height: 50,
                                                                                width: 50,
                                                                                fit: BoxFit.cover,
                                                                              )),
                                                                        ),
                                                                      ),
                                                                    ),
                                                              Positioned(
                                                                bottom: 0,
                                                                right: 12,
                                                                child:
                                                                    //     Image.asset(
                                                                    //   AssetRes.oval,
                                                                    //   height: 12,
                                                                    //   width: 12,
                                                                    // ),
                                                                    Container(
                                                                  height: 13,
                                                                  width: 13,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                          color: ColorRes
                                                                              .color5AD439,
                                                                          border: Border
                                                                              .all(
                                                                            color:
                                                                                ColorRes.white,
                                                                            width:
                                                                                2.4,
                                                                          ),
                                                                          shape:
                                                                              BoxShape.circle),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          const SizedBox(
                                                              height: 10),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 10,
                                                                    right: 10),
                                                            child: Text(
                                                                data['name']),
                                                          ),
                                                          SizedBox(
                                                            height: 15,
                                                          )
                                                        ],
                                                      )
                                                    : const SizedBox();
                                              },
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    );
                                  },
                                ),

                                /// Message
                                controller.msgController.text.isEmpty
                                    ? GetBuilder<MessageController>(
                                        id: "message",
                                        builder: (controller) {
                                          return StreamBuilder<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>(
                                            stream: FirebaseFirestore.instance
                                                .collection('chats')
                                                .where("uidList",
                                                    arrayContains:
                                                        controller.userUid)
                                                .orderBy("lastMessageTime",
                                                    descending: true)
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.data == null ||
                                                  snapshot.hasData == false) {
                                                return const SizedBox();
                                              }
                                              return SizedBox(
                                                height: Get.height * 0.53,
                                                child: ListView.builder(
                                                  physics:
                                                      BouncingScrollPhysics(),
                                                  padding: EdgeInsets.all(0),
                                                  itemCount: snapshot
                                                      .data!.docs.length,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    List<
                                                        String> idList = (snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .data()[
                                                                'uidList'] ??
                                                            [])
                                                        .map<String>(
                                                            (e) => e.toString())
                                                        .toList();
                                                    Map<String, dynamic>
                                                        docData = snapshot
                                                            .data!.docs[index]
                                                            .data();
                                                    String userId = "";
                                                    for (var value in idList) {
                                                      if (value !=
                                                          controller.userUid) {
                                                        userId = value;
                                                      }
                                                    }
                                                    if (userId.isEmpty) {
                                                      return const SizedBox();
                                                    }

                                                    if (userId.isEmpty) {
                                                      return const SizedBox();
                                                    }
                                                    return StreamBuilder<
                                                        DocumentSnapshot<
                                                            Map<String,
                                                                dynamic>>>(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(userId)
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot2) {
                                                        Map<String, dynamic>?
                                                            data = snapshot2
                                                                .data
                                                                ?.data();
                                                        if (data == null) {
                                                          return const SizedBox();
                                                        }
                                                        return InkWell(
                                                          onTap: () {
                                                            controller
                                                                .gotoChatScreen(
                                                              context,
                                                              data['uid'],
                                                              data['name'],
                                                              data['image'],
                                                              data['UserToken'],
                                                            );
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                       7),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                    width: 5),
                                                                data['image']
                                                                        .toString()
                                                                        .isEmpty
                                                                    ? Container(
                                                                        margin:
                                                                            const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10,
                                                                        ),
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            60,
                                                                        decoration: const BoxDecoration(
                                                                            shape:
                                                                                BoxShape.circle,
                                                                            image: DecorationImage(image: AssetImage(AssetRes.portraitPlaceholder))),
                                                                      )
                                                                    : Container(
                                                                        margin:
                                                                            const EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              10,
                                                                        ),
                                                                        height:
                                                                            60,
                                                                        width:
                                                                            60,
                                                                        decoration:
                                                                            const BoxDecoration(shape: BoxShape.circle),
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              const BorderRadius.all(
                                                                            Radius.circular(50),
                                                                          ),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fit:
                                                                                BoxFit.cover,
                                                                            imageUrl:
                                                                                data['image'].toString(),
                                                                            errorWidget: ((context, url, error) =>
                                                                                Image.asset(
                                                                                  AssetRes.portraitPlaceholder,
                                                                                  height: 50,
                                                                                  width: 50,
                                                                                  fit: BoxFit.cover,
                                                                                )),
                                                                            placeholder: ((context, url) =>
                                                                                Image.asset(
                                                                                  AssetRes.portraitPlaceholder,
                                                                                  height: 50,
                                                                                  width: 50,
                                                                                  fit: BoxFit.cover,
                                                                                )),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    data['name']
                                                                            .toString()
                                                                            .isEmpty
                                                                        ? const SizedBox()
                                                                        : Text(
                                                                            data['name'].toString(),
                                                                            style:
                                                                                sfProTextReguler(
                                                                              fontSize: 17,
                                                                            ),
                                                                          ),
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "${docData['lastMessageSender'] == PrefService.getString(PrefKeys.uid) ? "You:" : ""}${docData['lastMessage']}",
                                                                          style:
                                                                              sfProTextReguler(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                ColorRes.colorF0F0F0,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          docData['lastMessageTime'] == null
                                                                              ? ""
                                                                              : " · ${getFormattedTime(docData['lastMessageTime'].toDate() ?? "")}",
                                                                          style:
                                                                              sfProTextReguler(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                ColorRes.colorF0F0F0,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                                const Spacer(),
                                                                (docData['lastMessageSender'] ==
                                                                            PrefService.getString(PrefKeys
                                                                                .uid)) &&
                                                                        (docData['lastMessageRead'] ==
                                                                            true)
                                                                    ? Image
                                                                        .asset(
                                                                        AssetRes
                                                                            .read,
                                                                        height:
                                                                            16,
                                                                        width:
                                                                            16,
                                                                      )
                                                                    : const SizedBox(),
                                                                const SizedBox(
                                                                    width: 15)
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      )
                                    : GetBuilder<MessageController>(
                                        id: "message",
                                        builder: (controller) {
                                          if (controller
                                              .getFriendIdList()
                                              .isEmpty) {
                                            return const Text(
                                                "No Result Found");
                                          }
                                          return StreamBuilder<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                /*   .where('id',
                                                  whereIn: controller
                                                      .getFriendIdList())*/
                                                .snapshots(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData == false) {
                                                return const SizedBox();
                                              }
                                              return snapshot.data!.docs.isEmpty
                                                  ? const Text(
                                                      "No Result Found")
                                                  : SizedBox(
                                                      height: Get.height * 0.53,
                                                      child: ListView.builder(
                                                        padding:
                                                            EdgeInsets.all(0),
                                                        itemCount: snapshot
                                                            .data!.docs.length,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          if (snapshot.data!
                                                                      .docs[index]
                                                                      .data()[
                                                                  'uid'] ==
                                                              controller
                                                                  .userUid) {
                                                            return const SizedBox();
                                                          } else if (controller
                                                              .friendList
                                                              .where((element) =>
                                                                  element.id
                                                                      .toString() ==
                                                                  snapshot
                                                                      .data!
                                                                      .docs[
                                                                          index]
                                                                      .data()[
                                                                          'id']
                                                                      .toString())
                                                              .isEmpty) {
                                                            return const SizedBox();
                                                          } else if ((snapshot
                                                                  .data!
                                                                  .docs[index]
                                                                  .data()[
                                                                      'email']
                                                                  .toString()
                                                                  .trim()
                                                                  .toString()
                                                                  .toLowerCase()
                                                                  .contains(controller
                                                                      .msgController
                                                                      .text)) ||
                                                              (snapshot.data!
                                                                  .docs[index]
                                                                  .data()[
                                                                      'name']
                                                                  .toString()
                                                                  .trim()
                                                                  .toString()
                                                                  .toLowerCase()
                                                                  .contains(controller
                                                                      .msgController
                                                                      .text))) {
                                                            return InkWell(
                                                              onTap: () {
                                                                controller.gotoChatScreen(
                                                                    context,
                                                                    snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .data()[
                                                                        'uid'],
                                                                    snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .data()[
                                                                        'name'],
                                                                    snapshot
                                                                            .data!
                                                                            .docs[
                                                                                index]
                                                                            .data()[
                                                                        'image'],
                                                                    snapshot
                                                                        .data!
                                                                        .docs[
                                                                            index]
                                                                        .data()['UserToken']);
                                                              },
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        5),
                                                                child: Row(
                                                                  children: [
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      height:
                                                                          60,
                                                                      width: 60,
                                                                      decoration:
                                                                          const BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: snapshot.data!.docs[index].data()['image'].toString() ==
                                                                              ""
                                                                          ? ClipRRect(
                                                                              borderRadius: BorderRadius.circular(50),
                                                                              child: Image.asset(AssetRes.portraitPlaceholder),
                                                                            )
                                                                          : ClipRRect(
                                                                              borderRadius: const BorderRadius.all(
                                                                                Radius.circular(
                                                                                  50,
                                                                                ),
                                                                              ),
                                                                              child: FadeInImage(
                                                                                placeholder: const AssetImage(
                                                                                  AssetRes.portraitPlaceholder,
                                                                                ),
                                                                                image: NetworkImage(
                                                                                  snapshot.data!.docs[index].data()['image'].toString(),
                                                                                ),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            5),
                                                                    Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        snapshot.data!.docs[index].data()['name'].toString().isEmpty
                                                                            ? const SizedBox()
                                                                            : Text(
                                                                                snapshot.data!.docs[index].data()['name'].toString(),
                                                                                style: sfProTextReguler(
                                                                                  fontSize: 17,
                                                                                ),
                                                                              ),
                                                                        /*Text(
                                                            "You:ok",
                                                            style: sfProTextReguler(
                                                                fontSize: 14,
                                                                color: ColorRes
                                                                    .colorF0F0F0),
                                                          )*/
                                                                      ],
                                                                    ),
                                                                    const Spacer(),
                                                                    Image.asset(
                                                                      AssetRes
                                                                          .read,
                                                                      height:
                                                                          16,
                                                                      width: 16,
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            15)
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          return const SizedBox();
                                                        },
                                                      ),
                                                    );
                                            },
                                          );
                                        },
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.apiLoader
                      ? const FullScreenLoader()
                      : const SizedBox(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

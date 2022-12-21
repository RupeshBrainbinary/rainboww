import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rainbow_new/common/Widget/loaders.dart';
import 'package:rainbow_new/common/Widget/text_styles.dart';
import 'package:rainbow_new/model/post_comment_list_model.dart';
import 'package:rainbow_new/screens/Home/comments/comments_controller.dart';
import 'package:rainbow_new/screens/Home/comments/widget/user_comment.dart';
import 'package:rainbow_new/utils/asset_res.dart';
import 'package:rainbow_new/utils/color_res.dart';
import 'package:rainbow_new/utils/strings.dart';
PostCommentListModel postCommentListModelMirror = PostCommentListModel();
class CommentScreen extends StatelessWidget {
  final String? idPost;
  final String? profileImage;
  final String? fullName;

  CommentScreen({this.idPost, this.profileImage, this.fullName, Key? key})
      : super(key: key);
  final CommentsController controller = Get.put(CommentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GetBuilder<CommentsController>(
            id: "commentPost",
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  controller.clearNameCommentOnTap();
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    AssetRes.backIcon,
                    height: 16,
                    width: 37,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
          title: Text(
            "Comments",
            style: beVietnamProBoldTextStyle(
              fontSize: 16,
              color: ColorRes.black,
            ),
          ),
          backgroundColor: ColorRes.white,
          elevation: 1,
        ),
        backgroundColor: ColorRes.white,
        body: SafeArea(
          child: GetBuilder<CommentsController>(
            id: "commentPost",
            builder: (controller) {
              return Obx(() {
                return Stack(
                  children: [
                    // (controller.loader.value == true)
                    //     ? Container(
                    //         // height: Get.height,
                    //         // width: Get.width,
                    //         // color: ColorRes.white,
                    //       )
                    //     :
                    commentList(context),
                    controller.refreshLoader.isFalse && controller.loader.isTrue
                        ? const FullScreenLoaderWhiteBack()
                        : const SizedBox()
                  ],
                );
              });
            },
          ),
        ));
  }

  Widget commentList(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => controller.onRefreshCode(idPost.toString()),
            child: Stack(
              children: [
                controller.commloader.isTrue?
                ListView.separated(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return userComment(
                        image:postCommentListModelMirror.data![index].postCommentItem
                            .toString(),
                        description:postCommentListModelMirror.data![index].description
                            .toString(),
                        fullName: postCommentListModelMirror.data![index]
                            .postCommentUser!.fullName
                            .toString(),
                        profileImage: postCommentListModelMirror.data![index]
                            .postCommentUser!.profileImage
                            .toString(),
                        reply:postCommentListModelMirror.data![index].postCommentReply,
                        commentId: postCommentListModelMirror.data![index].id
                            .toString(),
                        date:
                        postCommentListModelMirror.data![index].createdAt);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: ColorRes.black.withOpacity(0.6),
                      height: 22,
                    );
                  },
                  itemCount: postCommentListModelMirror.data == null
                      ? 0
                      : postCommentListModelMirror.data!.length,
                )
                    :
                ListView.separated(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.only(
                      left: 19, right: 19, top: 12,),
                  itemBuilder: (context, index) {
                    return userComment(
                        image: postCommentListModel.data![index].postCommentItem
                            .toString(),
                        description: postCommentListModel.data![index].description
                            .toString(),
                        fullName: postCommentListModel.data![index]
                            .postCommentUser!.fullName
                            .toString(),
                        profileImage: postCommentListModel.data![index]
                            .postCommentUser!.profileImage
                            .toString(),
                        reply:postCommentListModel.data![index].postCommentReply,
                        commentId:postCommentListModel.data![index].id
                            .toString(),
                        date:
                            postCommentListModel.data![index].createdAt);
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: ColorRes.black.withOpacity(0.6),
                      height: 22,
                    );
                  },
                  itemCount: postCommentListModel.data == null
                      ? 0
                      : postCommentListModel.data!.length,
                ),
                controller.refreshLoader.isFalse && controller.commloader.isTrue
                    ? Center(child: const CircularProgressIndicator(color: Colors.grey,))
                    : const SizedBox()
              ],
            ),
          ),
        ),
        controller.imageForCamera == null
            ? const SizedBox()
            : Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(controller.imageForCamera!))),
              ),
        Container(
          width: Get.width,
          decoration: BoxDecoration(color: ColorRes.white, boxShadow: [
            BoxShadow(
              color: ColorRes.black.withOpacity(0.5),
              blurRadius: 15.0,
              offset: const Offset(-10, 10),
            )
          ]),
          padding: const EdgeInsets.only(
            left: 19,
            right: 12,
            top: 10,
            bottom: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      text:
                          'Replying to ${controller.nameComment == null ? "" : controller.nameComment.toString()}...',
                      style: beVietnamProRegularTextStyle(
                        fontSize: 14,
                        color: ColorRes.black,
                      ),
                      children: [
                        TextSpan(
                          text: "",
                          style: beVietnamProMediumTextStyle(
                            color: ColorRes.themeColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  controller.nameComment == null ||
                          controller.nameComment!.isEmpty
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            controller.clearNameCommentOnTap();
                          },
                          child: Container(
                              height: 22,
                              width: 22,
                              decoration: const BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 20,
                              )),
                        )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      controller.navigateToCamera();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5, top: 15),
                      child: Image.asset(
                        AssetRes.commentCamera,
                        height: 22,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      controller.navigateToGallery();
                    },
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 15.0, right: 5, top: 15),
                      child: Image.asset(
                        AssetRes.commentGallery,
                        height: 22,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.only(left: 5, top: 7),
                      padding: const EdgeInsets.only(
                          left: 7, top: 7, bottom: 7, right: 7),
                      decoration: BoxDecoration(
                        color: ColorRes.black.withOpacity(0.05),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.msgController,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.only(top: 0, bottom: 12),
                                border: InputBorder.none,
                                hintText: Strings.typeYourReply,
                                hintStyle: sfProTextReguler(
                                  fontSize: 17,
                                  color: ColorRes.black.withOpacity(0.40),
                                ),
                              ),
                              style: sfProTextReguler(
                                fontSize: 17,
                                color: ColorRes.black,
                              ),
                              textInputAction: TextInputAction.newline,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              controller.onTapSendMsg(
                                  context, idPost.toString());
                              FocusScope.of(context).unfocus();
                              controller.clearNameCommentOnTap();
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 5, bottom: 5),
                              child: Image.asset(
                                AssetRes.commentSend,
                                height: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

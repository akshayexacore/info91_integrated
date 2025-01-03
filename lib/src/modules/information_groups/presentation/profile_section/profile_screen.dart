import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/modules/information_groups/presentation/profile_section/add_members.dart';
import 'package:info91/src/modules/information_groups/presentation/profile_section/banners_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/gallery_view_screen/gfallery_view_screen.dart';

import 'package:info91/src/modules/information_groups/presentation/profile_section/controller/profile_controller.dart';

import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/gallery_page.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/utils/app_formatter.dart';
import 'package:info91/src/widgets/custom/custom_circle_image.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/custom_image_card.dart';
import '../widgets/profile_top_image_sec.dart';

class ProfileScreen extends StatefulWidget {
  final String selectedGroupId;
  final GroupProfileModel model;
  const ProfileScreen(
      {super.key, required this.selectedGroupId, required this.model});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final InfoProfileController controller = Get.put(InfoProfileController());

  @override
  void initState() {
    if (widget.model.id == null) {
      controller.getGroupInfoDetails(widget.selectedGroupId);
    } else {
      controller.profilledataModel.value = widget.model;
    }

    controller.groupId = widget.selectedGroupId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            return Skeletonizer(
              enabled: controller.isLoading.value,
              child: CustomAppBar(
                imageUrl: controller.profilledataModel.value.profileImage,
                isPic: true,
                actionWidget: [
                  CustomPopupmenu(
                    onSelected: (val) {
                      controller.popupMenuSelectionFun(val);
                    },
                    itemList: controller.popuMenuList,
                  )
                ],
                onBackButtonPress: () {
                  Navigator.pop(context, controller.profilledataModel.value);
                },
                appBarName: controller.profilledataModel.value.groupName ?? "",
              ),
            );
          }),
          Expanded(
            child: SingleChildScrollView(
              child: Obx(() {
                return Skeletonizer(
                  enabled: controller.isLoading.value,
                  child: Column(
                    children: [
                      appbarSec(),
                      SizedBox(
                        height: 40.h,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: marginWidth),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                greyBoldText(
                                    controller.profilledataModel.value
                                            .groupName ??
                                        "",
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.text,
                                    size: 16.sp),
                                SizedBox(
                                  height: 9.h,
                                ),
                                blusHeading("About Us"),
                                SizedBox(
                                  height: 9.h,
                                ),
                                greyBoldText(
                                    controller
                                            .profilledataModel.value.purpose ??
                                        "",
                                    color: AppColors.text,
                                    fontWeight: FontWeight.w400,
                                    size: 15.sp),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Text(
                                  "Created by ${controller.profilledataModel.value.createdBy}/${AppFormatter.formatStringDateToDyMMMMd(widget.model.createdAt ?? "")}",
                                  style: const TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                SizedBox(
                                  height: 13.h,
                                ),
                                blusHeading("Media"),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 100.h,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>SizedBox(width:.5.w,),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      print(
                                          "ccccccc${controller.totalMediaList[index].type}");
                                      return mediaSection(
                                        controller.totalMediaList[index],
                                        index,
                                      );
                                    },
                                    itemCount: (controller
                                                    .totalMediaList.length ??
                                                0) <
                                            3
                                        ? (controller.totalMediaList.length ??
                                            0)
                                        : 3,
                                  ),
                                ),
                                // SizedBox(
                                //   height: 100.h,
                                //   child: ListView.builder(
                                //     scrollDirection: Axis.horizontal,
                                //     itemBuilder: (context, index) =>
                                //         customImageCard(
                                //       index: index,
                                //       imageCount: controller
                                //               .profilledataModel
                                //               .value
                                //               .mediaList
                                //               ?.imageList
                                //               ?.length ??
                                //           0,
                                //       imageUrl: controller
                                //               .profilledataModel
                                //               .value
                                //               .mediaList
                                //               ?.imageList?[index]
                                //               .message ??
                                //           "",
                                //       width: 110.w,
                                //       onImageTap: () {
                                //         Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //               builder: (context) =>
                                //                   GaleryViewScreen(
                                //                 mediaModel: controller
                                //                     .profilledataModel
                                //                     .value
                                //                     .mediaList!,
                                //               ),
                                //             ));
                                //       },
                                //     ),
                                //     itemCount: (controller
                                //                     .profilledataModel
                                //                     .value
                                //                     .mediaList
                                //                     ?.imageList
                                //                     ?.length ??
                                //                 0) <
                                //             3
                                //         ? (controller.profilledataModel.value
                                //                 .mediaList?.imageList?.length ??
                                //             0)
                                //         : 3,
                                //   ),
                                // ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomArrowTextbutton(
                                        buttonName: "Group info",
                                        onTap: () {
                                          Get.toNamed('/group_info',
                                              arguments: {
                                                "group_id":
                                                    widget.selectedGroupId,
                                              });

                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //       builder: (context) => GroupInfo(),
                                          //     ));
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15.w,
                                    ),
                                    if (controller
                                            .profilledataModel.value.isAdmin ==
                                        true)
                                      Expanded(
                                        child: CustomArrowTextbutton(
                                          buttonName: "Add Banners",
                                          onTap: () {
                                            Get.toNamed(BannersScreen.routeName,
                                                arguments: {
                                                  "group_id":
                                                      widget.selectedGroupId,
                                                  "isUpdate": false
                                                })?.then((value) {
                                              controller.getGroupInfoDetails(
                                                  widget.selectedGroupId);
                                            });

                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) => GroupInfo(),
                                            //     ));
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(
                                  height: 14.h,
                                ),
                                if (controller.profilledataModel.value.banners
                                        ?.isNotEmpty ==
                                    true) ...[
                                  blusHeading("Banners"),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  BannersImageView(
                                      onTap: (index) {
                                        print("controller.profilledataModel.valueisAdmin${controller.profilledataModel.value
                                                .isAdmin } ");
                                        if (controller.profilledataModel.value
                                                .isAdmin ==
                                            true) {
                                          Get.toNamed(BannersScreen.routeName,
                                              arguments: {
                                                "group_id":
                                                    widget.selectedGroupId,
                                                "isUpdate": true,
                                                "model": controller
                                                    .profilledataModel
                                                    .value
                                                    .banners![index]
                                              })?.then((value) {
                                            controller.getGroupInfoDetails(
                                                widget.selectedGroupId);
                                          });
                                        }
                                      },
                                      imageList: controller.profilledataModel
                                              .value.banners?.reversed
                                              .toList() ??
                                          []),
                                ],

                                SizedBox(
                                  height: 15.h,
                                ),
                                blusHeading("Group Members"),
                                SizedBox(
                                  height: 8.h,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12.h, horizontal: marginWidth),
                            color: AppColors.primary.withOpacity(.1),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                greynonBoldText(
                                    "${controller.profilledataModel.value.memberCount ?? 0} members",
                                    size: 13.sp),
                                SizedBox(
                                  height: 10.h,
                                ),
                                if (controller
                                        .profilledataModel.value.isAdmin ==
                                    true)
                                  TextButton.icon(
                                    onPressed: () {
                                      Get.toNamed(AddMembersScreen.routeName,
                                          arguments: {
                                            "group_id": controller.groupId
                                          })?.then((value) {
                                        controller.getGroupInfoDetails(
                                            controller.groupId);
                                      });
                                    },
                                    label: blusHeading("Add Members"),
                                    icon: const Icon(
                                      Icons.add,
                                      color: AppColors.secondary,
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                  ),
                                SizedBox(
                                  height: 8.h,
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const ScrollPhysics(),
                                    itemBuilder: (context, index) => ListTile(
                                        contentPadding: EdgeInsets.zero,
                                        leading: circle_image(name:  controller
                                                  .profilledataModel
                                                  .value
                                                  .members?[index]
                                                  .name ??
                                              "",
                                          avatarUrl: controller
                                                  .profilledataModel
                                                  .value
                                                  .members?[index]
                                                  .image ??
                                              "",
                                          onTap: () {
                                            Navigator.push(
                                              Get.context!,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    GalleryPhotoViewWrapper(
                                                      
                                                  galleryItems: [
                                                    GalleryItem(
                                                        id: "id:1",
                                                        resource: controller
                                                                .profilledataModel
                                                                .value
                                                                .members?[index]
                                                                .image ??
                                                            "")
                                                  ],
                                                  backgroundDecoration:
                                                      const BoxDecoration(
                                                    color: Colors.black,
                                                  ),
                                                  initialIndex: 0,
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        title: Text(
                                          controller.profilledataModel.value
                                                  .members?[index].name ??
                                              "",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: SizedBox(
                                            width: 400.w,
                                            child: Text(
                                              controller.profilledataModel.value
                                                      .members?[index].about ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        trailing: controller.profilledataModel
                                                    .value.isAdmin ==
                                                false
                                            ? (controller
                                                            .profilledataModel
                                                            .value
                                                            .members?[index]
                                                            .role ??
                                                        "") ==
                                                    "1"
                                                ? Text(
                                                    "Admin",
                                                    style: TextStyle(
                                                        color: Colors.orange,
                                                        fontSize: 13.sp),
                                                  )
                                                : const Icon(Icons.more_vert)
                                            : CustomPopupmenu(
                                                iconWidget: (controller
                                                                .profilledataModel
                                                                .value
                                                                .members?[index]
                                                                .role ??
                                                            "") ==
                                                        "1"
                                                    ? Text(
                                                        "Admin",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.orange,
                                                            fontSize: 13.sp),
                                                      )
                                                    : const Icon(
                                                        Icons.more_vert),
                                                iconColr: AppColors.primary,
                                                onSelected: (value) {
                                                  value == 0
                                                      ? controller.removeMember(
                                                          value,
                                                          controller
                                                              .profilledataModel
                                                              .value
                                                              .members![index])
                                                      : controller.memberpopuFunction(
                                                          value,
                                                          controller
                                                              .profilledataModel
                                                              .value
                                                              .members![index]);
                                                },
                                                itemList: [
                                                    popupMenuModel(
                                                        name: "Remove",
                                                        value: 0),
                                                    popupMenuModel(
                                                        name: controller
                                                                    .profilledataModel
                                                                    .value
                                                                    .members?[
                                                                        index]
                                                                    .role ==
                                                                "1"
                                                            ? "Dismiss as admin"
                                                            : "Make group admin ",
                                                        value: 1),
                                                  ])),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(
                                          height: 5,
                                        ),
                                    itemCount: controller.profilledataModel
                                            .value.members?.length ??
                                        0)
                              ],
                            ),
                          ),
                          bottomSec()
                        ],
                      )
                    ],
                  ),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  Container bottomSec() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: marginWidth, vertical: 5),
      height: 100,
      width: double.infinity,
      color: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
            onPressed: () {},
            label: blusHeading("Mute this Group"),
            icon: const Icon(
              Icons.notifications_off,
              color: AppColors.secondary,
            ),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          // SizedBox(height:5.h,),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: customTextButton(
              "Exit Group",
              onTap: () {
                controller.leaveInfoGoupAPi();
              },
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: AppColors.red,
                  fontSize: 15.sp),
            ),
          )
        ],
      ),
    );
  }

  Widget mediaSection(MediaItem media, int index) {
    return media.type == "image"
        ? CustomImageCard(
            index: index,
            onPicTap: () {
              Navigator.push(
                Get.context!,
                MaterialPageRoute(
                  builder: (context) => GalleryPhotoViewWrapper(
                              headingText: controller.totalMediaList[index].name ,
                    subHeadingText:AppFormatter.formatStringDayDateStringWithTime(controller.totalMediaList[index].createdAt??""),
                    galleryItems: [
                      GalleryItem(
                          id: "id:1",
                          resource:
                              controller.totalMediaList.value[index].message ??
                                  "")
                    ],
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    initialIndex: 0,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              );
            },
            imageCount: controller.totalMediaList.length ?? 0,
            imageUrl: media.message ?? "",
            width: 110.w,
            onImageTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GaleryViewScreen(
                      mediaModel: controller.profilledataModel.value.mediaList!,
                    ),
                  ));
            },
          )
        : media.type == "audio"
            ? CustomMediaAudioCard(
                index: index,
                duration:"ss" ,
                imageCount: controller.totalMediaList.length ?? 0,
               imageUrl: media.message ?? "",
                width: 110.w,
                   onPicTap: () {
              Navigator.push(
                Get.context!,
                MaterialPageRoute(
                  builder: (context) => GalleryPhotoViewWrapper(
                    headingText: controller.totalMediaList[index].name ,
                    subHeadingText:AppFormatter.formatStringDayDateStringWithTime(controller.totalMediaList[index].createdAt??"") ,
                    galleryItems: [
                      GalleryItem(
                          id: "id:1",
                          isAudio: true,
                        
                          resource:
                              controller.totalMediaList.value[index].message ??
                                  "")
                    ],
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    initialIndex: 0,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              );
            },
                onImageTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GaleryViewScreen(
                          mediaModel:
                              controller.profilledataModel.value.mediaList!, 
                        ),
                      ));
                },
              )
            :media.type == "video"
            ? CustomMediaVideoCard(
                index: index,
                duration:"ss" ,
                imageCount: controller.totalMediaList.length ?? 0,
               videoUrl: media.message ?? "",
                width: 110.w,
                   onPicTap: () {
              Navigator.push(
                Get.context!,
                MaterialPageRoute(
                  builder: (context) => GalleryPhotoViewWrapper(
                    headingText: controller.totalMediaList[index].name ,
                    subHeadingText:AppFormatter.formatStringDayDateStringWithTime(controller.totalMediaList[index].createdAt??"") ,
                    galleryItems: [
                      GalleryItem(
                          id: "id:1",
                          isVideo: true,
                        
                          resource:
                              controller.totalMediaList.value[index].message ??
                                  "")
                    ],
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.black,
                    ),
                    initialIndex: 0,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              );
            },
                onImageTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GaleryViewScreen(
                          mediaModel:
                              controller.profilledataModel.value.mediaList!, 
                        ),
                      ));
                },
              ):Container();
  }

  ProfileTopImageSec appbarSec() {
    return ProfileTopImageSec(
      isAdmin: controller.profilledataModel.value.isAdmin ?? false,
      profileImage: controller.profilledataModel.value.profileImage ?? "",
      groupame:  controller.profilledataModel.value.groupName??"" ,

      profileViewOnTap: () {
        Navigator.push(
          Get.context!,
          MaterialPageRoute(
            builder: (context) => GalleryPhotoViewWrapper(
              galleryItems: [
                GalleryItem(
                    id: "id:1",
                    resource:
                        controller.profilledataModel.value.profileImage ?? "")
              ],
              backgroundDecoration: const BoxDecoration(
                color: Colors.black,
              ),
              initialIndex: 0,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
      onCoverChange: () {
        controller.showUploadOptions(isCrop: false);
      },
      onProfileChange: () {
        controller.showUploadOptions(isCrop: true);
      },
      backGroundImage: controller.profilledataModel.value.coverImage ?? "",
    );
  }
}

void _showOptions(BuildContext context, Offset position, String memberName) {
  showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      MediaQuery.of(context).size.width - position.dx,
      MediaQuery.of(context).size.height - position.dy,
    ),
    items: [
      const PopupMenuItem(
        value: 'Make Admin',
        child: Row(
          children: [
            Icon(Icons.admin_panel_settings, color: Colors.blue),
            SizedBox(width: 10),
            Text('Make Admin'),
          ],
        ),
      ),
      const PopupMenuItem(
        value: 'Remove Member',
        child: Row(
          children: [
            Icon(Icons.delete, color: Colors.red),
            SizedBox(width: 10),
            Text('Remove Member'),
          ],
        ),
      ),
    ],
  ).then((value) {
    if (value == 'Make Admin') {
      // controller.makeAdmin(memberName);
    } else if (value == 'Remove Member') {}
  });
}

class BannersImageView extends StatelessWidget {
  final List<BannerModel> imageList;
  final Function? onTap;

  BannersImageView({
    super.key,
    required this.imageList,
    this.onTap,
  });
  final PageController _pageController = PageController(
      viewportFraction: 1,
      keepPage: false // Set this to less than 1.0 to show the next page
      );
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 210.h,
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: imageList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(right: 10.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImageCard(
                  width: double.infinity,
                  height: 150.h,
                  onPicTap:() {
                  print("clicking here");
                  if (onTap != null) {
                    onTap!(index);
                  }
                },
                  imageUrl: imageList[index].image ?? "",
                ),
                SizedBox(
                  height: 10.h,
                ),
                greynonBoldText(imageList[index].title ?? "",
                    fontWeight: FontWeight.w500,
                    size: 15.sp,
                    overFlow: TextOverflow.ellipsis,
                    color: AppColors.text),
                SizedBox(
                  height: 5.h,
                ),
                SizedBox(
                  width: 400.w,
                  child: Text(
                    imageList[index].description ?? "",
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 13.sp, overflow: TextOverflow.ellipsis),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

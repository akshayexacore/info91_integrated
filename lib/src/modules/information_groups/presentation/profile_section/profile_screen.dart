import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/gallery_view_screen/gfallery_view_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/group_info/group_info_screen.dart';

import 'package:info91/src/modules/information_groups/presentation/profile_section/profile_setting_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_circle_image.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';

import '../widgets/custom_image_card.dart';
import '../widgets/profile_top_image_sec.dart';

class ProfileScreen extends StatelessWidget {
  final String selectedGroupId;
  final GroupProfileModel model;
  ProfileScreen(
      {super.key, required this.selectedGroupId, required this.model});
  List<popupMenuModel> listModel = [
    popupMenuModel(name: "Group Setting", value: 1)
  ];
  List<String> MediaList = [
    "https://th.bing.com/th?id=OIP.k-XpRF0EIqlEln1_STXlOAHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.6&pid=3.1&rm=2",
    "https://th.bing.com/th?id=OIP.k-XpRF0EIqlEln1_STXlOAHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.6&pid=3.1&rm=2",
    "https://th.bing.com/th?id=OIP.k-XpRF0EIqlEln1_STXlOAHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.6&pid=3.1&rm=2",
    "https://th.bing.com/th?id=OIP.k-XpRF0EIqlEln1_STXlOAHaE8&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.6&pid=3.1&rm=2",
  ];

  @override
  Widget build(BuildContext context) {
    print("ddddd$selectedGroupId");
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            imageUrl: model.profileImage,
            actionWidget: [
              CustomPopupmenu(
                onSelected: (val) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSettingScreen(),
                      ));
                },
                itemList: listModel,
              ),
            ],
            appBarName: model.groupName ?? "",
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileTopImageSec(
                    profileImage: model.profileImage ?? "",
                    backGroundImage: model.coverImage ?? "",
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: marginWidth),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        greyBoldText(model.groupName ?? "",
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                            size: 16.sp),
                        SizedBox(
                          height: 10.h,
                        ),
                        blusHeading("About Us"),
                        SizedBox(
                          height: 10.h,
                        ),
                        greyBoldText(model.purpose ?? "",
                            color: AppColors.text, size: 15.sp),

                        SizedBox(
                          height: 15.h,
                        ),
                        Text(
                          model.createdAt ?? "",
                          style: TextStyle(color: Colors.grey),
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
                        Container(
                          height: 100.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => customImageCard(
                              index: index,
                              imageCount: MediaList.length,
                              imageUrl: MediaList[index],
                              width: 110.w,
                              onImageTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GaleryViewScreen(
                                        imageList: MediaList,
                                      ),
                                    ));
                              },
                            ),
                            itemCount:
                                MediaList.length < 3 ? MediaList.length : 3,
                          ),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        CustomArrowTextbutton(
                          buttonName: "Group info",
                          onTap: () {
                            Get.toNamed('/group_info',
                                arguments: {"group_id": selectedGroupId});
                            ;
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => GroupInfo(),
                            //     ));
                          },
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        blusHeading("Banners"),
                        SizedBox(
                          height: 5.h,
                        ),
                        BannersImageView(imageList: model.banners ?? []),
                        SizedBox(
                          height: 5.h,
                        ),
                        blusHeading("Group Members"),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              greynonBoldText("${model.memberCount} members"),
                              SizedBox(
                                height: 10.h,
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemBuilder: (context, index) => ListTile(
                                        leading: circle_image(
                                          "https://randomuser.me/api/portraits/women/1.jpg",
                                          onTap: () {},
                                        ),
                                        title: Text(
                                          model.members?[index].name ?? "",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: SizedBox(
                                            width: 400.w,
                                            child: Text(
                                              model.members?[index].status ??
                                                  "",
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                        trailing: Text(
                                          "Admin",
                                          style: TextStyle(
                                              color: Colors.orange,
                                              fontSize: 13.sp),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                        height: 5,
                                      ),
                                  itemCount: model.members?.length ?? 0)
                            ],
                          ),
                        )
                        // Container(
                        //   color: Colors.red,
                        //   height: 55,
                        //   child: ListView.builder(
                        //     itemBuilder: (context, index) => Container(
                        //         child: Column(
                        //       children: [
                        //         Container(
                        //             height: 50.h,
                        //             width: 40.w,
                        //             child: Image.network(
                        //                 "https://th.bing.com/th?id=OIP.qn_LIjRBjyml3lSSiw6oHwHaE7&w=306&h=204&c=8&rs=1&qlt=90&o=6&dpr=1.5&pid=3.1&rm=2"))
                        //       ],
                        //     )),
                        //   ),
                        // )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BannersImageView extends StatelessWidget {
  final List<BannerModel> imageList;

  BannersImageView({
    super.key,
    required this.imageList,
  });
  final PageController _pageController = PageController(
      viewportFraction: 0.95,
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
                customImageCard(
                  width: double.infinity,
                  height: 150.h,
                  imageUrl: imageList[index].image ?? "",
                ),
                SizedBox(
                  height: 5.h,
                ),
                greynonBoldText(imageList[index].title ?? ""),
                SizedBox(
                  height: 5.h,
                ),
                greynonBoldText(imageList[index].description ?? ""),
              ],
            ),
          ),
        ));
  }
}

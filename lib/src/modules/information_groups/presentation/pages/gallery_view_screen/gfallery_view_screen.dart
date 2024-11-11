import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/gallery_view_screen/gallery_view_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/gallery_view_screen/video_display_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_image_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';

import '../../widgets/texts.dart';

class GaleryViewScreen extends StatefulWidget {
  final MediaList mediaModel;
  const GaleryViewScreen({super.key, required this.mediaModel});

  @override
  State<GaleryViewScreen> createState() => _GaleryViewScreenState();
}

class _GaleryViewScreenState extends State<GaleryViewScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  final GelleryViewContorller _galleryController =
      Get.put(GelleryViewContorller());

  // List<Widget>imageViewList=[
  //   imageViewSection(),
  // ];

  @override
  void initState() {
    _controller = TabController(
        length: _galleryController.mediaTypeList.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        const CustomAppBar(appBarName: "Media"),
        SizedBox(
          height: 8.h,
        ),
        DefaultTabController(
          length: _galleryController.mediaTypeList.length,
          child: TabBar(
            controller: _controller,
            isScrollable: true,
            padding: EdgeInsets.zero,
            splashFactory: NoSplash.splashFactory,
            indicatorPadding:
                const EdgeInsets.symmetric(horizontal: 7.0, vertical: 9),
            labelStyle: const TextStyle(
                color: AppColors.secondary, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
            indicator: BoxDecoration(
              color: Colors.orange.withOpacity(.1),
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            tabs: _galleryController.mediaTypeList
                .map((e) => Tab(child: Text(e)))
                .toList(),
          ),
        ),
        Expanded(
          child: TabBarView(controller: _controller, children: [
            imageViewSection(),
            imageViewSection(isVideo: true),
            linksViewSection(),
            docsViewSection(widget.mediaModel.documentList ?? []),
          ]),
        )
      ],
    );
  }

  Widget imageViewSection({bool isVideo = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.mediaModel.imageList?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
        ),
        itemBuilder: (context, index) => customImageCard(
          imageUrl: widget.mediaModel.imageList?[index].message ?? "",
          isVideo: isVideo,
          onImageTap: () {
            Get.to(() => VideoPlayerScreen());
          },
        ),
      ),
    );
  }

  Widget linksViewSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 100,
          itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0)
                    Text(
                      "Today",
                      style: chatTextstyle,
                    ),
                  if (index == 3)
                    Text(
                      "Yesterday",
                      style: chatTextstyle,
                    ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 55.w,
                      height: 40.h,
                      color: AppColors.dividerlight,
                      child: const Center(
                          child: Icon(
                        Icons.link,
                        color: AppColors.text,
                      )),
                    ),
                    title: SizedBox(
                        width: 300.w,
                        child: Text(
                          "https://www.example.com",
                          style: TextStyle(overflow: TextOverflow.ellipsis),
                        )),
                  ),
                ],
              )),
    );
  }

  Widget docsViewSection(List<MediaItem> docList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: docList.length,
          itemBuilder: (context, index) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (index == 0)
                    Text(
                      "Today",
                      style: chatTextstyle,
                    ),
                  if (index == 2)
                    Text(
                      "Yesterday",
                      style: chatTextstyle,
                    ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading:
                        //  Image.asset("assets/images/docs.png"),
                        SizedBox(
                      width:
                          40, // Control the width to reduce the gap between leading and title
                      child: docList[index].filetype == "jpg" ||  docList[index].filetype=="png"
                          ? const Icon(
                              Icons.image,
                              size: 24, 
                            ):docList[index].filetype =="pdf"?const Icon(
                              Icons.picture_as_pdf,
                              size: 24, 
                            )
                          : docList[index].filetype =="video"
                              ? const Icon(
                                  Icons.video_library,
                                  size: 24,
                                )
                              : docList[index].filetype == "audio"
                                  ? const Icon(
                                      Icons.mic,
                                      size: 24, 
                                    )
                                  : docList[index].filetype == "document"
                                      ?const Icon(
                                          Icons.file_copy,
                                          size:
                                              24, 
                                        )
                                      :const SizedBox(),
                    ),
                    title: SizedBox(
                        width: 300.w,
                        child: Text(
                          docList[index].message ?? "",
                          style:const TextStyle(overflow: TextOverflow.ellipsis),
                        )),
                    subtitle: Row(
                      children: [
                        if (docList[index].filetype == "pdf")
                          Text(
                            docList[index].filepages.toString(),
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        Text(
                          docList[index].filesize ?? "",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        Text(
                          " .  ${docList[index].filetype ?? ""}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      const  Spacer(),
                        Text(
                          docList[index].date ?? "",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/gallery_view_screen/gallery_view_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/gallery_view_screen/video_display_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/VideoPlayerScreen2.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_image_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/gallery_page.dart';
import 'package:info91/src/utils/app_formatter.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

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
  String? thumbnailPath;
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


  Future<void> generateThumbnail(String url) async {
    try {
      final path = await VideoThumbnail.thumbnailFile(
        video:url, // Replace with a valid URL
        imageFormat: ImageFormat.PNG,
        maxWidth:230,
        quality: 75,
      );
      
        thumbnailPath = path;
     
    } catch (e) {
      print("Error generating thumbnail: $e");
    }
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
            videoViewSection(),
            // linksViewSection(),
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
        itemCount:isVideo?widget.mediaModel.videoList?.length: widget.mediaModel.imageList?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
        ),
        itemBuilder: (context, index) {
          if(isVideo){
            generateThumbnail(widget.mediaModel.videoList?[index].message ??"");
          }
          return CustomImageCard(
          imageUrl:(isVideo) ? (widget.mediaModel.videoList?[index].message ?? "") : (widget.mediaModel.imageList?[index].message ?? ""),
          onImageTap: () {
            if(isVideo) {
              Get.to(() => VideoPlayerScreen());
            }
          },
        );}
      ),
    );
  }
  Widget videoViewSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount:widget.mediaModel.videoList?.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
        ),
        itemBuilder: (context, index) {
       
          
          return  VideoMessageBubble(
            isSender: false,
            videoDuration: "",
           height:  100.h,
              width: 170.w,
            videoPath: widget.mediaModel.videoList?[index].message ?? ""?? "", videoSize:  "",
            timestamp: "",
            onTap: () {
                Navigator.push(
                Get.context!,
                MaterialPageRoute(
                  builder: (context) => GalleryPhotoViewWrapper(
                    headingText:  widget.mediaModel.videoList?[index].name ,
                    subHeadingText:AppFormatter.formatStringDayDateStringWithTime( widget.mediaModel.videoList?[index].date??"") ,
                    galleryItems: [
                      GalleryItem(
                          id: "id:1",
                          isVideo: true,
                        
                          resource:
                              widget.mediaModel.videoList?[index].message ??
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
              
                //  Get.to(() => VideoPlayerScreen());
            },
            // videoPlayerController:
            //     VideoPlayerController.network(
            //   messageList[index].message ?? "",
            // ),
          );}
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

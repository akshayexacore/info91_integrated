import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/gallery_view_screen/gallery_view_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_image_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';

import '../../widgets/texts.dart';

class GaleryViewScreen extends StatefulWidget {
  final List<String> imageList;
  const GaleryViewScreen({super.key, required this.imageList});

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
                EdgeInsets.symmetric(horizontal: 7.0, vertical: 9),
            labelStyle: TextStyle(
                color: AppColors.secondary, fontWeight: FontWeight.bold),
            unselectedLabelStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
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
            imageViewSection(),
            imageViewSection(),
            docsViewSection(),
          ]),
        )
      ],
    );
  }

  Widget imageViewSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.imageList.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.w,
        ),
        itemBuilder: (context, index) => customImageCard(
          imageUrl: widget.imageList[index],
          onImageTap: () {},
        ),
      ),
    );
  }

  Widget docsViewSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: marginWidth, vertical: 15.h),
      child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          itemCount: 100,
          itemBuilder: (context, index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if(index==0)Text("Today",style: chatTextstyle,),
                  if(index==2)Text("Yesterday",style: chatTextstyle,),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.asset("assets/images/docs.png",height: 45.sp,fit: BoxFit.fitHeight,),
                    title: SizedBox(
                    
                      width: 300.w,
                      child: Text("File.pdf",style: TextStyle(overflow:TextOverflow.ellipsis ),)),
                    subtitle:const Text("2.9 MB"),
                  ),
                  
                ],
              )),
    );
  }
}

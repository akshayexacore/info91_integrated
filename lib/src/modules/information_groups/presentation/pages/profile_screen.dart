import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/gfallery_view_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/group_info_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/profile_setting_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_arrow_button.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/custom_circle_image.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';

import '../widgets/custom_image_card.dart';
import '../widgets/profile_top_image_sec.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  List<popupMenuModel> listModel = [
    popupMenuModel(name: "Group Setting", value: 1)
  ];
  List<String> MediaList = [
    "https://s3-alpha-sig.figma.com/img/c293/679f/a9d76f9e4f26a17ead029749476e8f6c?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VUpvHydKMhFGG8bh8kwwZiSxvweL7FvVNYssFvgmICqabLL9PCgD5RpCixwqAtdMUAziakWiIo3~jNtyEuV6o3pSTHAcaXvyhSd3YVUWkSzTIEO3jaii~9GLCR-zfjYPryWrvol3aKoYq4xu8z~CVdKc3PIgrim7kSZKVHH5Qumrv07drsYxqZ8U-sor3Oh7-STtxDrWBpTu3A-Bn3N-ABPEG9WJwoGWzl~l2wJDQLsTIzmyMUy8sFNzt1g7bqresi1C60fCU96l4IChCtmN~pUlvuyyJv49rNxR9NfctXBRK1pycCRMZVN-UQ2z0P6XzLGG3MwplrrfwJHULz--~g__",
    "https://s3-alpha-sig.figma.com/img/c293/679f/a9d76f9e4f26a17ead029749476e8f6c?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VUpvHydKMhFGG8bh8kwwZiSxvweL7FvVNYssFvgmICqabLL9PCgD5RpCixwqAtdMUAziakWiIo3~jNtyEuV6o3pSTHAcaXvyhSd3YVUWkSzTIEO3jaii~9GLCR-zfjYPryWrvol3aKoYq4xu8z~CVdKc3PIgrim7kSZKVHH5Qumrv07drsYxqZ8U-sor3Oh7-STtxDrWBpTu3A-Bn3N-ABPEG9WJwoGWzl~l2wJDQLsTIzmyMUy8sFNzt1g7bqresi1C60fCU96l4IChCtmN~pUlvuyyJv49rNxR9NfctXBRK1pycCRMZVN-UQ2z0P6XzLGG3MwplrrfwJHULz--~g__",
    "https://s3-alpha-sig.figma.com/img/c293/679f/a9d76f9e4f26a17ead029749476e8f6c?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VUpvHydKMhFGG8bh8kwwZiSxvweL7FvVNYssFvgmICqabLL9PCgD5RpCixwqAtdMUAziakWiIo3~jNtyEuV6o3pSTHAcaXvyhSd3YVUWkSzTIEO3jaii~9GLCR-zfjYPryWrvol3aKoYq4xu8z~CVdKc3PIgrim7kSZKVHH5Qumrv07drsYxqZ8U-sor3Oh7-STtxDrWBpTu3A-Bn3N-ABPEG9WJwoGWzl~l2wJDQLsTIzmyMUy8sFNzt1g7bqresi1C60fCU96l4IChCtmN~pUlvuyyJv49rNxR9NfctXBRK1pycCRMZVN-UQ2z0P6XzLGG3MwplrrfwJHULz--~g__",
    "https://s3-alpha-sig.figma.com/img/c293/679f/a9d76f9e4f26a17ead029749476e8f6c?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VUpvHydKMhFGG8bh8kwwZiSxvweL7FvVNYssFvgmICqabLL9PCgD5RpCixwqAtdMUAziakWiIo3~jNtyEuV6o3pSTHAcaXvyhSd3YVUWkSzTIEO3jaii~9GLCR-zfjYPryWrvol3aKoYq4xu8z~CVdKc3PIgrim7kSZKVHH5Qumrv07drsYxqZ8U-sor3Oh7-STtxDrWBpTu3A-Bn3N-ABPEG9WJwoGWzl~l2wJDQLsTIzmyMUy8sFNzt1g7bqresi1C60fCU96l4IChCtmN~pUlvuyyJv49rNxR9NfctXBRK1pycCRMZVN-UQ2z0P6XzLGG3MwplrrfwJHULz--~g__",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(
              imageUrl: "",
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
              appBarName: "Group Profile",
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ProfileTopImageSec(
                      profileImage:
                          "https://s3-alpha-sig.figma.com/img/35e8/9d9d/e5b9d1d23149590ef05ef35d5019c1af?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=do0mwMRfU6Z7wAuKFlRGTJViBJt8GoiZfHzEk0MPlGPdSOkQ827srEiWLy8FW7ffyI8Cna4kFN~arDN5bi5xiYyBK8dmaxhJAlUkvPk0tp31R0J~m75hgiyQgTiv2JdNTH2SDQy3cOROUD0TUU1eJNCXjNYvP93UMmMbb-0FWqBz36Rb1l9b9KdDKyqjiR126T5NDyPPVpAl0fBhHRXCbl4MdBg7kwsFIukg-KkqwXn7rJ147C2tXME2DszcHrsUOY6yheMFySd0oZyP-Fw7HzXbWaMGYgtwakC9nXd3ey3sjdaFF9apAKkBSV~KbzRBUMR9tX2Xuj5ls7itygeqYw__",
                      backGroundImage:
                          "https://s3-alpha-sig.figma.com/img/7eb1/5aa2/b39983facffc91323415afccde962741?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Ih2DM9CiJ6XpHCKoVfhYgmHeOEGdd3QlWBkiV0qIB70LqywdvITAlMwLHez0KqrXSVxhtW5Dvs4FxDiPu9KXqyVPLqlfW9rvlADuVkTJ9UqxW3G326kZTucPazfnfT1oM4e6fS~owGpmfwBk-PZ84un1RXjKXjjHvQ2MqmDPx7fW7nNEo6ujSNJLbwg8rahGoTGkxe0936nNb0-uJfmX5iivpbeIEdyaxi12gIFg8YrCIdTmVLGLH18n98IUXdb5JentY-3ZFZJwD2gTT3jvKElVbOQYNUZQkHZ9WTC~Lfoz~rCdwqIcGJKdy63CQ2KHqJNP8mzwyIc8MZ4w-K6uEw__",
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: marginWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          greyBoldText("Group Name",
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
                          greyBoldText(
                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. ",
                              color: AppColors.text,
                              size: 15.sp),

                          SizedBox(
                            height: 15.h,
                          ),
                          const Text(
                            "Created by arya/ 24 march 24",
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => GroupInfo(),
                                  ));
                            },
                          ),
                          SizedBox(
                            height: 14.h,
                          ),
                          blusHeading("Banners"),
                          SizedBox(
                            height: 5.h,
                          ),
                          BannersImageView(imageList: [
                            "https://s3-alpha-sig.figma.com/img/c293/679f/a9d76f9e4f26a17ead029749476e8f6c?Expires=1728864000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=VUpvHydKMhFGG8bh8kwwZiSxvweL7FvVNYssFvgmICqabLL9PCgD5RpCixwqAtdMUAziakWiIo3~jNtyEuV6o3pSTHAcaXvyhSd3YVUWkSzTIEO3jaii~9GLCR-zfjYPryWrvol3aKoYq4xu8z~CVdKc3PIgrim7kSZKVHH5Qumrv07drsYxqZ8U-sor3Oh7-STtxDrWBpTu3A-Bn3N-ABPEG9WJwoGWzl~l2wJDQLsTIzmyMUy8sFNzt1g7bqresi1C60fCU96l4IChCtmN~pUlvuyyJv49rNxR9NfctXBRK1pycCRMZVN-UQ2z0P6XzLGG3MwplrrfwJHULz--~g__"
                          ]),
                          SizedBox(
                            height: 5.h,
                          ),
                          blusHeading("Group Members"),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                greynonBoldText("1k members"),
                                SizedBox(
                                  height: 10.h,
                                ),
                                ListTile(
                                  leading: circle_image(
                                    "https://randomuser.me/api/portraits/women/1.jpg",
                                    onTap: () {},
                                  ),
                                  title: const Text(
                                    "Arya",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: SizedBox(
                                      width: 400.w,
                                      child: const Text(
                                        "Creating My own sunshine in a world",
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  trailing: Text(
                                    "Admin",
                                    style: TextStyle(
                                        color: Colors.orange, fontSize: 13.sp),
                                  ),
                                )
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
      ),
    );
  }
}

class BannersImageView extends StatelessWidget {
  final List<String> imageList;

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
        height: 200.h,
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: imageList.length,
          itemBuilder: (context, index) => Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customImageCard(
                  width: double.infinity,
                  height: 150.h,
                  imageUrl: imageList[index],
                ),
                SizedBox(
                  height: 5.h,
                ),
                greynonBoldText("Title"),
                SizedBox(
                  height: 5.h,
                ),
                greynonBoldText("Description"),
              ],
            ),
          ),
        ));
  }
}

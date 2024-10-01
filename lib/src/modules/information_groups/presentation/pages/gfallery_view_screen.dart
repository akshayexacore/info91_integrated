import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_image_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_scaffold.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';


class GaleryViewScreen extends StatelessWidget {
  final List<String> imageList;
  const GaleryViewScreen({super.key, required this.imageList});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      children: [
        CustomAppBar(appBarName: "Media"),
        Expanded(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: marginWidth,vertical:15.h ),
              child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),itemCount: imageList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.w,mainAxisSpacing: 10.w,
                ),
                        itemBuilder: (context, index) => customImageCard(
              imageUrl: imageList[index],
              onImageTap: () {},
                        ),
                      ),
            ))
      ],
    );
  }
}

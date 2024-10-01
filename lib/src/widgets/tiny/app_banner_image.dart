import 'package:flutter/material.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppBannerImage extends StatelessWidget {
  final String imageUrl;

  final Function()? onTap;

  const AppBannerImage({Key? key, required this.imageUrl, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
          borderRadius:
               const BorderRadius.all(Radius.circular(AppRadii.medium)),
          child: AppNetworkImage(
            imageUrl,
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.fill,
          )),
    );
  }
}

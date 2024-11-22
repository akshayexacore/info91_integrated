import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage(this.url,
      {Key? key,
      this.placeholder,
      this.height = 100,
      this.width = 100,
      this.fit,
      this.alignment = Alignment.center})
      : super(key: key);
  final String? url;
  final Widget? placeholder;
  final double height;
  final double width;
  final BoxFit? fit;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    Widget placeholderWidget = placeholder ?? AppPlaceholderWidget.image;
    if (url != null && url!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: url!,
        errorWidget: (context, url, error) => placeholderWidget,
      );
    }
    return placeholderWidget;
  }
}

class AppSvgAsset extends StatelessWidget {
  const AppSvgAsset(
    this.asset, {
    Key? key,
    this.height,
    this.width,
    this.fit,
    this.color,
  }) : super(key: key);
  final String asset;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    if (asset.isEmpty) {
      return AppPlaceholderWidget.image;
    }
    return SvgPicture.asset(
      asset,
      fit: fit ?? BoxFit.contain,
      width: width,
      height: height,
      color: color,
    );
  }
}

class AppAssetImage extends StatelessWidget {
  const AppAssetImage(
    this.asset, {
    Key? key,
    this.height,
    this.width,
    this.fit,
    this.color,
  }) : super(key: key);
  final String asset;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      color: color,
    );
  }
}

class AppPlaceholderWidget {
  static get image => const AppSvgAsset(
        'assets/images/no_image.svg',
        fit: BoxFit.cover,
      );
}



class AppCircleImage extends StatelessWidget {
  const AppCircleImage({
    Key? key,
    this.radius = 25,
    this.image = '',
  }) : super(key: key);

  final double radius;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipOval(
        child: image.isEmpty
            ? Image.asset(
                'assets/images/defaultimg.png', // Your fallback asset image
                fit: BoxFit.cover,
                height: radius * 2,
                width: radius * 2,
              )
            : CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                height: radius * 2,
                width: radius * 2,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/images/no_image.svg', // Your fallback asset image
                  fit: BoxFit.cover,
                  height: radius * 2,
                  width: radius * 2,
                ),
              ),
      ),
    );
  }
}

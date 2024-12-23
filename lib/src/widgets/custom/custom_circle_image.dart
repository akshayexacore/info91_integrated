import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:info91/src/widgets/custom/image_view.dart';

Widget circle_image({
  required String avatarUrl,
  double radius = 20.0,
  VoidCallback? onTap,
    String? name,
}) {
  return InkWell(
    onTap: onTap,
    child: CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey[200], // Optional: Placeholder background
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: avatarUrl,
          placeholder: (context, url) => CircularProgressIndicator(), // Show loading indicator
          errorWidget: (context, url, error) =>
              InitialTextCircleAvatar(contactName: name??"",), // Fallback image on error
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
        ),
      ),
    ),
  );
}

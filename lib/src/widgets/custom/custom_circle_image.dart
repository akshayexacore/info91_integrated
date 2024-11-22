import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget circle_image({
  required String avatarUrl,
  double radius = 20.0,
  VoidCallback? onTap,
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
              Image.asset("assets/images/defaultimg.png"), // Fallback image on error
          fit: BoxFit.cover,
          width: radius * 2,
          height: radius * 2,
        ),
      ),
    ),
  );
}

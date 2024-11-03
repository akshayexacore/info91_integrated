import 'package:flutter/material.dart';

Widget circle_image(String avatarUrl, {Function? onTap, double radius = 18,Color? backgroundClr}) {
  return InkWell(
    onTap: () {
      if (onTap != null) {
        onTap();
      }
    },
    child: CircleAvatar(
      radius: radius,backgroundColor:backgroundClr ??Colors.transparent,
      backgroundImage: NetworkImage(avatarUrl),
    ),
  );
}

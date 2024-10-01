import 'package:flutter/material.dart';
import 'package:info91/src/models/profile.dart';
import 'package:info91/src/widgets/custom/app_ink_well.dart';
import 'package:info91/src/widgets/tiny/image_view.dart';

class AppGroupTile extends StatelessWidget {
  const AppGroupTile(
    this.profile, {
    super.key,
    this.onPressed,
  });

  final VoidCallback? onPressed;

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return AppInkWell(
      onTap: onPressed,
      child: Row(
        children: [
          AppCircleImage(
            image: profile.imgUrl,
            radius: 24,
          ),
          const SizedBox(
            width: 14,
          ),
          Text(
            profile.name,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
        ],
      ),
    );
  }
}

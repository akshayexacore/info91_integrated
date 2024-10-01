import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/status.dart';
import 'package:info91/src/modules/status/story_page.dart';
import 'package:info91/src/widgets/custom/status_view.dart';

class AppStatusTile extends StatelessWidget {
  final bool isOwner;
  final Status status;

  const AppStatusTile({super.key, this.isOwner = false, required this.status});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.toNamed(StoryPage.routeName);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Hero(
            tag: ValueKey('${status.hashCode}'),
            child: StatusView(
              radius: 28,
              spacing: 10,
              strokeWidth: 3,
              indexOfSeenStatus: status.seenIndex,
              numberOfStatus: status.statusCount,
              padding: 4,
              centerImageUrl: status.imgUrl,
              seenColor: AppColors.statusSeen,
              unSeenColor: AppColors.secondary,
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isOwner ? "My Status" : status.name,
                  maxLines: 1,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  status.postTime,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 14, color: AppColors.text.withOpacity(0.75)),
                ),
              ],
            ),
          ),
          if (isOwner)
            FloatingActionButton.small(
              heroTag: const ValueKey('camera'),
              shape: const CircleBorder(),
              backgroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(
                Icons.camera_alt_outlined,
                color: AppColors.primary,
              ),
            ),
          if (isOwner)
            FloatingActionButton.small(
              heroTag: const ValueKey('edit'),
              shape: const CircleBorder(),
              backgroundColor: Colors.white,
              onPressed: () {},
              child: const Icon(
                Icons.edit,
                color: AppColors.primary,
              ),
            ),
        ],
      ),
    );
  }
}

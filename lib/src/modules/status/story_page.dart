import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/models/status.dart';
import 'package:info91/src/modules/status/controllers/status_controller.dart';
import 'package:story/story_page_view.dart';

class StoryPage extends StatelessWidget {
  StoryPage({super.key});

  static const routeName = '/story';

  final _controller = Get.find<StatusController>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DismissiblePage(
        onDismissed: () {
          Navigator.of(context).pop();
        },
        direction: DismissiblePageDismissDirection.down,
        isFullScreen: true,
        child: StoryPageView(
          itemBuilder: (context, pageIndex, storyIndex) {
            final user = Status.dummyList()[pageIndex];
            return Stack(
              children: [
                Positioned.fill(
                  child: Container(color: AppColors.black),
                ),
                Positioned.fill(
                  child: Image.network(
                    user.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 44, left: 8),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black54, Colors.transparent],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter)),
                  child: Row(
                    children: [
                      Hero(
                        tag: ValueKey('${user.hashCode}'),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(user.imgUrl),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 17,
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          gestureItemBuilder: (context, pageIndex, storyIndex) {
            return Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  color: Colors.white,
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
          pageLength: 3,
          storyLength: (int pageIndex) {
            return _controller.unseenStatuses.length;
          },
          onPageLimitReached: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

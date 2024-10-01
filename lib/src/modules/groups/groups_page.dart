import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/groups/controllers/groups_controller.dart';
import 'package:info91/src/widgets/custom/app_message_group_tile.dart';

class GroupsPage extends StatelessWidget {
  GroupsPage({super.key});

  final _controller = Get.find<GroupsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      extendBody: true,
      body: Obx(() {
        return ListView.builder(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            if (index >= _controller.recentChats.length) {
              return const SizedBox(
                height: AppSpacings.xxLarge50,
              );
            }
            return AppMessageGroupTile(
              _controller.recentChats[index],
              onPressed: () {
                _controller.gotoChatPage(_controller.recentChats[index]);
              },
            );
          },
          itemCount: _controller.recentChats.length + 1,
        );
      }),
    );
  }
}

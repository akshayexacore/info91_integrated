import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/chat_screen/info_group_chat_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/info_chatlist/info_chatlist_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/informtion_group_creation.dart/profile_creation.page.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/start_screen.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';

import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';

import 'package:toggle_switch/toggle_switch.dart';

class InfoGroupChatListScreen extends StatefulWidget {
  const InfoGroupChatListScreen({super.key});

  @override
  State<InfoGroupChatListScreen> createState() => _InfoGroupChatListScreen();
}

class _InfoGroupChatListScreen extends State<InfoGroupChatListScreen> {
  final InfoChatListController controller = Get.put(InfoChatListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.splashBackground,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            CustomAppBar(
              appBarName: "Information Groups",
              isTextield: true,
              actionWidget: [
                CustomPopupmenu(
                  onSelected: (val) {
                    if (val == 1) {
                      // Get.off(InformGroupCreationScreen);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InformGroupCreationScreen(),
                          ));
                    }
                  },
                  itemList: [popupMenuModel(name: "Create group", value: 1)],
                )
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            toggleSwitch(onToggle: (val) {
              controller.toggleValue.value = val;
            }),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.separated(
                itemCount: controller.chats.length,
                itemBuilder: (context, index) => ChatListItem(
                  chat: controller.chats[index],
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              controller.toggleValue.value == 0
                                  ? const StartScreen()
                                  : ChatScreen(),
                        ));
                  },
                ),
                separatorBuilder: (context, index) => customDivider(),
              ),
            )
          ],
        ));
  }

  ToggleSwitch toggleSwitch({Function? onToggle}) {
    return ToggleSwitch(
      minWidth: 110.0.w,
      minHeight: 34.h,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.white,
      inactiveFgColor: Colors.black,
      initialLabelIndex: 0,
      curve: Curves.bounceOut,
      cornerRadius: 10,
      activeBgColors: [
        [Colors.orange[800]!],
        [Colors.orange[800]!]
      ],
      totalSwitches: 2,
      labels: const ['Groups', 'Own Groups'],
      radiusStyle: true,
      onToggle: (index) {
        if (onToggle != null) {
          onToggle(index);
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';

import 'package:info91/src/modules/information_groups/presentation/pages/info_chatlist/info_chatlist_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/informtion_group_creation.dart/profile_creation.page.dart';

import 'package:info91/src/modules/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_popupmenu.dart';

import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/custom/custom_divider.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

import 'package:toggle_switch/toggle_switch.dart';

class InfoGroupChatListScreen extends StatefulWidget {static const routeName="/infochatlist";
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
            appbarSec(context),
            const SizedBox(
              height: 40,
            ),
            toggleSec(),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: Obx(() {
                if (controller.searchText.value.isNotEmpty) {
                  return controller.loading.value
                      ?const Center(child: CircularProgressIndicator())
                      : controller.searchGroupList.isEmpty
                          ? const Center(child: Text("No Data"))
                          : ListView.separated(
                             padding: EdgeInsets.zero,
                              itemCount: controller.searchGroupList.length,
                              itemBuilder: (context, index) => ChatListItem(
                                chat: controller.searchGroupList[index],
                                isSearch: true,
                                onTap: () {
                                  controller.publicTileOnTap(index);
                                },
                              ),
                              separatorBuilder: (context, index) =>
                                  customDivider(),
                            );
                } else {
                  if (controller.toggleValue.value == 0) {
                    return controller.loading.value
                        ? Center(child: CircularProgressIndicator())
                        : controller.chatGroupList.isEmpty
                            ? const Center(child: Text("No Data"))
                            : ListView.separated(
                               padding: EdgeInsets.zero,
                                itemCount: controller.chatGroupList.length,
                                itemBuilder: (context, index) => ChatListItem(
                                  chat: controller.chatGroupList[index],
                                  onTap: () {
                                    controller.nonPublicTileOnTap(index);
                                  },
                                ),
                                separatorBuilder: (context, index) =>
                                    customDivider(),
                              );
                  } else {
                    return controller.ownchatGroupList.isEmpty
                        ? const Center(child: Text("No Data"))
                        : ListView.separated(
                           padding: EdgeInsets.zero,
                            itemCount: controller.ownchatGroupList.length,
                            itemBuilder: (context, index) => ChatListItem(
                              chat: controller.ownchatGroupList[index],
                              onTap: () {
                                controller.nonPublicTileOnTap(index);
                              },
                            ),
                            separatorBuilder: (context, index) =>
                                customDivider(),
                          );
                  }
                }
              }),
            ),
          ],
        ));
  }

  Obx toggleSec() {
    return Obx(() {
            debugPrint(
                "controller.serchController.value.text.isEmpty${controller.serchController.value.text.trim().isEmpty}");
            return controller.searchText.value.isEmpty
                ? toggleSwitch(
                    onToggle: (val) {
                      controller.toggleValue.value = val;
                    },
                    toggleValue: controller.toggleValue.value)
                : Container();
          });
  }

  CustomAppBar appbarSec(BuildContext context) {
    return CustomAppBar(
            appBarName: "Information Groups",
            isTextield: true,
            textEditingController: controller.serchController.value,
            onChangeFunction: (va) {
              controller.searchText.value = va;
              controller.searchInfoGroup(va);
              // setState(() {});
            },
            actionWidget: [
              Obx(
                () {
                  return controller.toggleValue.value == 1?
                  customTextButton("Create Group",
                fontSize: 12.sp,
                   onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InformGroupCreationScreen(),
                            )).then((value) {
                          controller.grtInfoGroupList();
                        });
                  }): CustomPopupmenu(
                    iconWidget:Icon(
                            Icons.more_vert,
                            color: AppColors.white,
                    ),
                    onSelected: (val) {
                      if (val == 1) {
                        // Get.off(InformGroupCreationScreen);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const InformGroupCreationScreen(),
                            )).then((value) {
                          controller.grtInfoGroupList();
                        });
                      }
                    },
                    itemList: [popupMenuModel(name: "Create group", value: 1)],
                  );
                }
              )
            ],
          );
  }

  ToggleSwitch toggleSwitch({Function? onToggle, required int toggleValue}) {
    return ToggleSwitch(
      minWidth: 110.0.w,
      minHeight: 34.h,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.white,
      inactiveFgColor: Colors.black,
      initialLabelIndex: toggleValue,
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

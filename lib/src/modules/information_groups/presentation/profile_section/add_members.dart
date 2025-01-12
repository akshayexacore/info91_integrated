import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:info91/src/configs/app_styles.dart';

import 'package:info91/src/modules/information_groups/presentation/profile_section/controller/addmember_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/chat_list_card.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custom_avatarwithimageicon.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/texts.dart';
import 'package:info91/src/widgets/custom/add_divider.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

import '../../../../widgets/custom/custom_common_appbar.dart';

class AddMembersScreen extends StatefulWidget {
  static const routeName = "/addmemberInfo";
  AddMembersScreen({
    super.key,
  });

  @override
  State<AddMembersScreen> createState() => _AddMembersScreenState();
}

class _AddMembersScreenState extends State<AddMembersScreen> {
  final _controller = Get.find<AddmemberController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
                children: [
                  CustomAppBar(
                    appBarName: "Add Memebers",
                    isTextield: true,
                    textEditingController: _controller.controller,
                    onChangeFunction: (va) {
                      _controller.filterContactsFunc();
                    },
                    actionWidget: [
                      if (_controller.selectedContacts.isNotEmpty)
                        customTextButton("Next", onTap: () {
                         _controller.addToGroup()
;                        })
                    ],
                  ),
                  Obx(
                     () {
                      return Expanded(
                        child: _controller.isLoading.value
                                  ?const  Center(child: CircularProgressIndicator())
                                  : SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h,),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: marginWidth),
                                child: greyBoldText("Contacts on Info91"),
                              ),
                               SizedBox(height: 10.h,),
                              ListView.builder(physics:   const ScrollPhysics() ,
                              padding: EdgeInsets.zero,
                                itemCount: _controller.existingContacts.length,
                      
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final contact = _controller.existingContacts[index];
                             
                              
                                  return ContactListCard(
                                    avatar: Uint8List(0),
                                    isInactive: contact.existGoup??false,
                                    contactName: contact.displayName ?? '',
                                    subtitle: contact.existGoup==true?"All ready added to the group":contact.about,
                                    value: _controller.selectedContacts.contains(contact),
                                    onCange: () {
                                      _controller.toggleContactSelection(contact);
                                      if (_controller.controller.text.isNotEmpty) {
                                      _controller.controller.clear();
                                        _controller.filterContactsFunc();
                                      }
                                     
                                    },
                                  );
                                },
                               
                              ),    SizedBox(height: 10.h,),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: marginWidth),
                                child: greyBoldText("Invite to Info91"),
                              ),
                               SizedBox(height: 10.h,),
                                 ListView.separated(physics:   const ScrollPhysics() ,
                              padding: EdgeInsets.zero,
                                itemCount: _controller.nonexistingContacts.length,
                      
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  final contact = _controller.nonexistingContacts[index];
                              
                                  return ContactListCard(
                                    avatar: Uint8List(0),
                                    contactName: contact.displayName ?? '',
                                    value: _controller.selectedContacts.contains(contact),
                                    leadingWidget:const SizedBox(),
                                    onCange: () {
                                      // _controller.toggleContactSelection(contact);
                                      // if (_controller.controller.text.isNotEmpty) {
                                      // _controller.controller.clear();
                                      //   _controller.filterContactsFunc();
                                      // }
                                     
                                    },
                                  );
                                },
                                separatorBuilder: (context, index) => customDivider(),
                              ),    SizedBox(height: 10.h,),
                            ],
                          ),
                        ),
                      );
                    }
                  ),
                  if (_controller.selectedContacts.isNotEmpty)
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120.h,
                      padding: const EdgeInsets.all(8.0),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        border: Border(),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _controller.selectedContacts.length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            ReusableAvatarWithIcon(
                              profileImage: AssetImage("assetName"),
                              showIcon: true,
                              iconWidget: Positioned(
                                right: 0,
                                child: CustomCircleIconWidget(
                                  onCange: () {
                                    _controller.toggleContactSelection(
                                        _controller.selectedContacts[index]);
                                  },
                                  backgroundClr: AppColors.secondary,
                                  iconData: Icons.close,
                                  iconColor: AppColors.white,
                                ),
                              ),
                              iconAlignment: Alignment.bottomRight,
                            ),
                            SizedBox(
                                width: 70.w,
                                child: Text(
                                  _controller.selectedContacts[index]
                                          .displayName ??
                                      "",
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ))
                          ],
                        ),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/profile_section/controller/group_profile_edition_controler.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/new_input_card.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class GroupNameDisEdition extends StatelessWidget { 
static const route="/GroupNameDisEdition";
   GroupNameDisEdition({super.key});
final _controller= Get.find<GroupProfileEditionController>();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawerEnableOpenDragGesture: false,
      body: Column(
        children: [
          CustomAppBar(appBarName: "Edit Name & About",actionWidget: [
           customTextButton("Save",onTap: _controller.editGroupNameAndAbout)
          ],),Expanded(child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: marginWidth,vertical: 30.h),
            child: Form(
              key:_controller. formKey,
              child: Column(children: [
                 NewInputCard(controller: _controller.groupNameController, title: "Group Name",label: "Enter your Group Name",showValidator: true,validatorMessage: "Please enter Group NAme"),
                const SizedBox(height: 25,),
                NewInputCard(controller: _controller.aboutController, title: "About",height: 90,maxLines: 3,label: "Enter your About here",showValidator: true,validatorMessage: "Please enter about",),
              ],),
            ),
          ),)
         
        ],
      ),
    );
  }
}
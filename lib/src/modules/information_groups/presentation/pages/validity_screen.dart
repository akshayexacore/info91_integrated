import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/app_styles.dart';
import 'package:info91/src/modules/information_groups/presentation/pages/informtion_group_creation.dart/group_creation_controller.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/custome_space_between_text.dart';
import 'package:info91/src/modules/information_groups/presentation/widgets/validity_card.dart';
import 'package:info91/src/widgets/custom/custom_common_appbar.dart';
import 'package:info91/src/widgets/tiny/app_button.dart';

class ValidityScreen extends StatefulWidget {
  
  ValidityScreen({super.key});

  @override
  State<ValidityScreen> createState() => _ValidityScreenState();
}

class _ValidityScreenState extends State<ValidityScreen> {
  final GroupCreationController _controller =
      Get.put(GroupCreationController());

  
  // @override
  // void initState() {
  //  _controller.validityClear;
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            imageUrl: "",
            actionWidget: [
              customTextButton("Apply", onTap: (){
                debugPrint("_controller.getSelectedPalnIndex()${_controller.getSelectedPalnIndex()}");
                _controller.setPlanModel(_controller.planList[_controller.getSelectedPalnIndex()]);
                    debugPrint("_controller.getSelectedPalnIndex()${_controller.selectedPlanModel
}");
                Get.back();

              }),
            ],
            appBarName: "Validity Plans",
          ),
          Expanded(
            child: SingleChildScrollView(
              
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: marginWidth),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    const Text(
                        "Choose a  plan for your business group and submit the request"),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx((){
                 return GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, 
                          crossAxisSpacing: 20, 
                          mainAxisSpacing: 20, childAspectRatio: 3.4/2
                          // Space between rows
                        ),
                        itemCount: _controller.planList.length, // Total number of items
                        itemBuilder: (context, index) {
                          return Obx((){
                         return ValidityCard(
                              isSelected: _controller.planList[index].id==_controller.planId.value,
                                                  
                              onChange:(){
                               
                                _controller.planId.value=_controller.planList[index].id??0;
                                // _controller.setPlanModel(_controller.planList[index]);
                              },
                              amount: _controller.planList[index].amount.toString(),
                              planName:
                                  _controller.planList[index].planName.toString(), // Generates Plan A, Plan B, etc.
                             
                            );}
                          );
                        },
                      );},
                    ),Obx((){return _controller.planId!=0  ? Column(children: [ SizedBox(
                      height: 20.h,
                    ),
                     CustomSpcaeBetweenText(
                      leftText: "Paln name",
                      rightText: _controller.planList[_controller.getSelectedPalnIndex()]. planName??"",
                    ),
                     CustomSpcaeBetweenText(
                      leftText: "Total Members",
                      rightText: _controller.planList[_controller.getSelectedPalnIndex()].totalMembers.toString()??""
                    ),
                     CustomSpcaeBetweenText(
                      leftText: "Validity",
                      rightText: _controller.planList[_controller.getSelectedPalnIndex()].duration.toString()??"",
                    ),
                     CustomSpcaeBetweenText(
                      leftText: "Amount",
                      rightText: _controller.planList[_controller.getSelectedPalnIndex()].amount.toString()??"",
                    ),
                     CustomSpcaeBetweenText(
                      leftText: "Tax",
                      rightText: _controller.planList[_controller.getSelectedPalnIndex()].tax.toString()??"",
                    ),
                    CustomSpcaeBetweenText(
                      leftText: "Total Amount",
                      rightText:((_controller.planList[_controller.getSelectedPalnIndex()].tax ?? 0) + (_controller.planList[_controller.getSelectedPalnIndex()].amount ?? 0)).toStringAsFixed(2)
,
                    ),
                    
                    
                    ],):SizedBox();})
                   
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

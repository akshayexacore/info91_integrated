import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/models/informationgroup/plan_model.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

import '../../../../../models/informationgroup/category_model.dart';

class GroupCreationController extends GetxController {
  var typeController = "".obs;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController category1Controller = TextEditingController();
  TextEditingController category2Controller = TextEditingController();
  TextEditingController category3Controller = TextEditingController();
  var firstCategoryList =<Category> [].obs;
  var secondCatList = <SecondCategory> [].obs;
   var planList = <PlanModel> [].obs;
 PlanModel  selectedPlanModel=PlanModel();
var planId=0.obs;
  var isBusy = false.obs;

  final _infromationRepository = InfromationRepository();
  final formkey = GlobalKey<FormState>();

@override
void onInit() {
  debugPrint("Starting onInit");
  getFirstCategory();
  debugPrint("After getFirstCategory call");
  super.onInit();
}
setPlanModel(PlanModel model){
  selectedPlanModel=model;
}


  void createGroupFun() async {
    isBusy(true);
    InformationGroupCreationModel model = InformationGroupCreationModel(
      category1: category1Controller.text,
      category2: category2Controller.text,
      category3: category3Controller.text,
      groupName: groupNameController.text,
      planId: planId.value ,
      purpose: purposeController.text,
      type: typeController.value,
    );
    try {
      final response = await _infromationRepository.createGroupFun(model);
      if (response.data1) {
        AppDialog.showSnackBar('Success', '${response.data2}');
      } else {
        AppDialog.showSnackBar('Failure', '${response.data2}');
      }
    } catch (e) {
      print("esss$e");
      AppDialog.showSnackBar('Failure', '$e');
      debugPrint(e.toString());
    }
  }

  saveButtonPress() {
    bool isFormValid = formkey.currentState!.validate();
    if (isFormValid){
      if(typeController.value == "business"){
        if(planId==0){ AppDialog.showSnackBar('Select', 'Please choose validity plan');}else{   createGroupFun();}
         

      }else{
        createGroupFun();
      }

      
    } 
  }

  getFirstCategory() async {
    final response = await _infromationRepository.getFirstCategory();
    firstCategoryList.value = response;
    print("categoryList$firstCategoryList");
  }
    getSecondCategory(String id) async {
    final response = await _infromationRepository.getSecondCategory(id);
    secondCatList.value = response;
    debugPrint("categoryList$secondCatList");
  }


    getPlanList() async {

      debugPrint("calling function");
    final response = await _infromationRepository.planList();
    planList.value = response;
    debugPrint("planList$planList");
  }
}

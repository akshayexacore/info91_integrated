import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/models/informationgroup/plan_model.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

import '../../../../../models/informationgroup/category_model.dart';

class GroupCreationController extends GetxController {
  var typeController = "".obs;
  var groupNameController = TextEditingController().obs;
  var purposeController = TextEditingController().obs;
  var category1Controller = TextEditingController().obs;
  var category2Controller = TextEditingController().obs;
  var category3Controller = TextEditingController().obs;
  var firstCategoryList = <Category>[].obs;
  var secondCatList = <SecondCategory>[].obs;
  var thirdCatList = <ThirdCategoryModel>[].obs;
  var planList = <PlanModel>[].obs;
  var selectedCategory2 = Rxn<SecondCategory>();
  var selectedCategory3 = Rxn<ThirdCategoryModel>();
  var selectedItem = Rxn<SecondCategory>();
  PlanModel selectedPlanModel = PlanModel();
  var planId = 0.obs;
  var isBusy = false.obs;

  final _infromationRepository = InfromationRepository();
  final formkey = GlobalKey<FormState>();

  @override
  void onInit() {
   debugPrint("After getFirstCategory calssssl${selectedItem.value?.secondCategoryName}");
    getFirstCategory();
    clear();
  
    super.onInit();
  }
void onClose() {
  // Dispose of all TextEditingControllers to free up resources
  groupNameController.value.dispose();
  purposeController.value.dispose();
  category1Controller.value.dispose();
  category2Controller.value.dispose();
  category3Controller.value.dispose();
  
  super.onClose(); // Always call super.onClose() last
}
  setPlanModel(PlanModel model) {
    selectedPlanModel = model;
  }
  clear(){
    groupNameController.value.clear();
  purposeController.value.clear();
  category1Controller.value.clear();
  category2Controller.value.clear();
  typeController.value="";
  category3Controller.value.clear();
 firstCategoryList .clear();
   secondCatList.clear();
   thirdCatList .clear();
   planList.clear();
   selectedCategory2.value=SecondCategory();
 selectedCategory3.value = ThirdCategoryModel();
   selectedItem .value= SecondCategory();
 selectedPlanModel= PlanModel();
  }

  void createGroupFun() async {
    isBusy(true);
    InformationGroupCreationModel model = InformationGroupCreationModel(
      category1: category1Controller.value.text,
      category2: category2Controller.value.text,
      category3: category3Controller.value.text,
      groupName: groupNameController.value.text,
      planId: planId.value,
      purpose: purposeController.value.text,
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
    if (isFormValid) {
      if (typeController.value == "business") {
        if (planId == 0) {
          AppDialog.showSnackBar('Select', 'Please choose validity plan');
        } else {
          createGroupFun();
        }
      } else {
        createGroupFun();
      }
    }
  }

  categoryOneSelection(va) {
    if (va.id.toString() != category1Controller.value.text) {
      category1Controller.value.text = va?.id.toString() ?? "";
      category2Controller.value.clear();

      category3Controller.value.clear();
      secondCatList.clear();
      selectedCategory2.value = null;
      selectedCategory3.value = null;
      thirdCatList.clear();
      getSecondCategory(category1Controller.value.text);
    }
  }

  category2Selection(va) {
    if (va.id.toString() != category2Controller.value.text) {
      category2Controller.value.text = va?.id.toString() ?? "";
      selectedCategory2.value = va;
      selectedCategory3.value = null;
      category3Controller.value.clear();

      getThirdCategory(category2Controller.value.text);
    }
  }

  category3Selection(va) {
    category3Controller.value.text = va?.id.toString() ?? "";
    selectedCategory3.value=va;
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

  getThirdCategory(String id) async {
    final response = await _infromationRepository.getThirdCategory(id);
    thirdCatList.value = response;
    debugPrint("categoryList$secondCatList");
  }

  getPlanList() async {
    debugPrint("calling function");
    final response = await _infromationRepository.planList();
    planList.value = response;
    debugPrint("planList$planList");
  }
}

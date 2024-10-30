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
  TextEditingController purposeController = TextEditingController();
  TextEditingController category1Controller = TextEditingController();
  TextEditingController category2Controller = TextEditingController();
  TextEditingController category3Controller = TextEditingController();
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
  purposeController.dispose();
  category1Controller.dispose();
  category2Controller.dispose();
  category3Controller.dispose();
  
  super.onClose(); // Always call super.onClose() last
}
  setPlanModel(PlanModel model) {
    selectedPlanModel = model;
  }
  clear(){
    groupNameController.value.clear();
  purposeController.clear();
  category1Controller.clear();
  category2Controller.clear();
  category3Controller.clear();
  }

  void createGroupFun() async {
    isBusy(true);
    InformationGroupCreationModel model = InformationGroupCreationModel(
      category1: category1Controller.text,
      category2: category2Controller.text,
      category3: category3Controller.text,
      groupName: groupNameController.value.text,
      planId: planId.value,
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
    if (va.id.toString() != category1Controller.text) {
      category1Controller.text = va?.id.toString() ?? "";
      category2Controller.clear();

      category3Controller.clear();
      secondCatList.clear();
      selectedCategory2.value = null;
      selectedCategory3.value = null;
      thirdCatList.clear();
      getSecondCategory(category1Controller.text);
    }
  }

  category2Selection(va) {
    if (va.id.toString() != category2Controller.text) {
      category2Controller.text = va?.id.toString() ?? "";
      selectedCategory2.value = va;
      selectedCategory3.value = null;
      category3Controller.clear();

      getThirdCategory(category2Controller.text);
    }
  }

  category3Selection(va) {
    category3Controller.text = va?.id.toString() ?? "";
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

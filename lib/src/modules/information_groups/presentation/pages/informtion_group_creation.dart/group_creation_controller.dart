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
  List<String> _keys = [];
 var isNameValid = true.obs; // Tracks validation
  var errorMessage = ''.obs; 
  var key1Controller = TextEditingController().obs;
  var key2Controller = TextEditingController().obs;
  var key3Controller = TextEditingController().obs;
  var emailCotroller = TextEditingController().obs;
  //  String? key1, key2, key3;
  var firstCategoryList = <Category>[].obs;
  var secondCatList = <SecondCategory>[].obs;
  var thirdCatList = <ThirdCategoryModel>[].obs;
  var planList = <PlanModel>[].obs;
  var selectedCategory2 = Rxn<SecondCategory>();
  var selectedCategory1 = Rxn<Category>();
  var selectedCategory3 = Rxn<ThirdCategoryModel>();

  var selectedItem = Rxn<SecondCategory>();
  var selectedPlanModel = Rx<PlanModel>(PlanModel());
  var planId = 0.obs;
  var isBusy = false.obs;

  final _infromationRepository = InfromationRepository();
  final formkey = GlobalKey<FormState>();

  @override
  void onInit() {
    debugPrint(
        "After getFirstCategory calssssl${selectedItem.value?.secondCategoryName}");
    clear();
    getFirstCategory();

    super.onInit();
  }

  void onClose() {
    // Dispose of all TextEditingControllers to free up resources
    groupNameController.value.dispose();
    purposeController.value.dispose();
    category1Controller.value.dispose();
    category2Controller.value.dispose();
    category3Controller.value.dispose();
    key1Controller.value.dispose();
    emailCotroller.value.dispose();
    key2Controller.value.dispose();
    key3Controller.value.dispose();
    isNameValid.value=true;
    

    super.onClose(); // Always call super.onClose() last
  }

  setPlanModel(PlanModel model) {
    selectedPlanModel.value = model;
  }

  clear() {
    groupNameController.value.clear();
    purposeController.value.clear();
    category1Controller.value.clear();
    category2Controller.value.clear();
    typeController.value = "";
    category3Controller.value.clear();
    firstCategoryList.clear();
    secondCatList.clear();
    thirdCatList.clear();
    key1Controller.value.clear();
    key2Controller.value.clear();
    key3Controller.value.clear();
    selectedCategory2.value = null;
    selectedCategory3.value = null;
    selectedCategory1.value = null;
    selectedItem.value = null;
    emailCotroller.value.clear();
    isNameValid.value=false;

//  selectedPlanModel= PlanModel();
  }

  typeValueClear() {
    if (typeController.value.isNotEmpty) {
      typeController.value = "";
    }
  }

// void extractKeys() {
//    _keys = key1Controller.value.text.split('#').map((key) => key.trim()).toList(); // Assign keys to variables
// key1 = _keys.isNotEmpty ? _keys[0] : null;
// key2 = _keys.length > 1 ? _keys[1] : null; key3 = _keys.length > 2 ? _keys[2] : null; // Limit to 3 keys
//  if (_keys.length > 3) {
//   _keys = _keys.sublist(0, 3); // Update the text field to show only up to 3
// key1Controller.value.text = _keys.join(' # '); // Move cursor to the end of the text field
//  key1Controller.value.selection = TextSelection.fromPosition(TextPosition(offset: key1Controller.value.text.length)); }  }
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
        tagKey1: key1Controller.value.text,
        tagKey2: key2Controller.value.text,
        tagKey3: key3Controller.value.text,
        email: emailCotroller.value.text);
    debugPrint("the model is Here${model.tagKey1}  ");
    try {
      final response = await _infromationRepository.createGroupFun(model);
      if (response.data1) {
        Get.back();
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

  int getSelectedPalnIndex() {
    int? index = planList.indexWhere((plan) => plan.id == planId.value);
    return index;
  }

  categoryOneSelection(va) {
    if (va.id.toString() != category1Controller.value.text) {
      category1Controller.value.text = va?.id.toString() ?? "";
      selectedCategory1.value = va;
      category2Controller.value.clear();

      category3Controller.value.clear();
      secondCatList.clear();
      selectedCategory2.value = null;
      selectedCategory3.value = null;
      thirdCatList.clear();
      getSecondCategory(category1Controller.value.text);
    }
  }

  categoryOneClear() {
    if (selectedCategory1.value != null) {
      category1Controller.value.text = "";
      selectedCategory1.value = null;
      category2Controller.value.clear();
      category3Controller.value.clear();
      selectedCategory2.value = null;
      selectedCategory3.value = null;
      thirdCatList.clear();
      secondCatList.clear();
    }
  }

  categorytwoClear() {
    if (selectedCategory2.value != null) {
      category2Controller.value.clear();
      category3Controller.value.clear();
      selectedCategory2.value = null;
      selectedCategory3.value = null;
      thirdCatList.clear();
    }
  }

  categoryThreelear() {
    if (selectedCategory3.value != null) {
      selectedCategory3.value = null;
      category3Controller.value.clear();
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
    selectedCategory3.value = va;
  }

  getFirstCategory() async {
    debugPrint("calling initially");

    try {
      final response = await _infromationRepository.getFirstCategory();
      firstCategoryList.value = response;
    } catch (e) {
      debugPrint("the error is $e");
    }
  }

  Future<void> keyCheckExistFunction(String key,) async {
    try {
      final response = await _infromationRepository.keyCheckExistFunction(key);
      if(response.data1){
        isNameValid.value=true; 
        errorMessage.value="";
       
      }
      else{
        isNameValid.value=false;
         errorMessage.value=response.data2;
      }
    } catch (e) {
      print("the error is here$e");
    }
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

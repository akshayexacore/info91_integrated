import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/information_group.dart';
import 'package:info91/src/resources/infromation_repository.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

class GroupCreationController extends GetxController {
  var typeController = "".obs;
  TextEditingController groupNameController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController category1Controller = TextEditingController();
  TextEditingController category2Controller = TextEditingController();
  TextEditingController category3Controller = TextEditingController();
  int? planId;
  var isBusy = false.obs;

  final _infromationRepository = InfromationRepository();
final formkey=GlobalKey<FormState>();
  void createGroupFun() async {
    isBusy(true);
    InformationGroupCreationModel model = InformationGroupCreationModel(
      category1: category1Controller.text,
      category2: category2Controller.text,
      category3: category3Controller.text,
      groupName: groupNameController.text,
      planId: planId??1,
      purpose: purposeController.text,
      type: typeController.value,
    );
    try{
      final response = await _infromationRepository.createGroupFun(model);
      if(response.data1){
        AppDialog.showSnackBar('Success', '${response.data2}');

      }else{
      AppDialog.showSnackBar('Failure', '${response.data2}');
      }
    }catch(e){
      print("esss$e");
  AppDialog.showSnackBar('Failure', '$e');
      debugPrint(e.toString());
    }
    
  }
  saveButtonPress(){
     bool isFormValid = formkey.currentState!.validate();
    if(isFormValid)
      createGroupFun();
    }
  }


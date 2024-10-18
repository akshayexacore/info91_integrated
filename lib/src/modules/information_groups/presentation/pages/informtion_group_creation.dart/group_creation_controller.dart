import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/information_group.dart';
import 'package:info91/src/resources/infromation_repository.dart';

class GroupCreationController extends GetxController {
  TextEditingController typeController = TextEditingController();
  TextEditingController groupNameController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController category1Controller = TextEditingController();
  TextEditingController category2Controller = TextEditingController();
  TextEditingController category3Controller = TextEditingController();
  int? planId;
  var isBusy = false.obs;

  final _infromationRepository = InfromationRepository();

  void createGroupFun() async {
    isBusy(true);
    InformationGroupCreationModel model = InformationGroupCreationModel(
      category1: category1Controller.text,
      alternativeNumber: "",
      category2: category2Controller.text,
      category3: category3Controller.text,
      contactTime: "",
      groupName: groupNameController.text,
      planId: planId,
      purpose: purposeController.text,
      type: typeController.text,
    );
    try{
      final response = await _infromationRepository.createGroupFun(model);
    }catch(e){

      debugPrint(e.toString());
    }
    
  }
}

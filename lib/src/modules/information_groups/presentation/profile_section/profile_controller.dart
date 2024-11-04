import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/resources/infromation_repository.dart';

class InfoProfileController extends GetxController {

  var profilledataModel=GroupProfileModel().obs;
  var isLoading=false.obs;
  final _infromationRepository = InfromationRepository();



    Future<void> getGroupInfoDetails(String id) async {
      debugPrint("getGroupInfoDetails calling");
    try {
      isLoading.value=true;
      final response = await _infromationRepository
          .getProfileData(id ?? "");
           debugPrint("getGroupInfoDetails calling${response.memberCount}");
      profilledataModel.value = response;
      isLoading.value=false;
    } catch (e) {
      isLoading.value=false;
      throw e;
    }
  }
}

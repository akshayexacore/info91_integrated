import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:info91/src/configs/api_constants.dart';
import 'package:info91/src/models/informationgroup/category_model.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/resources/shared_preferences_data_provider.dart';
import 'package:info91/src/resources/user_profile_repository.dart';
import 'package:info91/src/utils/api_base_helper.dart';
import 'package:info91/src/utils/response-utils.dart';


class InfromationRepository {
  final ApiBaseHelper _api = ApiBaseHelper();
  late final _preferences = SharedPreferencesDataProvider();
  late final _userProfileRepository = UserProfileRepository();



  Future<DoubleResponse> createGroupFun(
      InformationGroupCreationModel model) async {
    final response = await _api.post(ApiConstants.creationInformationAPi,
        body: model.toJson(), headers: {});

    print("Response: $response");

    if (response['statusCode'] == 200 && response['success'] == 'success') {
      return DoubleResponse(true, response['message']);
    } else {
      return DoubleResponse(false, "Group creation failed");
    }
  }

  Future<List<InfoGroupChatListModel>> grtInfoGroupList() async {
    List<InfoGroupChatListModel> dataLIst = [];
    final user = await _userProfileRepository.getUser();
    debugPrint("${user.user?.id}");

    final response = await _api.post(ApiConstants.infoGroupListAPi,
        body: {"user_id": user.user?.id.toString() ?? null}, headers: {});
    try {
      (response["data"] as List).forEach((element) {
        dataLIst.add(InfoGroupChatListModel.fromJson(element));
      });
      return dataLIst;
    } catch (e) {
      throw e;
    }
  }

  Future<List<InfoGroupChatListModel>> searchInfoGroup(String searchKey) async {
    List<InfoGroupChatListModel> dataLIst = [];
    final user = await _userProfileRepository.getUser();
    debugPrint("${user.user?.id}");

    final response = await _api.post(ApiConstants.infoGroupPublicSearchAPi,
        body: {"user_id": user.user?.id.toString() ?? null,"search_key":searchKey}, headers: {});
    try {
      (response["data"] as List).forEach((element) {
        dataLIst.add(InfoGroupChatListModel.fromJson(element));
      });
      return dataLIst;
    } catch (e) {
      throw e;
    }
  }


  Future<List<Category>> getFirstCategory() async {
    List<Category> dataLIst = [];
    final user = await _userProfileRepository.getUser();
    debugPrint("${user.user?.id}");

    final response = await _api.get(ApiConstants.firstCategoryListApi,
        headers: {});
    try {
      (response["data"] as List).forEach((element) {
        dataLIst.add(Category.fromJson(element));
      });
      return dataLIst;
    } catch (e) {
      throw e;
    }
  }


}

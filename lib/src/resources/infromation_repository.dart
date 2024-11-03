import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:info91/src/configs/api_constants.dart';
import 'package:info91/src/models/informationgroup/category_model.dart';
import 'package:info91/src/models/informationgroup/group_profile.dart';
import 'package:info91/src/models/informationgroup/info-model.dart';
import 'package:info91/src/models/informationgroup/information_group.dart';
import 'package:info91/src/models/informationgroup/plan_model.dart';
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
        body: {
          "user_id": user.user?.id.toString() ?? null,
          "search_key": searchKey
        },
        headers: {});
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

    final response =
        await _api.get(ApiConstants.firstCategoryListApi, headers: {});
    try {
      (response["data"] as List).forEach((element) {
        dataLIst.add(Category.fromJson(element));
      });
      return dataLIst;
    } catch (e) {
      throw e;
    }
  }

  Future<List<SecondCategory>> getSecondCategory(String id) async {
    List<SecondCategory> dataLIst = [];

    final response =
        await _api.get(ApiConstants.secondCategoryListApi + id, headers: {});
    try {
      (response["data"] as List).forEach((element) {
        dataLIst.add(SecondCategory.fromJson(element));
      });
      return dataLIst;
    } catch (e) {
      throw e;
    }
  }

  Future<List<ThirdCategoryModel>> getThirdCategory(String id) async {
    List<ThirdCategoryModel> dataLIst = [];

    final response =
        await _api.get(ApiConstants.thirdCategoryListApi + id, headers: {});
    print("objectE${response["data"]}");
    try {
      (response["data"] as List).forEach((element) {
        dataLIst.add(ThirdCategoryModel.fromJson(element));
      });
      print("objectE${dataLIst}");
      return dataLIst;
    } catch (e) {
      throw e;
    }
  }

  Future<List<PlanModel>> planList() async {
    List<PlanModel> dataLIst = [];

    final response = await _api.get(ApiConstants.getPlanListApi, headers: {});
    try {
      (response["data"] as List).forEach((element) {
        dataLIst.add(PlanModel.fromJson(element));
      });
      return dataLIst;
    } catch (e) {
      throw e;
    }
  }

  Future<DoubleResponse> joinMessageTapFunc(String id) async {
    final response = await _api
        .post(ApiConstants.joinGroupApi, headers: {}, body: {'group_id': id});
    try {
      if (response['status'] == 'success') {
        return DoubleResponse(true, response['message']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<InfoGroupDataModel> getInfoData(String id) async {
    final response = await _api.post(ApiConstants.getInfoDatapApi,
        headers: {}, body: {'group_id': id});
    try {
      debugPrint("dadatat${response["data"].toString()}");
      InfoGroupDataModel data = InfoGroupDataModel.fromJson(response["data"]);
      return data;
    } catch (e) {
      rethrow;
    }
  }

  Future<DoubleResponse> updateInfoData(
      {required InfoGroupDataModel model}) async {
    try {
      final response = await _api.post(ApiConstants.updateInfoDatapApi,
          body: model.toJson(), headers: {});

      print("Response: $response");

      if (response['status'] == 'success') {
        return DoubleResponse(true, response['message']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<GroupProfileModel> getProfileData(String id) async {
    final response = await _api.post(ApiConstants.groupProfileApi,
        headers: {}, body: {'group_id': id});
    try {
      debugPrint("dadatat${response["data"].toString()}");
      GroupProfileModel data = GroupProfileModel.fromJson(response["data"]);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

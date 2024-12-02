import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:info91/src/configs/api_constants.dart';
import 'package:info91/src/configs/variables.dart';

import 'package:info91/src/models/informationgroup/category_model.dart';
import 'package:info91/src/models/informationgroup/chat_model.dart';
import 'package:info91/src/models/informationgroup/contact_model.dart';
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
      rethrow;
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
      rethrow;
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
      rethrow;
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

  Future<DoubleResponse> uploadFile(String file, String group_id) async {
    final response = await _api.postMultipart(
      ApiConstants.groupProfilePicUpdateApi,
      body: {"group_id": group_id},
      headers: {},
      file: file,
    );
    debugPrint("response is here$response");

    if (response['statusCode'] == 200) {
      return DoubleResponse(true, GroupProfileModel.fromJson(response["data"]));
    } else {
      return DoubleResponse(false, response['message']);
    }
  }

  Future<DoubleResponse> uploadCoverPic(String file, String group_id) async {
    final response = await _api.postMultipart(
      ApiConstants.groupCovPicUpdateApi,
      body: {"group_id": group_id},
      headers: {},
      file: file,
    );
    if (response['statusCode'] == 200) {
      return DoubleResponse(true, GroupProfileModel.fromJson(response["data"]));
    } else {
      return DoubleResponse(false, response['message']);
    }
  }

  Future<DoubleResponse> sendMessage(
      {required String groupId,
      required String type,
      required dynamic message,
      bool replyFlag = false,
      String? reply_message_id}) async {
    List<ChatMessage> dataLIst = [];
    try {
      final response =
          await _api.post(ApiConstants.addMessageApi, headers: {}, body: {
        'group_id': groupId,
        "type": type,
        "message": message,
        "reply_flag": replyFlag,
        "reply_message_id": reply_message_id
      });
      debugPrint("response['status'] ");
      if (response['status'] == 'success') {
        (response["data"] as List).forEach((element) {
          dataLIst.add(ChatMessage.fromJson(element));
        });
        return DoubleResponse(true, dataLIst);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      debugPrint("e");
      throw e;
    }
  }

  Future<DoubleResponse> viewMessage({
    required String groupId,
  }) async {
    List<ChatMessage> dataLIst = [];
    try {
      final response =
          await _api.post(ApiConstants.viewMessageApi, headers: {}, body: {
        'group_id': groupId,
      });
      debugPrint("response['status'] ");
      if (response['status'] == 'success') {
        (response["data"] as List).forEach((element) {
          dataLIst.add(ChatMessage.fromJson(element));
        });
        return DoubleResponse(true, dataLIst);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      debugPrint("e");
      throw e;
    }
  }

  Future<DoubleResponse> deleTeMessages(
      {required String groupId, required List<String?> messageIds}) async {
    debugPrint("message Id$messageIds");
    try {
      List<ChatMessage> dataLIst = [];
      final response = await _api.post(ApiConstants.deleteMessageApi,
          headers: {}, body: {'group_id': groupId, "message_id": messageIds});
      debugPrint("response['status'] ");
      if (response['status'] == 'success') {
        (response["data"] as List).forEach((element) {
          dataLIst.add(ChatMessage.fromJson(element));
        });
        return DoubleResponse(true, dataLIst);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      debugPrint("e");
      throw e;
    }
  }

  Future<DoubleResponse> fileUpload({
    required String file,
  }) async {
    try {
      final response = await _api.postMultipart(
        ApiConstants.fileUploadApi,
        body: {},
        key: "file",
        headers: {},
        file: file,
      );
      debugPrint("the fileUpload response+$response");
      if (response['success'] == 'success') {
        return DoubleResponse(true, response['data']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      debugPrint("e");
      throw e;
    }
  }

  Future<DoubleResponse> createBanner({
    required String file,
    required String groupId,
    required String title,
    required String description,
  }) async {
    try {
      final response = await _api.postMultipart(
        ApiConstants.createBannerApi,
        body: {
          "banner_title": title,
          "banner_description": description,
          "group_id": groupId
        },
        key: "banner_image",
        headers: {},
        file: file,
      );
      debugPrint("the fileUpload response+$response");
      if (response['success'] == true) {
        return DoubleResponse(true, response['data']["banners"]);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      debugPrint("e");
      rethrow;
    }
  }

  Future<DoubleResponse> upDateBanner({
    required String file,
    required String groupId,
    required String title,
    required String description,
    required String bannerId,
  }) async {
    try {
      final response = await _api.postMultipart(
        ApiConstants.updateBannerApi,
        body: {
          "banner_title": title,
          "banner_description": description,
          "banner_id": bannerId,
          "group_id": groupId,
        },
        key: "banner_image",
        headers: {},
        file: file,
      );
      debugPrint("the fileUpload response+$response");
      if (response['success'] == true) {
        return DoubleResponse(true, response['data']["banners"]);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      debugPrint("e");
      rethrow;
    }
  }

  Future<DoubleResponse> deleteBanner({
    required String bannerId,
    required String groupId,
  }) async {
    try {
      final response = await _api.post(
        ApiConstants.deleteBannerApi,
        body: {
          "group_id": groupId,
          "banner_id": bannerId,
        },
      );

      if (response['success'] == true) {
        return DoubleResponse(true, response['message']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      debugPrint("e");
      rethrow;
    }
  }

  Future<List<ContactAddGroupModel>> fetchInfo91Contacts(String groupId) async {
    List<ContactAddGroupModel> dataLIst = [];
    final response = await _api.post(
      ApiConstants.contactSyncApi,
      headers: {},
      body: {
        "group_id": groupId,
        "contacts": Variables.userContact,
      },
    );
    try {
      (response["data"] as List).forEach((element) {
        dataLIst.add(ContactAddGroupModel.fromJson(element));
      });
      return dataLIst;
    } catch (e) {
      throw e;
    }
  }

  Future<DoubleResponse> addToGroup(
    String groupId,
    List<String> userId,
  ) async {
    try {
      final response = await _api.post(
        ApiConstants.addUsersToGroupApi,
        body: {
          "group_id": groupId,
          "user_ids": userId,
        },
      );

      if (response['success'] == true) {
        return DoubleResponse(true, response['message']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      debugPrint("e");
      rethrow;
    }
  }

  Future<DoubleResponse> changeGroupUserStatuse(
      {required String status,
      required String groupid,
      required String userId,
      required String role}) async {
    try {
      debugPrint('the userid is here$userId');
      final response = await _api.post(
        ApiConstants.changeGroupUserStatusApi,
        body: {
          "group_id": groupid,
          "user_id": userId,
          "role": role,
          "status": status
        },
        headers: {},
      );
      debugPrint("response is here$response");

      if (response['statusCode'] == 200) {
        return DoubleResponse(true, response['message']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
  Future<DoubleResponse> leaveInfoGoupAPi(
      {
      required String groupid,
      
      }) async {
    try {
     
      final response = await _api.post(
        ApiConstants.leaveInfoGroupApi,
        body: {
          "group_id": groupid,
        
        },
        headers: {},
      );
     

      if (response['statusCode'] == 200) {
        return DoubleResponse(true, response['message']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
   Future<DoubleResponse> editGroupNameAndAbout(
      {
      required String groupid,
      required String name,
      required String about,
      
      }) async {
    try {
     
      final response = await _api.post(
        ApiConstants.groupNameUpdateApi,
        body: {
          "group_id": groupid,
          "purpose":about,
        },
        headers: {},
      );
     

      if (response['statusCode'] == 200) {
        return DoubleResponse(true, response['message']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }


    Future<DoubleResponse> onSend(
      {
      required String fromGroupUserId,
      required List<String> groupIds,
      required List<String> messageIds,
      
      }) async {
    try {
     
      final response = await _api.post(
        ApiConstants.forwardMessageApi,
        body: {
          "frm_group_user_id": fromGroupUserId,
          "group_ids":groupIds,
          "message_ids":messageIds
        },
        headers: {},
      );
     debugPrint(response.toString());
      if (response['statusCode'] == 200) {
        return DoubleResponse(true, response['message']);
      } else {
        return DoubleResponse(false, response['message']);
      }
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:info91/src/configs/api_constants.dart';
import 'package:info91/src/models/base_response.dart';
import 'package:info91/src/models/informationgroup/pincode_validation_model.dart';
import 'package:info91/src/models/user.dart';
import 'package:info91/src/resources/auth_repository.dart';
import 'package:info91/src/utils/api_base_helper.dart';

import 'shared_preferences_data_provider.dart';

class UserProfileRepository {
  late final _api = ApiBaseHelper();
  late final _preferences = SharedPreferencesDataProvider();


  Future<void> saveUser(User user) async {
    await _preferences.saveUserId(user.id);
    await _preferences.saveUserName(user.name);
    await _preferences.saveUserMobile(user.phoneNumber);
    await _preferences.saveUserImage(user.image);
    await _preferences.saveUserMail(user.email);
  }

  Future<UserResponse> getUser() async {
    String token = await AuthRepository().getAccessToken();
    var headers = {'Authorization': token};
    final response = await _api.get(ApiConstants.user, headers: headers);
    return UserResponse.fromJson(response);
  }

  Future<BaseResponse> updateUser(String name,String about,String Pincode,String image,ValueChanged<int> onProgress) async {
    String token = await AuthRepository().getAccessToken();
    var header = {'Authorization': token};
    debugPrint(token);
    var body = {
      "full_name":name,
      "about":about,
      "pincode":Pincode
    };
    final response = await _api.postMultipart(ApiConstants.updateUser, body: body,headers: header,file: image);
    return BaseResponse.fromJson(response);
  }
   Future<PincodeResponse> validatePincode(String pincode,) async {
try{
    String token = await AuthRepository().getAccessToken();
    var header = {'Authorization': token};
    debugPrint(token);
    var body = {
      "pincode":pincode,
    
    };
    final response = await _api.post(ApiConstants.validatingPincodeApi, body: body,headers: header,);
    return PincodeResponse.fromJson(response);
}catch(e){
  print("Eroor is here$e");
throw e;
}
  }
}

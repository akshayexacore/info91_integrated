import 'package:flutter/material.dart';
import 'package:info91/src/configs/api_constants.dart';
import 'package:info91/src/models/base_response.dart';
import 'package:info91/src/models/login.dart';
import 'package:info91/src/resources/shared_preferences_data_provider.dart';
import 'package:info91/src/utils/api_base_helper.dart';
import 'package:info91/src/utils/response-utils.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class AuthRepository {
  late final ApiBaseHelper _api = ApiBaseHelper();

  late final _preferences = SharedPreferencesDataProvider();

  Future<String> getAccessToken() async {
    return await _preferences.getAccessToken();
  }

  Future<void> saveAccessToken(String token) async {
    _preferences.saveAccessToken(token);
  }

  Future<String> getRefreshToken() async {
    return await _preferences.getRefreshToken();
  }

  Future<void> saveRefreshToken(String token) async {
    _preferences.saveRefreshToken(token);
  }

  Future<bool> logoutUser() async {
    await _preferences.clear();
    return true;
  }

  Future<BaseResponse> sendOtp(String phone, String code,String deviceId) async {
    var body = {'phone_number': phone, "country_code": code,"device_id":deviceId};
    final response =
        await _api.post(ApiConstants.sendOtp, body: body, headers: {});
    // AppDialog.showToast((response['otp'] ?? '').toString());
    return BaseResponse.fromJson(response);
  }

  Future<BaseResponse> reSendOtp(String phone, String code) async {
    var body = {'phone_number': phone, "country_code": code};
    final response = await _api
        .get(ApiConstants.reSendOtp, queryParameters: body, headers: {});
    // AppDialog.showToast((response['otp'] ?? '').toString());
    return BaseResponse.fromJson(response);
  }

  Future<LoginResponse> verifyOtp(PhoneNumber phone, String otp) async {
    var body = {
      'phone_number': phone.nsn,
      'otp': otp,
      "country_code": phone.countryCode
    };
    final response =
        await _api.post(ApiConstants.verifyOtp, body: body, headers: {});
        
    return LoginResponse.fromJson(response);
  }
     Future<DoubleResponse> upDateFcmToken(
      {
      required String fcmken,
      
     
      
      }) async {
    try {
     
      final response = await _api.post(
        ApiConstants.updateFcmTokenApi,
        body: {
            "fcm_token":fcmken,
         
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

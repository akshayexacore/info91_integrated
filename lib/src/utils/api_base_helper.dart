import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide MultipartFile,Response;
import 'package:http_interceptor/http_interceptor.dart';
import 'package:info91/src/configs/api_constants.dart';
import 'package:info91/src/configs/app_config.dart';
import 'package:info91/src/modules/auth/login/controllers/auth_controller.dart';
import 'package:info91/src/resources/auth_repository.dart';
import 'package:info91/src/resources/shared_preferences_data_provider.dart';
import 'package:info91/src/utils/app_exception.dart';
import 'package:info91/src/widgets/custom/app_dialog.dart';

import 'package:logger/logger.dart';
import 'package:http/http.dart' as flutter_http;

class ApiBaseHelper {
  final String _baseUrl = AppConfig.baseApiUrl;

  final Map<String, String> _headers = AppConfig.headers;
  final Map<String, String> _headersMultipart = AppConfig.headersMultipart;
  late dynamic http;
  ApiBaseHelper() {
    http = InterceptedClient.build(interceptors: [
      MovyApiInterceptor(),
    ], retryPolicy: ExpiredTokenRetryPolicy());
  }

  Future<dynamic> get(
    String url, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    dynamic responseJson;
    try {
      if (headers != null) {
        headers.addAll(_headers);
      }
      var uri =
          Uri.parse(_baseUrl + url).replace(queryParameters: queryParameters);

          print(uri);
      final response = await http.get(uri, headers: headers);
      print(response);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic> body = const {},
      Map<String, String>? headers}) async {
    dynamic responseJson;
    print("the body$body$headers");
    try {
      if (headers != null) {
        headers.addAll(_headers);
      }
      var uri = Uri.parse(_baseUrl + url);
      final response =
          await http.post(uri, body: jsonEncode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> patch(String url,
      {Map<String, dynamic> body = const {},
      Map<String, String>? headers}) async {
    dynamic responseJson;
    try {
      if (headers != null) {
        headers.addAll(_headers);
      }
      var uri = Uri.parse(_baseUrl + url);
      final response =
          await http.patch(uri, body: jsonEncode(body), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postMultipart(String url,
      {Map<String, String>? body,
      Map<String, String>? headers,
      String? key,
      List<String> files = const [],
      String file = ''}) async {
    dynamic responseJson;
    debugPrint("body$body");
    try {
      var uri = Uri.parse(_baseUrl + url);
      var request = MultipartRequest(
        HttpMethod.POST.asString,
        uri,
      );

      if (headers != null) {
        headers.addAll(_headersMultipart);
        request.headers.addAll(headers);
      }
      if (body != null) {
        request.fields.addAll(body);
      }

      if (files.isNotEmpty) {
        for(var i = 0; i < files.length; i++){
          request.files.add(await MultipartFile.fromPath("files", files[i]));
        }
      }

      if (file.isNotEmpty) {
        String keys=key??"image";
        request.files
            .add(await MultipartFile.fromPath(keys, file));
      }

      final streamedResponse = await http.send(request);
      final response = await Response.fromStream(streamedResponse);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url,
      {Map<String, dynamic> body = const {},
      Map<String, String> header = const {}}) async {
    dynamic responseJson;
    try {
      header.addAll(_headers);
      var uri = Uri.parse(_baseUrl + url);
      final response =
          await http.put(uri, body: jsonEncode(body), headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url,
      {Map<String, String> header = const {}}) async {
    dynamic responseJson;
    try {
      header.addAll(_headers);
      var uri = Uri.parse(_baseUrl + url);
      final response = await http.delete(uri, headers: header);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}

dynamic _returnResponse(response) {
  Logger().d("${response.request.url.toString()}\n${response.request.headers.toString()}\n${response.statusCode}\n${response.body}");// \n${response.request.body.toString()}
  switch (response.statusCode) {
    case 200:
    case 201:
    case 204:
    case 400:
    case 401:
    return json.decode(response.body.toString());
    case 422:
      throw BadRequestException(response.body.toString());
    case 403:
      throw UnauthorisedException(
          json.decode(response.body.toString())['message'] ??
              response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}

class MovyApiInterceptor implements InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) async {
    String token = await AuthRepository().getAccessToken();
    print("the token is here$token");
    if(token.isNotEmpty) {
      request.headers["Authorization"] = token;
    }
    print("the headers is here${ request.headers}");
    request.headers['Content-Type'] = 'application/json';
    return request;
  }

  @override
  Future<BaseResponse> interceptResponse({required BaseResponse response}) async {

    return response;
  }

  @override
  Future<bool> shouldInterceptRequest() {
    return Future.value(true);
  }

  @override
  Future<bool> shouldInterceptResponse() {
    return Future.value(true);
  }
}


class ExpiredTokenRetryPolicy extends RetryPolicy {
  @override
  int get maxRetryAttempts => 2;

  @override
  Future<bool> shouldAttemptRetryOnResponse(BaseResponse response) async {
    if (response.statusCode == 401 &&
        !response.request!.url.toString().contains(ApiConstants.verifyOtp)) {
      log("Retrying request...");
      // call refresh api
      try {
        late final preferences = SharedPreferencesDataProvider();
        String refreshToken = await preferences.getRefreshToken();
        final body = {"random_string": refreshToken};
        var uri = Uri.parse(AppConfig.baseApiUrl + ApiConstants.refreshToken);
        final response = await flutter_http.post(uri, body: body);
        log(response.statusCode.toString());
        log(response.body);
        if(response.statusCode == 200){
          var responseJson = json.decode(response.body.toString());

          String token = responseJson['token'] != null ? responseJson['token']['original']['access_token'] : '';

          preferences.saveAccessToken('Bearer $token');
          log("token saved");
          return true;
        }else{
          if(!Get.isRegistered<AuthController>()){
            Get.create(() => AuthController());
          }
          Get.find<AuthController>().logout();
          AppDialog.showToast("Session expired! Please login.");
          return false;
        }
      } on SocketException {
        if(!Get.isRegistered<AuthController>()){
          Get.create(() => AuthController());
        }
        Get.find<AuthController>().logout();
        AppDialog.showToast("Session expired! Please login.");
        return false;
      }
    }
    return false;
  }
}

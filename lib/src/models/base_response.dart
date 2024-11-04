import 'package:info91/src/models/user.dart';

class BaseResponse {
  late int status;
  late String message;
  late bool isSuccess;
  late String tokenType;
  dynamic result;
   bool? exist;
      String? token;
         User? user;

  BaseResponse( 
      {this.status = 0,
      this.user,
      this.message = '',this.exist=false,
      this.isSuccess = false,this.token,
      this.tokenType = '',
      this.result});
  BaseResponse.init();
  BaseResponse.fromJson(Map<String, dynamic> json) {
    status = json['statusCode'] ?? 0;
    message = json['message'] is String ? json['message'] : getStringFromMap(json);
    result = json['data'];
    isSuccess = json['success'] == "success";
    exist=json['exist'] ;
    token=json["token"];
    tokenType = 'Bearer';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['isSuccess'] = isSuccess;
    data['data'] = result;
    return data;
  }

}
String getStringFromMap(data){
  final errorMessageKey = data['message'].keys.first;
  final errorMessageValue = data['message'][errorMessageKey];
  String combinedErrorMessage = "";
  if (errorMessageValue is List<dynamic>) {
    combinedErrorMessage = errorMessageValue.join(', ');
  } else {
    combinedErrorMessage = errorMessageValue;
  }
  return combinedErrorMessage;
}


class FileUploadResponse {
  late bool success;
  late String message;
  late String path;

  FileUploadResponse({this.success = false, this.message = '',this.path = ''});

  FileUploadResponse.fromJson(Map<String, dynamic> json) {
    success = json['statusCode'] == 200;
    message = json['message'] ?? '';
    path = json['data']['filePath'] ?? '';
  }
}
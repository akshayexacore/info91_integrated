class PincodeResponse {
  final String? status;
  final int? statusCode;
  final String? message;
  final List<PincodeData>? data;

  PincodeResponse({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  // Factory method to parse JSON
  factory PincodeResponse.fromJson(Map<String, dynamic> json) {
    return PincodeResponse(
      status: json['status'] as String?,
      statusCode: json['statusCode'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => PincodeData.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // Convert to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusCode': statusCode,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class PincodeData {
  final int? pincodeId;
  final String? pincode;
  final String? postname;

  PincodeData({
    this.pincodeId,
    this.pincode,
    this.postname,
  });

  // Factory method to parse JSON
  factory PincodeData.fromJson(Map<String, dynamic> json) {
    return PincodeData(
      pincodeId: json['pincode_id'] as int?,
      pincode: json['pincode'] as String?,
      postname: json['postname'] as String?,
    );
  }

  // Convert to JSON if needed
  Map<String, dynamic> toJson() {
    return {
      'pincode_id': pincodeId,
      'pincode': pincode,
      'postname': postname,
    };
  }
}

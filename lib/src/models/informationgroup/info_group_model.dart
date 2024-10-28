class GroupInfo {
  final String status;
  final int statusCode;
  final String message;
  final GroupData? data;

  GroupInfo({
    required this.status,
    required this.statusCode,
    required this.message,
    this.data,
  });

  factory GroupInfo.fromJson(Map<String, dynamic> json) {
    return GroupInfo(
      status: json['status'],
      statusCode: json['statusCode'],
      message: json['message'],
      data: json['data'] != null ? GroupData.fromJson(json['data']) : null,
    );
  }
}

class GroupData {
  final String? groupName;
  final String? groupTableName;
  final String? groupUsersTableName;
  final String? type;
  final String? purpose;
  final String? category1;
  final String? category2;
  final String? category3;
  final String? profileImage;
  final String? lastMessageTime;
  final String? lastSender;
  final String? lastSendTime;
  final int? memberCount;
  final int? planId;
  final String? expireDate;
  final String? createdBy;
  final String? mobileNumber;
  final String? alternativeNumber;
  final String? whatsappNumber;
  final String? timings;
  final String? contactTime;
  final String? holidays;
  final String? websiteLink;
  final String? youtubeLink;
  final String? googlemapLink;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final String? groupId;

  GroupData({
    this.groupName,
    this.groupTableName,
    this.groupUsersTableName,
    this.type,
    this.purpose,
    this.category1,
    this.category2,
    this.category3,
    this.profileImage,
    this.lastMessageTime,
    this.lastSender,
    this.lastSendTime,
    this.memberCount,
    this.planId,
    this.expireDate,
    this.createdBy,
    this.mobileNumber,
    this.alternativeNumber,
    this.whatsappNumber,
    this.timings,
    this.contactTime,
    this.holidays,
    this.websiteLink,
    this.youtubeLink,
    this.googlemapLink,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.groupId,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      groupName: json['group_name'],
      groupTableName: json['group_table_name'],
      groupUsersTableName: json['groupusers_table_name'],
      type: json['type'],
      purpose: json['purpose'],
      category1: json['category1'],
      category2: json['category2'],
      category3: json['category3'],
      profileImage: json['profile_image'],
      lastMessageTime: json['last_message_time'],
      lastSender: json['last_sender'],
      lastSendTime: json['last_send_time'],
      memberCount: json['member_count'],
      planId: json['plan_id'],
      expireDate: json['expire_date'],
      createdBy: json['created_by'],
      mobileNumber: json['mobile_number'],
      alternativeNumber: json['alternative_number'],
      whatsappNumber: json['whatsapp_number'],
      timings: json['timings'],
      contactTime: json['contact_time'],
      holidays: json['holidays'],
      websiteLink: json['website_link'],
      youtubeLink: json['youtube_link'],
      googlemapLink: json['googlemap_link'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      status: json['status'],
      groupId: json['group_id'],
    );
  }
}

class InfoGroupDataModel {
  final String? id;
  final String? groupName;
  final String? groupTableName;
  final String? groupusersTableName;
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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final bool? owngroupFlag;
  final bool? joinedGroupFlag;
  final bool? isAdmin;

  InfoGroupDataModel(
      {this.id,
      this.groupName,
      this.groupTableName,
      this.groupusersTableName,
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
      this.owngroupFlag,
      this.joinedGroupFlag,
      this.isAdmin});

  // Factory constructor to create a Group instance from JSON, with null safety
  factory InfoGroupDataModel.fromJson(Map<String, dynamic> json) {
    return InfoGroupDataModel(
      id: json['group_id'] as String?,
      groupName: json['group_name'] as String?,
      groupTableName: json['group_table_name'] as String?,
      groupusersTableName: json['groupusers_table_name'] as String?,
      type: json['type'] as String?,
      purpose: json['purpose'] as String?,
      isAdmin: json["is_admin"] as bool?,
      category1: json['category1'] as String?,
      category2: json['category2'] as String?,
      category3: json['category3'] as String?,
      profileImage: json['profile_image'] as String?,
      lastMessageTime: json['last_message_time'] as String?,
      lastSender: json['last_sender'] as String?,
      lastSendTime: json['last_send_time'] as String?,
      memberCount: json['member_count'] as int?,
      planId: json['plan_id'] as int?,
      expireDate: json['expire_date'] as String?,
      createdBy: json['created_by'] as String?,
      mobileNumber: json['mobile_number'] as String?,
      alternativeNumber: json['alternative_number'] as String?,
      whatsappNumber: json['whatsapp_number'] as String?,
      timings: json['timings'] as String?,
      contactTime: json['contact_time'] as String?,
      holidays: json['holidays'] as String?,
      websiteLink: json['website_link'] as String?,
      youtubeLink: json['youtube_link'] as String?,
      googlemapLink: json['googlemap_link'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      status: json['status'] as String?,
      owngroupFlag: json['owngroup_flag'] as bool?,
      joinedGroupFlag: json['joined_flag'] as bool?,
    );
  }

  // Method to convert a Group instance to JSON, handling nulls properly
  Map<String, dynamic> toJson() {
    return {
      'group_id': id,
      'group_name': groupName,
      "is_admin":isAdmin,
      'group_table_name': groupTableName,
      'groupusers_table_name': groupusersTableName,
      'type': type,
      'purpose': purpose,
      'category1': category1,
      'category2': category2,
      'category3': category3,
      'profile_image': profileImage,
      'last_message_time': lastMessageTime,
      'last_sender': lastSender,
      'last_send_time': lastSendTime,
      'member_count': memberCount,
      'plan_id': planId,
      'expire_date': expireDate,
      'created_by': createdBy,
      'mobile_number': mobileNumber,
      'alternative_number': alternativeNumber,
      'whatsapp_number': whatsappNumber,
      'timings': timings,
      'contact_time': contactTime,
      'holidays': holidays,
      'website_link': websiteLink,
      'youtube_link': youtubeLink,
      'googlemap_link': googlemapLink,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'status': status,
      'owngroup_flag': owngroupFlag,
      'joined_flag': joinedGroupFlag,
    };
  }
}

class InformationGroupCreationModel {
  final String? groupName;
  final String? groupTableName;
  final String? groupUsersTableName;
  final String? type;
  final String? purpose;
  final String? category1;
  final String? category2;
  final String? category3;
  final String? profileImage;
  final int? planId;
  final String? mobileNumber;
  final String? alternativeNumber;
  final String? whatsappNumber;
  final String? timings;
  final String? contactTime;
  final String? holidays;
  final String? websiteLink;
  final String? youtubeLink;
  final String? googleMapLink;

  const InformationGroupCreationModel({
    this.groupName,
    this.groupTableName,
    this.groupUsersTableName,
    this.type,
    this.purpose,
    this.category1,
    this.category2,
    this.category3,
    this.profileImage,
    this.planId,
    this.mobileNumber,
    this.alternativeNumber,
    this.whatsappNumber,
    this.timings,
    this.contactTime,
    this.holidays,
    this.websiteLink,
    this.youtubeLink,
    this.googleMapLink,
  });

  // From JSON
  factory InformationGroupCreationModel.fromJson(Map<String, dynamic> json) {
    return InformationGroupCreationModel(
      groupName: json['group_name'],
      groupTableName: json['group_table_name'],
      groupUsersTableName: json['groupusers_table_name'],
      type: json['type'],
      purpose: json['purpose'],
      category1: json['category1'],
      category2: json['category2'],
      category3: json['category3'],
      profileImage: json['profile_image'],
      planId: json['plan_id'],
      mobileNumber: json['mobile_number'],
      alternativeNumber: json['alternative_number'],
      whatsappNumber: json['whatsapp_number'],
      timings: json['timings'],
      contactTime: json['contact_time'],
      holidays: json['holidays'],
      websiteLink: json['website_link'],
      youtubeLink: json['youtube_link'],
      googleMapLink: json['googlemap_link'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'group_name': groupName,
      'group_table_name': groupTableName,
      'groupusers_table_name': groupUsersTableName,
      'type': type,
      'purpose': purpose,
      'category1': category1,
      'category2': category2,
      'category3': category3,
      'profile_image': profileImage,
      'plan_id': planId,
      'mobile_number': mobileNumber,
      'alternative_number': alternativeNumber,
      'whatsapp_number': whatsappNumber,
      'timings': timings,
      'contact_time': contactTime,
      'holidays': holidays,
      'website_link': websiteLink,
      'youtube_link': youtubeLink,
      'googlemap_link': googleMapLink,
    };
  }

  // CopyWith method for immutability
  InformationGroupCreationModel copyWith({
    String? groupName,
    String? groupTableName,
    String? groupUsersTableName,
    String? type,
    String? purpose,
    String? category1,
    String? category2,
    String? category3,
    String? profileImage,
    int? planId,
    String? mobileNumber,
    String? alternativeNumber,
    String? whatsappNumber,
    String? timings,
    String? contactTime,
    String? holidays,
    String? websiteLink,
    String? youtubeLink,
    String? googleMapLink,
  }) {
    return InformationGroupCreationModel(
      groupName: groupName ?? this.groupName,
      groupTableName: groupTableName ?? this.groupTableName,
      groupUsersTableName: groupUsersTableName ?? this.groupUsersTableName,
      type: type ?? this.type,
      purpose: purpose ?? this.purpose,
      category1: category1 ?? this.category1,
      category2: category2 ?? this.category2,
      category3: category3 ?? this.category3,
      profileImage: profileImage ?? this.profileImage,
      planId: planId ?? this.planId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      alternativeNumber: alternativeNumber ?? this.alternativeNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      timings: timings ?? this.timings,
      contactTime: contactTime ?? this.contactTime,
      holidays: holidays ?? this.holidays,
      websiteLink: websiteLink ?? this.websiteLink,
      youtubeLink: youtubeLink ?? this.youtubeLink,
      googleMapLink: googleMapLink ?? this.googleMapLink,
    );
  }
}

//chatgroup list
class InfoGroupChatListModel {
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
  final String? lastmessage;
  final String? unReadCount;

  InfoGroupChatListModel({
    this.id,
    this.groupName,
    this.groupTableName,
    this.groupusersTableName,
    this.type,this.lastmessage,
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
    this.joinedGroupFlag,
    this.createdBy,
    this.mobileNumber,this.unReadCount,
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
  });

  // Factory constructor to create a Group instance from JSON
  factory InfoGroupChatListModel.fromJson(Map<String, dynamic> json) {
    return InfoGroupChatListModel(
      id: json['group_id'],
      unReadCount: json['unread_count'],
      lastmessage: json["last_message"],
      joinedGroupFlag: json['joined_flag'] ?? true,
      groupName: json['group_name'],
      groupTableName: json['group_table_name'],
      groupusersTableName: json['groupusers_table_name'],
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
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      status: json['status'],
      owngroupFlag: json['owngroup_flag'],
    );
  }

  // Method to convert a Group instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'group_id': id,
      "unread_count":unReadCount,
      "last_message":lastmessage,
      'group_name': groupName,
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
      'joined_flag': joinedGroupFlag,
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
    };
  }

  // CopyWith method
  InfoGroupChatListModel copyWith(
      {String? id,
      String? groupName,
      String? groupTableName,
      String? groupusersTableName,
      String? type,
      String? purpose,
      String? category1,
      String? category2,
      String? category3,
      String? profileImage,
      String? lastMessageTime,
      String? lastSender,
      String? lastSendTime,
      int? memberCount,
      int? planId,
      String? expireDate,
      String? createdBy,
      String? mobileNumber,
      String? alternativeNumber,
      String? whatsappNumber,
      String? timings,
      String? contactTime,
      String? holidays,
      String? websiteLink,
      String? youtubeLink,
      String? googlemapLink,
      DateTime? createdAt,
      DateTime? updatedAt,
      String? status,
      bool? owngroupFlag,
      bool? joinedflad,String? unReadCount,String? latMessage }) {
    return InfoGroupChatListModel(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,unReadCount: unReadCount??this.unReadCount,
      lastmessage: latMessage??this.lastmessage,
      groupTableName: groupTableName ?? this.groupTableName,
      groupusersTableName: groupusersTableName ?? this.groupusersTableName,
      type: type ?? this.type,
      purpose: purpose ?? this.purpose,
      category1: category1 ?? this.category1,
      category2: category2 ?? this.category2,
      category3: category3 ?? this.category3,
      profileImage: profileImage ?? this.profileImage,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastSender: lastSender ?? this.lastSender,
      lastSendTime: lastSendTime ?? this.lastSendTime,
      memberCount: memberCount ?? this.memberCount,
      planId: planId ?? this.planId,
      joinedGroupFlag: joinedflad ?? this.joinedGroupFlag,
      expireDate: expireDate ?? this.expireDate,
      createdBy: createdBy ?? this.createdBy,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      alternativeNumber: alternativeNumber ?? this.alternativeNumber,
      whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      timings: timings ?? this.timings,
      contactTime: contactTime ?? this.contactTime,
      holidays: holidays ?? this.holidays,
      websiteLink: websiteLink ?? this.websiteLink,
      youtubeLink: youtubeLink ?? this.youtubeLink,
      googlemapLink: googlemapLink ?? this.googlemapLink,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      owngroupFlag: owngroupFlag ?? this.owngroupFlag,
    );
  }
}

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
  final String? tagKey1;
  final String? tagKey2;
  final String? tagKey3;
   final String? email;

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
    this.tagKey1,
    this.tagKey2,
    this.tagKey3,
    this.email,
  });

  // From JSON
  factory InformationGroupCreationModel.fromJson(Map<String, dynamic> json) {
    return InformationGroupCreationModel(
      groupName: json['group_name'],
      groupTableName: json['group_table_name'],
      groupUsersTableName: json['groupusers_table_name'],
      type: json['type'],
      purpose: json['address'],
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
      email:  json['email'],
      tagKey1:  json['tag_key_1'],
      tagKey2:  json['tag_key_2'],
      tagKey3:  json['tag_key_3'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'group_name': groupName,
      'group_table_name': groupTableName,
      'groupusers_table_name': groupUsersTableName,
      'type': type,
      'address': purpose,
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
      'email':email,
      "tag_key_1":tagKey1,
      "tag_key_2":tagKey2,
      "tag_key_3":tagKey3

      
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
    String ? email,
    String? key1,
    String? key2,
    String? key3
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
  final LastMessage? lastmessage;
  final String? unReadCount;
  final String? groupAprovedFlag;

  InfoGroupChatListModel({
    this.id,
    this.groupName,
    this.groupTableName,
    this.groupusersTableName,
    this.type,
    this.lastmessage,
    this.purpose,
    this.category1,
    this.category2,
    this.category3,
    this.profileImage,
    this.lastMessageTime,
    this.lastSender,
    this.lastSendTime,
    this.memberCount,
    this.groupAprovedFlag,
    this.planId,
    this.expireDate,
    this.joinedGroupFlag,
    this.createdBy,
    this.mobileNumber,
    this.unReadCount,
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
        lastmessage: json['last_message'] != null
          ? LastMessage.fromJson(json['last_message'])
          : null,
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
      groupAprovedFlag: json['group_approved_flag'],
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
      "unread_count": unReadCount,
      "last_message":lastmessage?.toJson(),
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
      "group_approved_flag": groupAprovedFlag,
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
      bool? joinedflad,
      String? unReadCount,
      LastMessage? latMessage,String? groupAprovedFlag}) {
    return InfoGroupChatListModel(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      unReadCount: unReadCount ?? this.unReadCount,
      lastmessage: latMessage ?? this.lastmessage,
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
      groupAprovedFlag: groupAprovedFlag??this.groupAprovedFlag,
      owngroupFlag: owngroupFlag ?? this.owngroupFlag,
    );
  }
}
class LastMessage {
  final String? message;
  final String? type;
  final String? userId;
  final String? name;
  final String? phoneNumber;
  final String? lastMessageTime;
  final bool? isMe;

  const LastMessage({
    this.message,
    this.type,
    this.userId,
    this.name,
    this.phoneNumber,
    this.lastMessageTime,
    this.isMe
  });

  // Factory constructor for creating an instance from JSON
  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      message: json['message'] as String?,
      type: json['type'] as String?,
      userId: json['user_id'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      lastMessageTime: json['last_message_time'] as String?,
      isMe: json["is_me"] as bool?
    );
  }

  // Method for converting an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'type': type,
      'user_id': userId,
      'name': name,
      'phone_number': phoneNumber,
      'last_message_time': lastMessageTime,
      "is_me":isMe
    };
  }
}

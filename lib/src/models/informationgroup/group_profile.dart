class GroupProfileModel {
  final String? id;
  final String? groupName;
  final String? groupTableName;
  final String? groupUsersTableName;
  final String? type;
  final String? purpose;
  final String? category1;
  final String? category2;
  final String? category3;
  final String? profileImage;
  final String? coverImage;
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
  final String? googleMapLink;
  final String? createdAt;
  final String? updatedAt;
  final String? status;
  final bool? memberFlag;
  final int? membersCount;
  final List<Member>? members;
  final List<BannerModel>? banners;
  final bool? isAdmin;

  GroupProfileModel({
    this.id,
    this.groupName,
    this.groupTableName,
    this.groupUsersTableName,
    this.type,
    this.purpose,
    this.category1,
    this.category2,
    this.category3,
    this.profileImage,
    this.coverImage,
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
    this.googleMapLink,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.memberFlag,
    this.membersCount,
    this.members,
    this.banners,this.isAdmin,
  });

  factory GroupProfileModel.fromJson(Map<String, dynamic> json) {
    return GroupProfileModel(
      id: json['id'] as String?,
      isAdmin: json['is_admin'] as bool?,
      groupName: json['group_name'] as String?,
      groupTableName: json['group_table_name'] as String?,
      groupUsersTableName: json['groupusers_table_name'] as String?,
      type: json['type'] as String?,
      purpose: json['purpose'] as String?,
      category1: json['category1'] as String?,
      category2: json['category2'] as String?,
      category3: json['category3'] as String?,
      profileImage: json['profile_image'] as String?,
      coverImage: json['cover_image'] as String?,
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
      googleMapLink: json['googlemap_link'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      status: json['status'] as String?,
      memberFlag: json['member_flag'] as bool?,
      membersCount: json['members_count'] as int?,
      members: (json['members'] as List?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      banners: (json['banners'] as List?)
          ?.map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  GroupProfileModel copyWith({
    String? id,
    String? groupName,
    String? groupTableName,
    String? groupUsersTableName,
    String? type,
    String? purpose,
    String? category1,
    String? category2,
    String? category3,
    String? profileImage,
    String? coverImage,
    String? lastMessageTime,
    String? lastSender,
    String? lastSendTime,
    int? memberCount,
    bool? isAdmin,
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
    String? googleMapLink,
    String? createdAt,
    String? updatedAt,
    String? status,
    bool? memberFlag,
    int? membersCount,
    List<Member>? members,
    List<BannerModel>? banners,
  }) {
    return GroupProfileModel(
      id: id ?? this.id,
      groupName: groupName ?? this.groupName,
      groupTableName: groupTableName ?? this.groupTableName,
      groupUsersTableName: groupUsersTableName ?? this.groupUsersTableName,
      type: type ?? this.type,
      purpose: purpose ?? this.purpose,
      category1: category1 ?? this.category1,
      category2: category2 ?? this.category2,
      category3: category3 ?? this.category3,
      profileImage: profileImage ?? this.profileImage,
      coverImage: coverImage ?? this.coverImage,
      isAdmin: isAdmin??this.isAdmin,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      lastSender: lastSender ?? this.lastSender,
      lastSendTime: lastSendTime ?? this.lastSendTime,
      memberCount: memberCount ?? this.memberCount,
      planId: planId ?? this.planId,
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
      googleMapLink: googleMapLink ?? this.googleMapLink,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      memberFlag: memberFlag ?? this.memberFlag,
      membersCount: membersCount ?? this.membersCount,
      members: members ?? this.members,
      banners: banners ?? this.banners,
    );
  }
}

class Member {
  final String? userId;
  final String? role;
  final String? status;
  final String? phoneNumber;
  final String? name;
  final int? id;

  Member({
    this.userId,
    this.role,
    this.status,
    this.phoneNumber,
    this.name,
    this.id,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      userId: json['user_id'] as String?,
      role: json['role'] as String?,
      status: json['status'] as String?,
      phoneNumber: json['phone_number'] as String?,
      name: json['name'] as String?,
      id: json['id'] as int?,
    );
  }

  Member copyWith({
    String? userId,
    String? role,
    String? status,
    String? phoneNumber,
    String? name,
    int? id,
  }) {
    return Member(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}

class BannerModel {
  final String? image;
  final String? title;
  final String? description;

  BannerModel({
    this.image,
    this.title,
    this.description,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
    );
  }

  BannerModel copyWith({
    String? image,
    String? title,
    String? description,
  }) {
    return BannerModel(
      image: image ?? this.image,
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}

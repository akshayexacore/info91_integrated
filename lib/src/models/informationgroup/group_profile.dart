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
  final MediaList? mediaList;

  GroupProfileModel( {
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
    this.banners,
    this.isAdmin,this.mediaList,
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
      memberCount: json['members_count'] as int?,
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
      mediaList: json['media_list'] != null
          ? MediaList.fromJson(json['media_list'])
          : null,
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
      isAdmin: isAdmin ?? this.isAdmin,
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
  }  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_name': groupName,
      'group_table_name': groupTableName,
      'groupusers_table_name': groupUsersTableName,
      'type': type,
      'purpose': purpose,
      'category1': category1,
      'category2': category2,
      'category3': category3,
      'profile_image': profileImage,
      'cover_image': coverImage,
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
      'googlemap_link': googleMapLink,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'status': status,
      'member_flag': memberFlag,
      'members_count': membersCount,
      'members': members?.map((e) => e.toJson()).toList(),
      'banners': banners?.map((e) => e.toJson()).toList(),
      'is_admin': isAdmin,
      'media_list': mediaList?.toJson(),
    };
  }

}

class Member {
  final String? userId;
  final String? role;
  final String? status;
  final String? phoneNumber;
  final String? name;
  final int? id;
  final String? about;

  Member({
    this.userId,
    this.role,
    this.status,
    this.phoneNumber,
    this.name,
    this.about,
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
      about: json["about"] as String?,
    );
  }

  Member copyWith({
    String? userId,
    String? role,
    String? status,
    String? phoneNumber,
    String? name,
    int? id,
    String? about,
  }) {
    return Member(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      id: id ?? this.id,
      about: about ?? this.about,
    );
  }  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'role': role,
      'status': status,
      'phone_number': phoneNumber,
      'name': name,
      'id': id,
      'about': about,
    };
  }
}

class BannerModel {
  final String? image;
  final String? id;
  final String? title;
  final String? description;

  BannerModel({this.image, this.title, this.description, this.id});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      image: json['image'] as String?,
      title: json['title'] as String?,
      id: json["id"] as String?,
      description: json['description'] as String?,
    );
  }
  BannerModel copyWith(
      {String? image, String? title, String? description, String? id}) {
    return BannerModel(
      image: image ?? this.image,
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
    Map<String, dynamic> toJson() {
    return {
      'image': image,
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
class MediaItem {
  final String? messageId;
  final String? userId;
  final String? type;
  final String? message;
  final String? createdAt;
  final String? phoneNumber;
  final String? name;
  final String? date;
  final String? time;
  final bool? isMe;
  final String? filesize;
  final String? filename;
  final String? filetype;
  final int? filepages;

  MediaItem({
    this.messageId,
    this.userId,
    this.type,
    this.message,
    this.createdAt,
    this.phoneNumber,
    this.name,
    this.date,
    this.time,
    this.isMe,
    this.filesize,
    this.filename,
    this.filetype,
    this.filepages,
  });

  factory MediaItem.fromJson(Map<String, dynamic> json) {
    return MediaItem(
      messageId: json['message_id'],
      userId: json['user_id'],
      type: json['type'],
      message: json['message'],
      createdAt: json['created_at'],
      phoneNumber: json['phone_number'],
      name: json['name'],
      date: json['date'],
      time: json['time'],
      isMe: json['is_me'],
      filesize: json['filesize'],
      filename: json['filename'],
      filetype: json['filetype'],
      filepages: json['filepages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'user_id': userId,
      'type': type,
      'message': message,
      'created_at': createdAt,
      'phone_number': phoneNumber,
      'name': name,
      'date': date,
      'time': time,
      'is_me': isMe,
      'filesize': filesize,
      'filename': filename,
      'filetype': filetype,
      'filepages': filepages,
    };
  }

  MediaItem copyWith({
    String? messageId,
    String? userId,
    String? type,
    String? message,
    String? createdAt,
    String? phoneNumber,
    String? name,
    String? date,
    String? time,
    bool? isMe,
    String? filesize,
    String? filename,
    String? filetype,
    int? filepages,
  }) {
    return MediaItem(
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      date: date ?? this.date,
      time: time ?? this.time,
      isMe: isMe ?? this.isMe,
      filesize: filesize ?? this.filesize,
      filename: filename ?? this.filename,
      filetype: filetype ?? this.filetype,
      filepages: filepages ?? this.filepages,
    );
  }
}

class MediaList {
  final List<MediaItem>? imageList;
  final List<MediaItem>? videoList;
  final List<MediaItem>? audioList;
  final List<MediaItem>? documentList;

  MediaList({
    this.imageList,
    this.videoList,
    this.audioList,
    this.documentList,
  });

  factory MediaList.fromJson(Map<String, dynamic> json) {
    return MediaList(
      imageList: (json['image_list'] as List<dynamic>?)
          ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoList: (json['video_list'] as List<dynamic>?)
          ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      audioList: (json['audio_list'] as List<dynamic>?)
          ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      documentList: (json['document_list'] as List<dynamic>?)
          ?.map((e) => MediaItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image_list': imageList?.map((e) => e.toJson()).toList(),
      'video_list': videoList?.map((e) => e.toJson()).toList(),
      'audio_list': audioList?.map((e) => e.toJson()).toList(),
      'document_list': documentList?.map((e) => e.toJson()).toList(),
    };
  }

  MediaList copyWith({
    List<MediaItem>? imageList,
    List<MediaItem>? videoList,
    List<MediaItem>? audioList,
    List<MediaItem>? documentList,
  }) {
    return MediaList(
      imageList: imageList ?? this.imageList,
      videoList: videoList ?? this.videoList,
      audioList: audioList ?? this.audioList,
      documentList: documentList ?? this.documentList,
    );
  }
}

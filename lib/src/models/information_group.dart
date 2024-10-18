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

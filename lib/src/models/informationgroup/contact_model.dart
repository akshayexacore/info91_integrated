class ContactAddGroupModel {
  final String? originalNumber;
  final String? formattedNumber;
  final String? displayName;
  final bool? exists;
  final bool? existGoup;
  final String? name;
  final String? about;
  final String? profileImage;
  final String ? userId;

  ContactAddGroupModel({
    this.originalNumber,
    this.formattedNumber,
    this.displayName,
    this.exists,
    this.name,
    this.about,
    this.profileImage,
    this.userId,this.existGoup,
  });

  factory ContactAddGroupModel.fromJson(Map<String, dynamic> json) {
    return ContactAddGroupModel(
      originalNumber: json['original_number'] as String?,
      formattedNumber: json['formatted_number'] as String?,
      displayName: json['displayName'] as String?,
      exists: json['exists'] as bool?,
      name: json['name'] as String?,
      about: json['about'] as String?,
      userId: json['user_id'] as String?,
      existGoup: json['group_exists'] as bool?,
      profileImage: json['profile_image'] as String?,
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'original_number': originalNumber,
      'formatted_number': formattedNumber,
      'displayName': displayName,
      'exists': exists,
      'name': name,
      'about': about,
      'profile_image': profileImage,
      "user_id":userId,
    };
  }


  ContactAddGroupModel copyWith({
    String? originalNumber,
    String? formattedNumber,
    String? displayName,
    bool? exists,
    String? name,
    String? about,
    String? profileImage,
  }) {
    return ContactAddGroupModel(
      originalNumber: originalNumber ?? this.originalNumber,
      formattedNumber: formattedNumber ?? this.formattedNumber,
      displayName: displayName ?? this.displayName,
      exists: exists ?? this.exists,
      name: name ?? this.name,
      about: about ?? this.about,
      userId:userId,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

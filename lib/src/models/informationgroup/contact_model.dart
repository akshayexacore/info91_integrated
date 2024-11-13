class ContactModel {
  final String? originalNumber;
  final String? formattedNumber;
  final String? displayName;
  final bool? exists;
  final String? name;
  final String? about;
  final String? profileImage;

  ContactModel({
    this.originalNumber,
    this.formattedNumber,
    this.displayName,
    this.exists,
    this.name,
    this.about,
    this.profileImage,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      originalNumber: json['original_number'] as String?,
      formattedNumber: json['formatted_number'] as String?,
      displayName: json['displayName'] as String?,
      exists: json['exists'] as bool?,
      name: json['name'] as String?,
      about: json['about'] as String?,
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
    };
  }


  ContactModel copyWith({
    String? originalNumber,
    String? formattedNumber,
    String? displayName,
    bool? exists,
    String? name,
    String? about,
    String? profileImage,
  }) {
    return ContactModel(
      originalNumber: originalNumber ?? this.originalNumber,
      formattedNumber: formattedNumber ?? this.formattedNumber,
      displayName: displayName ?? this.displayName,
      exists: exists ?? this.exists,
      name: name ?? this.name,
      about: about ?? this.about,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

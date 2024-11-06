

import 'dart:typed_data';

class ChatMessage {
  final String? messageId;
  final String? userId;
  final String? type;
  final String? message;
  final String? messageStatus;
  final String? createdAt;
  final bool? replyFlag;
  final bool? reactionFlag;
  final String? image;
  final String? phoneNumber;
  final String? name;
  final String? replyType;
  final String? date;
  final String? time;
  final bool? isMe;
  final bool isSelcted;
  final String? reaction;
  final List<ContactModel>? contactList;
  
  final ReplyDetails? replyDetails;

  ChatMessage({
    this.messageId,
    this.userId,
    this.type,
    this.message,this.contactList,
    this.isSelcted=false,
    this.isMe,this.reaction,
    this.messageStatus,
    this.createdAt,
    this.replyFlag,
    this.reactionFlag,
    this.image,
    this.phoneNumber,
    this.name,
    this.replyType,
    this.date,
    this.time,
    this.replyDetails,
  });

  // CopyWith method
  ChatMessage copyWith({
    String? messageId,
    String? userId,
    String? type,
    String? message,
    String? messageStatus,
    String? createdAt,
    bool? replyFlag,
    bool? reactionFlag,
    String? image,
    bool? isSelected,
    String? phoneNumber,
    String? name,
    String? replyType,
    String? date,
    String? time,
    bool? isMe,
    String? reaction,
     List<ContactModel>?contactList, 
    ReplyDetails? replyDetails,
  }) {
    return ChatMessage(
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      message: message ?? this.message,
      contactList: contactList??this.contactList,
      isMe: isMe??this.isMe,reaction: reaction??this.reaction,
      isSelcted: isSelected??this.isSelcted,
      messageStatus: messageStatus ?? this.messageStatus,
      createdAt: createdAt ?? this.createdAt,
      replyFlag: replyFlag ?? this.replyFlag,
      reactionFlag: reactionFlag ?? this.reactionFlag,
      image: image ?? this.image,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      name: name ?? this.name,
      replyType: replyType ?? this.replyType,
      date: date ?? this.date,
      time: time ?? this.time,
      replyDetails: replyDetails ?? this.replyDetails,
    );
  }

  // From JSON method
  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageId: json['message_id'] as String?,
      isMe: json["is_me"] as bool?,
      userId: json['user_id'] as String?,
      type: json['type'] as String?,
      message: json['message'] as String?,
      messageStatus: json['message_status'] as String?,
      createdAt: json['created_at'] as String?,
      replyFlag: json['reply_flag'] as bool?,
      reactionFlag: json['reaction_flag'] as bool?,
      image: json['image'] as String?,
      phoneNumber: json['phone_number'] as String?,
      name: json['name'] as String?,
      replyType: json['reply_type'] as String?,
       contactList: (json['contact_list'] as List)
          .map((contact) => ContactModel.fromJson(contact))
          .toList(),
      date: json['date'] as String?,
      time: json['time'] as String?,
      replyDetails: json['reply_details'] != null
          ? ReplyDetails.fromJson(json['reply_details'] as Map<String, dynamic>)
          : null,
    );
  }

  // To List method
  static List<ChatMessage> toList(List<dynamic> jsonList) {
    return jsonList.map((json) => ChatMessage.fromJson(json as Map<String, dynamic>)).toList();
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'user_id': userId,
      'type': type,
      "is_me":isMe,
      'message': message,
      'message_status': messageStatus,
      'created_at': createdAt,
      'reply_flag': replyFlag,
      'reaction_flag': reactionFlag,
      'image': image,
      'phone_number': phoneNumber,
      'name': name,
      'reply_type': replyType,
      'date': date,
      'time': time,
      'reply_details': replyDetails?.toJson(),
    };
  }
}

class ReplyDetails {
  final String? messageId;
  final String? message;
  final String? type;
  final String? name;
  final String? phoneNumber;

  ReplyDetails({
    this.messageId,
    this.message,
    this.type,
    this.name,
    this.phoneNumber,
  });

  // CopyWith method
  ReplyDetails copyWith({
    String? messageId,
    String? message,
    String? type,
    String? name,
    String? phoneNumber,
  }) {
    return ReplyDetails(
      messageId: messageId ?? this.messageId,
      message: message ?? this.message,
      type: type ?? this.type,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  // From JSON method
  factory ReplyDetails.fromJson(Map<String, dynamic> json) {
    return ReplyDetails(
      messageId: json['message_id'] as String?,
      message: json['message'] as String?,
      type: json['type'] as String?,
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'message_id': messageId,
      'message': message,
      'type': type,
      'name': name,
      'phone_number': phoneNumber,
    };
  }
}
class ContactModel {
  final String id;
  final String displayName;
  final Uint8List? thumbnail;

  ContactModel({
    required this.id,
    required this.displayName,
    required this.thumbnail,
  });

  // Factory constructor to create an instance from JSON
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] as String,
      displayName: json['displayName'] as String,
        thumbnail: json['thumbnail'] != null
          ? Uint8List.fromList(List<int>.from(json['thumbnail']))
          : null,
    );
  }

  // Method to convert the instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'displayName': displayName,
      'thumbnail': thumbnail,
    };
  }
}

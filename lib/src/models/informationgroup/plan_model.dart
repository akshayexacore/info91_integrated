class PlanModel {
  final int? id; // Nullable and final
  final String? planName; // Nullable and final
  final double? amount; // Nullable and final
  final int? duration; // Nullable and final
  final double? tax; // Nullable and final
  final int? totalMembers; // Nullable and final
  final String? status; // Nullable and final
  final DateTime? createdAt; // Nullable and final
  final DateTime? updatedAt; // Nullable and final

  PlanModel({
    this.id,
    this.planName,
    this.amount,
    this.duration,
    this.tax,
    this.totalMembers,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'],
      planName: json['plan_name'],
      amount: json['amount'],
      duration: json['duration'],
      tax: json['tax'],
      totalMembers: json['total_members'],
      status: json['status'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plan_name': planName,
      'amount': amount,
      'duration': duration,
      'tax': tax,
      'total_members': totalMembers,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

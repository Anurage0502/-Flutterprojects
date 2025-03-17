import 'dart:convert';

class Coupon {
  final int id;
  final String code;
  final DiscountType discountType;
  final double discountValue;
  final Category category;
  final DateTime expiryDate;
  final int usageCount;
  final CouponStatus status;
  final DateTime createdAt;
  final double? minimumOrderValue;
  final bool? isFirstTimeUserOnly;

  Coupon({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.category,
    required this.expiryDate,
    required this.usageCount,
    required this.status,
    required this.createdAt,
    this.minimumOrderValue,
    this.isFirstTimeUserOnly,
  });

  static Future<Coupon> fromJson(Map<String, dynamic> json) async {
    return Coupon(
      id: json['id'],
      code: json['code'],
      discountType: DiscountType.values.byName(json['discountType']),
      discountValue: (json['discountValue'] as num).toDouble(),
      category: Category.values.byName(json['category']),
      expiryDate: DateTime.parse(json['expiryDate']),
      usageCount: json['usageCount'],
      status: CouponStatus.values.byName(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      minimumOrderValue: json['minimumOrderValue'] != null
          ? (json['minimumOrderValue'] as num).toDouble()
          : null,
      isFirstTimeUserOnly: json['isFirstTimeUserOnly'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountType': discountType.name,
      'discountValue': discountValue,
      'category': category.name,
      'expiryDate': expiryDate.toIso8601String(),
      'usageCount': usageCount,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'minimumOrderValue': minimumOrderValue,
      'isFirstTimeUserOnly': isFirstTimeUserOnly,
    };
  }
}

enum DiscountType { PERCENTAGE, FLAT }

enum Category { VEG, NON_VEG, ALL }

enum CouponStatus { ACTIVE, INACTIVE, DISCARDED }

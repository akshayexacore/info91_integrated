class Category {
  final int id;
  final String firstCategoryName;

  Category({
    required this.id,
    required this.firstCategoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      firstCategoryName: json['first_category_name'],
    );
  }

  // Method to convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_category_name': firstCategoryName,
    };
  }
}


class SecondCategory {
  final int? id;
  final String? secondCategoryName;
  final int? firstCategoryId;
  final Category? firstCategory;
  final bool isVal;

  SecondCategory({
    this.id,
    this.secondCategoryName,
    this.firstCategoryId,
    this.firstCategory,
    this.isVal = true,
  });

  // Factory method to create SecondCategory from JSON
  factory SecondCategory.fromJson(Map<String, dynamic> json) {
    return SecondCategory(
      id: json['second_category_id'],
      secondCategoryName: json['second_category_name'],
      firstCategoryId: json['first_category_id'],
      firstCategory: json['first_category'] != null 
          ? Category.fromJson(json['first_category']) 
          : null, // Check for null before calling fromJson
    );
  }

  // Method to convert SecondCategory to JSON
  Map<String, dynamic> toJson() {
    return {
      'second_category_id': id,
      'second_category_name': secondCategoryName,
      'first_category_id': firstCategoryId,
      'first_category': firstCategory?.toJson(),
    };
  }
}



class ThirdCategoryModel {
  final int? id;
  final String? thirdCategoryName;
  final int? secondCategoryId;
  final SecondCategory? secondCategory;

  ThirdCategoryModel({
    this.id,
    this.thirdCategoryName,
    this.secondCategoryId,
    this.secondCategory,
  });

  factory ThirdCategoryModel.fromJson(Map<String, dynamic> json) {
    return ThirdCategoryModel(
      id: json['third_category_id'],
      thirdCategoryName: json['third_category_name'],
      secondCategoryId: json['second_category_id'],
      secondCategory: json['second_category'] != null 
          ? SecondCategory.fromJson(json['second_category']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'third_category_id': id,
      'third_category_name': thirdCategoryName,
      'second_category_id': secondCategoryId,
      'second_category': secondCategory?.toJson(),
    };
  }
}

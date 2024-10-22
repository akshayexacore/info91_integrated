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
  final String?secondCategoryName;
  final int? firstCategoryId;
  final Category? firstCategory;

  SecondCategory({
     this.id,
     this.secondCategoryName,
     this.firstCategoryId,
     this.firstCategory,
  });

  // Factory method to create SecondCategory from JSON
  factory SecondCategory.fromJson(Map<String, dynamic> json) {
    return SecondCategory(
      id: json['id'],
      secondCategoryName: json['second_category_name'],
      firstCategoryId: json['first_category_id'],
      firstCategory: Category.fromJson(json['first_category']),
    );
  }

  // Method to convert SecondCategory to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'second_category_name': secondCategoryName,
      'first_category_id': firstCategoryId,
      'first_category': firstCategory?.toJson(),
    };
  }
}
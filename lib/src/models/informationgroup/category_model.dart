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

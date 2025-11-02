class Category {
  final int categoryId;
  final String name;

  const Category({
    required this.categoryId,
    required this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        categoryId: (json['categoryId'] as num?)?.toInt() ?? 0,
        name: (json['name'] as String?) ?? '',
      );

  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'name': name,
      };
}

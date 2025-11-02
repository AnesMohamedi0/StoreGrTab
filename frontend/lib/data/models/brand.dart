class Brand {
  final int brandId;
  final String name;
  final String? photoUrl;

  const Brand({
    required this.brandId,
    required this.name,
    this.photoUrl,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        brandId: (json['brandId'] as num?)?.toInt() ?? 0,
        name: (json['name'] as String?) ?? '',
        photoUrl: json['photoUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'brandId': brandId,
        'name': name,
        'photoUrl': photoUrl,
      };
}

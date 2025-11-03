class Product {
  final int productId;
  final String name;
  final double price;
  final String? photoUrl;
  final int brandId;
  final double actifAreaX;
  final double actifAreaY;

  const Product({
    required this.productId,
    required this.name,
    required this.price,
    this.photoUrl,
    required this.brandId,
    required this.actifAreaX,
    required this.actifAreaY,
  });

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: (json['productId'] as num?)?.toInt() ?? 0,
    name: (json['name'] as String?) ?? '',
    price: _toDouble(json['price']),
    photoUrl: json['photoUrl'] as String?,
    brandId: (json['brandId'] as num?)?.toInt() ?? 0,
    actifAreaX: _toDouble(json['actifAreaX']),
    actifAreaY: _toDouble(json['actifAreaY']),
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'price': price,
    'photoUrl': photoUrl,
    'brandId': brandId,
    'actifAreaX': actifAreaX,
    'actifAreaY': actifAreaY,
  };
}

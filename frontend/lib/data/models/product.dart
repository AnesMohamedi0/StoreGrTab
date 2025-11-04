class Product {
  final int productId;
  final String name;
  final double price;
  final double? oldPrice;
  final String? photoUrl;
  final int brandId;
  final double actifAreaX;
  final double actifAreaY;
  final bool isNew;
  final bool isAlmostSoldOut;
  final String? description;

  const Product({
    required this.productId,
    required this.name,
    required this.price,
    this.photoUrl,
    required this.brandId,
    required this.actifAreaX,
    required this.actifAreaY,
    this.oldPrice,
    this.isNew = false,
    this.isAlmostSoldOut = false,
    this.description,
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
    oldPrice: _toDouble(json['oldPrice']),
    isNew: (json['isNew'] as bool?) ?? false,
    isAlmostSoldOut: (json['isAlmostSoldOut'] as bool?) ?? false,
    description: json['description'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'name': name,
    'price': price,
    'photoUrl': photoUrl,
    'brandId': brandId,
    'actifAreaX': actifAreaX,
    'actifAreaY': actifAreaY,
    'oldPrice': oldPrice,
    'isNew': isNew,
    'isAlmostSoldOut': isAlmostSoldOut,
    'description': description,
  };
}

class Order {
  final int orderId;
  final String name;
  final String lastName;
  final String phone;
  final double totalPrice;
  final DateTime orderDate;
  final int communeId;
  final int deliveryType;
  final List<(int, int)> products; // List of (ProductId, Quantity)

  const Order({
    required this.orderId,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.totalPrice,
    required this.orderDate,
    required this.communeId,
    required this.deliveryType,
    this.products = const [],
  });

  // Helper method to convert products list to comma-separated string
  String productsToString(List<(int, int)> products) {
    List<int> allIds = [];
    for (var (productId, quantity) in products) {
      for (int i = 0; i < quantity; i++) {
        allIds.add(productId);
      }
    }
    return allIds.join(',');
  }

  // Helper method to convert comma-separated string to products list
  List<(int, int)> stringToProducts(String productsString) {
    if (productsString.isEmpty) return [];

    final ids = productsString.split(',').map(int.parse).toList();

    // Group by productId and count occurrences
    final Map<int, int> productCounts = {};
    for (int id in ids) {
      productCounts[id] = (productCounts[id] ?? 0) + 1;
    }

    return productCounts.entries
        .map((entry) => (entry.key, entry.value))
        .toList();
  }

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    final order = Order(
      orderId: (json['orderId'] as num?)?.toInt() ?? 0,
      name: (json['name'] as String?) ?? '',
      lastName: (json['familyName'] as String?) ?? '',
      phone: (json['phone'] as String?) ?? '',
      totalPrice: _toDouble(json['totalPrice']),
      orderDate:
          DateTime.tryParse(json['orderDate']?.toString() ?? '') ??
          DateTime.now(),
      communeId: (json['communeId'] as num?)?.toInt() ?? 0,
      deliveryType: (json['deliveryType'] as num?)?.toInt() ?? 0,
      products: const [], // Will be set below
    );

    // Convert products string to list
    final productsString = json['products'] as String? ?? '';
    return Order(
      orderId: order.orderId,
      name: order.name,
      lastName: order.lastName,
      phone: order.phone,
      totalPrice: order.totalPrice,
      orderDate: order.orderDate,
      communeId: order.communeId,
      deliveryType: order.deliveryType,
      products: order.stringToProducts(productsString),
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'familyName': lastName,
    'phone': phone,
    'totalPrice': totalPrice,
    'orderDate': orderDate.toIso8601String(),
    'deliveryType': deliveryType,
    'products': productsToString(products),
    'communeId': communeId,
  };
}

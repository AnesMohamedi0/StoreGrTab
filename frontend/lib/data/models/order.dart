import 'commune.dart';
import 'product.dart';

class Order {
  final int orderId;
  final String name;
  final String lastName;
  final String phone;
  final double totalPrice;
  final DateTime orderDate;
  final int communeId;
  final int deliveryType; //0 desk 1 domicile 2 public pickup
  final List<(Product, int)> products; // List of products with their quantities

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

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderId: (json['orderId'] as num?)?.toInt() ?? 0,
    name: (json['name'] as String?) ?? '',
    lastName: (json['lastName'] as String?) ?? '',
    phone: (json['phone'] as String?) ?? '',
    totalPrice: _toDouble(json['totalPrice']),
    orderDate:
        DateTime.tryParse(json['orderDate']?.toString() ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    communeId: (json['communeId'] as num?)?.toInt() ?? 0,
    products:
        (json['products'] as List?)
            ?.map(
              (e) => (
                Product.fromJson(e['product'] as Map<String, dynamic>),
                (e['quantity'] as num?)?.toInt() ?? 0,
              ),
            )
            .toList() ??
        const [],
    deliveryType: (json['deliveryType'] as num?)?.toInt() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'orderId': orderId,
    'name': name,
    'lastName': lastName,
    'phone': phone,
    'totalPrice': totalPrice,
    'orderDate': orderDate.toIso8601String(),
    'communeId': communeId,
    'products': products
        .map((e) => {'product': e.$1.toJson(), 'quantity': e.$2})
        .toList(),
    'deliveryType': deliveryType,
  };
}

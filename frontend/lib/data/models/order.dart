import 'commune.dart';
import 'product.dart';

class OrderModel {
  final int orderId;
  final String name;
  final String familyName;
  final String address;
  final String phone;
  final double totalPrice;
  final DateTime orderDate;
  final int orderStatus;
  final int communeId;
  final Commune? commune;
  final List<Product> products;

  const OrderModel({
    required this.orderId,
    required this.name,
    required this.familyName,
    required this.address,
    required this.phone,
    required this.totalPrice,
    required this.orderDate,
    required this.orderStatus,
    required this.communeId,
    this.commune,
    this.products = const [],
  });

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    return double.tryParse(v.toString()) ?? 0.0;
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        orderId: (json['orderId'] as num?)?.toInt() ?? 0,
        name: (json['name'] as String?) ?? '',
        familyName: (json['familyName'] as String?) ?? '',
        address: (json['address'] as String?) ?? '',
        phone: (json['phone'] as String?) ?? '',
        totalPrice: _toDouble(json['totalPrice']),
        orderDate: DateTime.tryParse(json['orderDate']?.toString() ?? '') ?? DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
        orderStatus: (json['orderStatus'] as num?)?.toInt() ?? 0,
        communeId: (json['communeId'] as num?)?.toInt() ?? 0,
        commune: json['commune'] != null ? Commune.fromJson(json['commune'] as Map<String, dynamic>) : null,
        products: (json['products'] as List?)
                ?.whereType<Map<String, dynamic>>()
                .map((e) => Product.fromJson(e))
                .toList() ??
            const [],
      );

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'name': name,
        'familyName': familyName,
        'address': address,
        'phone': phone,
        'totalPrice': totalPrice,
        'orderDate': orderDate.toIso8601String(),
        'orderStatus': orderStatus,
        'communeId': communeId,
        if (commune != null) 'commune': commune!.toJson(),
        'products': products.map((e) => e.toJson()).toList(),
      };
}

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
  final int deliveryType; //0 desk 1 domicile 2 public pickup
  final List<(Product, int)> products; // List of products with their quantities

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
    required this.deliveryType,
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
    orderDate:
        DateTime.tryParse(json['orderDate']?.toString() ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
    orderStatus: (json['orderStatus'] as num?)?.toInt() ?? 0,
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
    'familyName': familyName,
    'address': address,
    'phone': phone,
    'totalPrice': totalPrice,
    'orderDate': orderDate.toIso8601String(),
    'orderStatus': orderStatus,
    'communeId': communeId,
    'products': products
        .map((e) => {'product': e.$1.toJson(), 'quantity': e.$2})
        .toList(),
    'deliveryType': deliveryType,
  };
}

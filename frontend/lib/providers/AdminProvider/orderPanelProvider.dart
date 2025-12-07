import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/commune.dart';
import 'package:grtabstore/data/models/order.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/data/models/province.dart';
import 'package:grtabstore/services/apiService.dart';

class OrderPanelProvider extends ChangeNotifier {
  List<Order> _orders = [];
  bool isLoading = true;
  List<Order> get orders => _orders;
  ApiService apiService = ApiService();

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }

  Future<List<(String, int)>> getOrderProductsString(int orderId) async {
    List<(String, int)> products = [];
    for (var order in _orders) {
      if (order.orderId == orderId) {
        for (var (productId, quantity) in order.products) {
          String productName = '';
          try {
            final data = await apiService.get('Products/$productId');
            if (data != null) {
              final product = Product.fromJson(data);
              productName = product.name;
            }
          } catch (e) {
            print('Error fetching product with ID $productId: $e');
          }
          products.add((productName, quantity));
        }
        break;
      }
    }
    return products;
  }

  Future<Commune?> getOrderCommune(int orderId) async {
    final order = _orders.firstWhere((order) => order.orderId == orderId);
    try {
      final data = await apiService.get('Commune/${order.communeId}');
      if (data != null) {
        return Commune.fromJson(data);
      }
    } catch (e) {
      print('Error fetching commune with ID ${order.communeId}: $e');
    }
    return null;
  }

  Future<Province?> getOrderProvince(Commune commune) async {
    try {
      final data = await apiService.get('Provinces/${commune.provinceId}');
      if (data != null) {
        return Province.fromJson(data);
      }
    } catch (e) {
      print('Error fetching province with ID ${commune.provinceId}: $e');
    }
    return null;
  }

  Future<void> fetchOrders() async {
    try {
      final data = await apiService.get('Order');
      if (data is List && data.isNotEmpty) {
        _orders = data
            .map((item) => Order.fromJson(item as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
    _orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteOrder(int orderId) async {
    try {
      await apiService.delete('Order/$orderId');
      _orders.removeWhere((item) => item.orderId == orderId);
    } catch (e) {
      print('Error deleting order: $e');
    }
    notifyListeners();
  }
}

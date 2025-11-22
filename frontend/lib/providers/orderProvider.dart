import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/commune.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/data/models/province.dart';
import 'package:grtabstore/providers/cartProvider.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  List<(Product, int)> products = [];
  String name = '';
  String lastName = '';
  String phoneNumber = '';
  Province? province;
  Commune? commune;

  late int deliveryType; // 2: Pickup, 1: Home Delivery, 0: Desk pickup

  OrderProvider() {
    deliveryType = 0; // Default to Desk pickup
  }

  void setProvince(Province newProvince) {
    province = newProvince;
    deliveryType = 0;
    commune = null;
    notifyListeners();
  }

  void setCommune(Commune newCommune) {
    commune = newCommune;
    notifyListeners();
  }

  bool canOrder() {
    return name.isNotEmpty &&
        lastName.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        commune != null &&
        province != null;
  }

  bool canDeleteProduct() {
    return products.length > 1;
  }

  void setDeliveryType(int type) {
    deliveryType = type;
    notifyListeners();
  }

  set setProducts(List<(Product, int)> newProducts) {
    products.clear();
    products = List.of(newProducts);
    notifyListeners();
  }

  double getTotalItemCost() {
    double total = 0.0;
    for (var item in products) {
      total += item.$1.price * item.$2;
    }
    return total;
  }

  double getDeliveryCost() {
    if (province == null) return 0.0;

    if (deliveryType == 1) {
      return province!.homeDeliveryFee;
    } else if (deliveryType == 0) {
      return province!.deskDeliveryFee;
    } else {
      return 0.0;
    }
  }

  double getTotalOrderCost() {
    return getTotalItemCost() + getDeliveryCost();
  }

  void removeProduct(Product product) {
    products.removeWhere(
      (element) => element.$1.productId == product.productId,
    );
    notifyListeners();
  }

  void decrementCountProduct(Product product) {
    for (var i = 0; i < products.length; i++) {
      if (products[i].$1.productId == product.productId) {
        if (products[i].$2 > 1) {
          products[i] = (products[i].$1, products[i].$2 - 1);
        } else {
          products.removeAt(i);
        }
        notifyListeners();
        return;
      }
    }
  }

  void addProduct(Product product) {
    for (var i = 0; i < products.length; i++) {
      if (products[i].$1.productId == product.productId) {
        products[i] = (products[i].$1, products[i].$2 + 1);
        notifyListeners();
        return;
      }
    }
    products.add((product, 1));
    notifyListeners();
  }

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  void setLastName(String newLastName) {
    lastName = newLastName;
    notifyListeners();
  }

  void setPhoneNumber(String newPhoneNumber) {
    phoneNumber = newPhoneNumber;
    notifyListeners();
  }
}

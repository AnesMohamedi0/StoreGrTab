import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';

class CartProvider extends ChangeNotifier {
  List<(Product, int)> products = [];

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

  void clearCart() {
    products.clear();
    notifyListeners();
  }

  void updateQuantity(Product product, int quantity) {
    for (var i = 0; i < products.length; i++) {
      if (products[i].$1.productId == product.productId) {
        products[i] = (products[i].$1, quantity);
        notifyListeners();
        return;
      }
    }
  }

  int getTotalItems() {
    int total = 0;
    for (var item in products) {
      total += item.$2;
    }
    return total;
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in products) {
      total += item.$1.price * item.$2;
    }
    return total;
  }

  List<(Product, int)> getProducts() {
    return products;
  }

  bool isInCart(Product product) {
    for (var item in products) {
      if (item.$1.productId == product.productId) {
        return true;
      }
    }
    return false;
  }

  int getProductQuantity(Product product) {
    for (var item in products) {
      if (item.$1.productId == product.productId) {
        return item.$2;
      }
    }
    return 0;
  }
}

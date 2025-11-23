import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';
import '../services/apiService.dart';
import 'dart:convert';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];

  bool isLoading = false;

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  int sortOption = 1;

  int statueFilter = 0;
  List<int> brandFilter = [];
  (double, double) priceRangeFilter = (0.0, double.infinity);
  (double, double) sizeRangeFilter = (0.0, double.infinity);

  ProductsProvider() {
    fetchProductsFromApi();
    sortByPrice(ascending: false);
  }

  void setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void removeProduct(Product product) {
    _products.remove(product);
    notifyListeners();
  }

  void clearProducts() {
    _products.clear();
    notifyListeners();
  }

  void filterByBrandId(int brandId) {
    brandFilter.add(brandId);
    _applyFilters(); // Use the unified filter method
  }

  void clearFilterByBrand(int brandId) {
    brandFilter.remove(brandId);
    _applyFilters();
  }

  void clearFilter() {
    _filteredProducts = [];
    notifyListeners();
  }

  void filterByName(String name) {
    _filteredProducts = _products
        .where(
          (product) => product.name.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();

    notifyListeners();
  }

  void triggerFilterByNew() {
    statueFilter = 1;
    _applyFilters();
  }

  void triggerFilterByAlmostSoldOut() {
    statueFilter = 2;
    _applyFilters();
  }

  void removeStatueFilter() {
    statueFilter = 0;
    _applyFilters();
  }

  void filterByPriceRange(double minPrice, double maxPrice) {
    priceRangeFilter = (minPrice, maxPrice);
    _applyFilters();
  }

  void filterBySizeRange(double minSize, double maxSize) {
    sizeRangeFilter = (minSize, maxSize);
    _applyFilters();
  }

  void clearAllFilter() {
    brandFilter.clear();
    statueFilter = 0;
    priceRangeFilter = (0.0, double.infinity);
    sizeRangeFilter = (0.0, double.infinity);
    _applyFilters();
  }

  // Single method to apply all active filters
  void _applyFilters() {
    _filteredProducts = List.from(_products);

    if (brandFilter.isNotEmpty) {
      _filteredProducts = _filteredProducts
          .where((product) => brandFilter.contains(product.brandId))
          .toList();
    }

    if (statueFilter == 1) {
      _filteredProducts = _filteredProducts
          .where((product) => product.isNew == true)
          .toList();
    }

    if (statueFilter == 2) {
      _filteredProducts = _filteredProducts
          .where((product) => product.isAlmostSoldOut == true)
          .toList();
    }

    if (priceRangeFilter.$1 != 0.0 || priceRangeFilter.$2 != double.infinity) {
      _filteredProducts = _filteredProducts
          .where(
            (product) =>
                product.price >= priceRangeFilter.$1 &&
                product.price <= priceRangeFilter.$2,
          )
          .toList();
    }

    if (sizeRangeFilter.$1 != 0.0 || sizeRangeFilter.$2 != double.infinity) {
      _filteredProducts = _filteredProducts
          .where(
            (product) =>
                product.actifAreaX >= sizeRangeFilter.$1 &&
                product.actifAreaY <= sizeRangeFilter.$2,
          )
          .toList();
    }

    notifyListeners();
  }

  void filterByActifAreaX(double minAreaX, double maxAreaX) {
    _filteredProducts = _products
        .where(
          (product) =>
              product.actifAreaX >= minAreaX && product.actifAreaX <= maxAreaX,
        )
        .toList();
    notifyListeners();
  }

  void sortByPrice({bool ascending = true}) {
    sortOption = ascending ? 2 : 1;
    _filteredProducts.sort(
      (a, b) =>
          ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price),
    );
    notifyListeners();
  }

  void sortByName({bool ascending = true}) {
    sortOption = ascending ? 3 : 4;
    _filteredProducts.sort(
      (a, b) => ascending
          ? a.productId.compareTo(b.productId)
          : b.productId.compareTo(a.productId),
    );
    notifyListeners();
  }

  void sortByActifAreaX({bool ascending = true}) {
    sortOption = ascending ? 5 : 6;
    _filteredProducts.sort(
      (a, b) => ascending
          ? a.actifAreaX.compareTo(b.actifAreaX)
          : b.actifAreaX.compareTo(a.actifAreaX),
    );
    notifyListeners();
  }

  void clearSortOptions() {
    sortOption = 1;
    sortByPrice(ascending: false);
    notifyListeners();
  }

  int getNumberFilters() {
    int count = 0;
    if (brandFilter.isNotEmpty) count++;
    if (statueFilter != 0) count++;
    if (priceRangeFilter.$1 != 0.0 || priceRangeFilter.$2 != double.infinity)
      count++;
    if (sizeRangeFilter.$1 != 0.0 || sizeRangeFilter.$2 != double.infinity)
      count++;

    return count;
  }

  double? getMinPriceFilter() {
    return priceRangeFilter.$1;
  }

  double? getMaxPriceFilter() {
    return priceRangeFilter.$2;
  }

  double? getMinSizeFilter() {
    return sizeRangeFilter.$1;
  }

  double? getMaxSizeFilter() {
    return sizeRangeFilter.$2;
  }

  Future<void> fetchProductsFromApi() async {
    try {
      final data = await apiService.get(
        'Products',
      ); // Use 'Products' (capital P)
      if (data is List) {
        _products = data.map((item) => Product.fromJson(item)).toList();
        _filteredProducts = List.from(_products);
      }
    } catch (e) {
      print('Error fetching products: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

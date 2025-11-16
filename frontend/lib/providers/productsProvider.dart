import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/product.dart';

class ProductsProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  List<Product> _shoppingCart = [];

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  List<Product> get shoppingCart => _shoppingCart;

  int statueFilter = 0;
  List<int> brandFilter = [];
  (double, double) priceRangeFilter = (0.0, double.infinity);

  ProductsProvider() {
    _loadDummyData(); // automatically fill data on init
  }

  void _loadDummyData() {
    _products = [
      Product(
        productId: 1,
        name: 'Wacom Intuos S',
        brandId: 1,
        price: 11000,
        actifAreaX: 10,
        actifAreaY: 6,
        isAlmostSoldOut: true,
        photoUrl:
            'https://tse1.mm.bing.net/th/id/OIP.32MekmCagQTOZ0FyXy_1sgHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
      ),
      Product(
        productId: 2,
        name: 'XP-Pen Deco 01 V2',
        brandId: 2,
        price: 12000,
        oldPrice: 15000,
        actifAreaX: 10,
        actifAreaY: 6.25,
        isNew: true,
        photoUrl:
            'https://tse4.mm.bing.net/th/id/OIP.ptbVKksxOMP_juVbhnCTXQHaEV?w=650&h=380&rs=1&pid=ImgDetMain&o=7&rm=3',
      ),
      Product(
        productId: 3,
        name: 'Huion Kamvas 13',
        brandId: 3,
        price: 259.99,
        actifAreaX: 13,
        actifAreaY: 7.5,
        photoUrl:
            'https://images.unsplash.com/photo-1587573089734-09cb69c185d8?w=500',
      ),
      Product(
        productId: 4,
        name: 'Wacom Cintiq 16',
        brandId: 1,
        price: 649.99,
        actifAreaX: 16,
        actifAreaY: 9,
        photoUrl:
            'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=500',
      ),
      Product(
        productId: 5,
        name: 'XP-Pen Artist 12 Pro',
        brandId: 2,
        price: 249.99,
        actifAreaX: 12,
        actifAreaY: 6.75,
        photoUrl:
            'https://images.unsplash.com/photo-1616469829933-2f6b394af870?w=500',
      ),
      Product(
        productId: 6,
        name: 'Huion Inspiroy H640P',
        brandId: 3,
        price: 49.99,
        actifAreaX: 6.3,
        actifAreaY: 3.9,
        photoUrl:
            'https://images.unsplash.com/photo-1623794348522-b9e1b6cd8df8?w=500',
      ),
      Product(
        productId: 7,
        name: 'Veikk A50',
        brandId: 3,
        price: 59.99,
        actifAreaX: 10,
        actifAreaY: 6,
        photoUrl:
            'https://images.unsplash.com/photo-1593642532973-d31b6557fa68?w=500',
      ),
      Product(
        productId: 2,
        name: 'Huion H950P',
        brandId: 3,
        price: 89.99,
        actifAreaX: 8.7,
        actifAreaY: 5.4,
        photoUrl:
            'https://images.unsplash.com/photo-1587573089734-09cb69c185d8?w=500',
      ),
      Product(
        productId: 9,
        name: 'XP-Pen Deco Pro M',
        brandId: 2,
        price: 129.99,
        actifAreaX: 11,
        actifAreaY: 6,
        photoUrl:
            'https://images.unsplash.com/photo-1626894512663-c43e8a4fca25?w=500',
      ),
      Product(
        productId: 10,
        name: 'Wacom One 13',
        brandId: 1,
        price: 399.99,
        actifAreaX: 13,
        actifAreaY: 7.5,
        photoUrl:
            'https://images.unsplash.com/photo-1618221195710-dd6b41faaea6?w=500',
      ),
    ];

    _filteredProducts = List.from(_products);
    notifyListeners();
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
    _filteredProducts.sort(
      (a, b) =>
          ascending ? a.price.compareTo(b.price) : b.price.compareTo(a.price),
    );
    notifyListeners();
  }

  void sortByName({bool ascending = true}) {
    _filteredProducts.sort(
      (a, b) => ascending
          ? a.productId.compareTo(b.productId)
          : b.productId.compareTo(a.productId),
    );
    notifyListeners();
  }

  void sortByActifAreaX({bool ascending = true}) {
    _filteredProducts.sort(
      (a, b) => ascending
          ? a.actifAreaX.compareTo(b.actifAreaX)
          : b.actifAreaX.compareTo(a.actifAreaX),
    );
    notifyListeners();
  }

  void addToShoppingCart(Product product) {
    _shoppingCart.add(product);
    notifyListeners();
  }

  void removeFromShoppingCart(Product product) {
    _shoppingCart.remove(product);
    notifyListeners();
  }

  void clearShoppingCart() {
    _shoppingCart.clear();
    notifyListeners();
  }

  bool isInShoppingCart(Product product) {
    return _shoppingCart.contains(product);
  }

  int get shoppingCartItemCount => _shoppingCart.length;

  int getNumberFilters() {
    int count = 0;
    if (brandFilter.isNotEmpty) count++;
    if (statueFilter != 0) count++;
    if (priceRangeFilter.$1 != 0.0 || priceRangeFilter.$2 != double.infinity)
      count++;

    return count;
  }

  double? getMinPriceFilter() {
    return priceRangeFilter.$1;
  }

  double? getMaxPriceFilter() {
    return priceRangeFilter.$2;
  }
}

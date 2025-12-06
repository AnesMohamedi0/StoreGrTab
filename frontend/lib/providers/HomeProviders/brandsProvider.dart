import 'package:flutter/widgets.dart';
import 'package:grtabstore/data/models/brand.dart';
import 'package:grtabstore/services/apiService.dart';

class BrandsProvider extends ChangeNotifier {
  List<Brand> brands = [];

  bool isLoading = false;

  BrandsProvider() {
    fetchBrandsFromApi();
  }
  void setBrands(List<Brand> newBrands) {
    brands = newBrands;
    notifyListeners();
  }

  void addBrand(Brand brand) {
    brands.add(brand);
    notifyListeners();
  }

  void clearBrands() {
    brands.clear();
    notifyListeners();
  }

  void removeBrand(Brand brand) {
    brands.remove(brand);
    notifyListeners();
  }

  List<Brand> getBrands() {
    return brands;
  }

  Brand? getBrandById(int id) {
    try {
      return brands.firstWhere((brand) => brand.brandId == id);
    } catch (e) {
      return null; // Return null if brand not found
    }
  }

  int? getBrandIdByName(String name) {
    return brands.firstWhere((brand) => brand.name == name).brandId;
  }

  String getBrandName(int id) {
    return brands.firstWhere((brand) => brand.brandId == id).name;
  }

  Future<void> fetchBrandsFromApi() async {
    try {
      final data = await apiService.get('Brands');
      if (data is List) {
        brands = data.map((item) => Brand.fromJson(item)).toList();
      }
    } catch (e) {
      print('Error fetching brands: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}

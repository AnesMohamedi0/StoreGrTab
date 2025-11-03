import 'package:flutter/widgets.dart';
import 'package:grtabstore/data/models/brand.dart';

class BrandsProvider extends ChangeNotifier {
  List<Brand> brands = [];

  BrandsProvider() {
    brands = LoadDummyData();
  }

  LoadDummyData() {
    return [
      Brand(
        brandId: 1,
        name: "XpPen",
        photoUrl:
            "https://yt3.googleusercontent.com/6oK0GBeusKsxwmRvvC3Rj5Rcbb2Mu5MeWMi5BLJFMjD7ZaJQFhNlI5rHBul4vSThJXp_uEzNKg=s900-c-k-c0x00ffffff-no-rj",
      ),
      Brand(
        brandId: 2,
        name: "Ugee",
        photoUrl:
            "https://tse4.mm.bing.net/th/id/OIP.euij4psVx75_VezrSsS04QHaHX?w=820&h=815&rs=1&pid=ImgDetMain&o=7&rm=3",
      ),
      Brand(
        brandId: 3,
        name: "Wacom",
        photoUrl:
            'https://tse4.mm.bing.net/th/id/OIP.euij4psVx75_VezrSsS04QHaHX?w=820&h=815&rs=1&pid=ImgDetMain&o=7&rm=3',
      ),
    ];
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
    return brands.firstWhere((brand) => brand.brandId == id);
  }
}

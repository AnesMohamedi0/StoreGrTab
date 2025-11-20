import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/commune.dart';
import 'package:grtabstore/data/models/product.dart';
import 'package:grtabstore/data/models/province.dart';
import 'package:grtabstore/providers/cartProvider.dart';
import 'package:provider/provider.dart';

class OrderProvider extends ChangeNotifier {
  List<(Product, int)> products = [];
  late String name;
  late String lastName;
  late String phoneNumber;
  late Province province;
  late Commune commune;

  List<Province> provinces = [];
  List<Commune> communes = [];

  OrderProvider() {
    getAllProvinces();
    province = provinces[15];
  }

  bool canDeleteProduct() {
    return products.length > 1;
  }

  set setProducts(List<(Product, int)> newProducts) {
    products.clear();
    products = List.of(newProducts);
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

  void setProvince(Province newProvince) {
    province = newProvince;
    notifyListeners();
  }

  void setCommune(Commune newCommune) {
    commune = newCommune;
    notifyListeners();
  }

  void getAllProvinces() {
    provinces = [
      Province(id: 1, name: "Adrar"),
      Province(id: 2, name: "Chlef"),
      Province(id: 3, name: "Laghouat"),
      Province(id: 4, name: "Oum El Bouaghi"),
      Province(id: 5, name: "Batna"),
      Province(id: 6, name: "Béjaïa"),
      Province(id: 7, name: "Biskra"),
      Province(id: 8, name: "Béchar"),
      Province(id: 9, name: "Blida"),
      Province(id: 10, name: "Bouira"),
      Province(id: 11, name: "Tamanrasset"),
      Province(id: 12, name: "Tébessa"),
      Province(id: 13, name: "Tlemcen"),
      Province(id: 14, name: "Tiaret"),
      Province(id: 15, name: "Tizi Ouzou"),
      Province(id: 16, name: "Alger"),
      Province(id: 17, name: "Djelfa"),
      Province(id: 18, name: "Jijel"),
      Province(id: 19, name: "Sétif"),
      Province(id: 20, name: "Saïda"),
      Province(id: 21, name: "Skikda"),
      Province(id: 22, name: "Sidi Bel Abbès"),
      Province(id: 23, name: "Annaba"),
      Province(id: 24, name: "Guelma"),
      Province(id: 25, name: "Constantine"),
      Province(id: 26, name: "Médéa"),
      Province(id: 27, name: "Mostaganem"),
      Province(id: 28, name: "M'Sila"),
      Province(id: 29, name: "Mascara"),
      Province(id: 30, name: "Ouargla"),
      Province(id: 31, name: "Oran"),
      Province(id: 32, name: "El Bayadh"),
      Province(id: 33, name: "Illizi"),
      Province(id: 34, name: "Bordj Bou Arréridj"),
      Province(id: 35, name: "Boumerdès"),
      Province(id: 36, name: "El Tarf"),
      Province(id: 37, name: "Tindouf"),
      Province(id: 38, name: "Tissemsilt"),
      Province(id: 39, name: "El Oued"),
      Province(id: 40, name: "Khenchela"),
      Province(id: 41, name: "Souk Ahras"),
      Province(id: 42, name: "Tipaza"),
      Province(id: 43, name: "Mila"),
      Province(id: 44, name: "Aïn Defla"),
      Province(id: 45, name: "Naâma"),
      Province(id: 46, name: "Aïn Témouchent"),
      Province(id: 47, name: "Ghardaïa"),
      Province(id: 48, name: "Relizane"),
      Province(id: 49, name: "Timimoun"),
      Province(id: 50, name: "Bordj Badji Mokhtar"),
      Province(id: 51, name: "Ouled Djellal"),
      Province(id: 52, name: "Béni Abbès"),
      Province(id: 53, name: "In Salah"),
      Province(id: 54, name: "In Guezzam"),
      Province(id: 55, name: "Touggourt"),
      Province(id: 56, name: "Djanet"),
      Province(id: 57, name: "El M'Ghair"),
      Province(id: 58, name: "El Meniaa"),
    ];
    notifyListeners();
  }

  void getAllCommunesForProvince(Province province) {
    // Clear existing communes
    communes = [];

    // Generate sample communes based on province ID
    switch (province.id) {
      case 1: // Adrar
        communes = [
          Commune(id: 101, name: "Adrar", provinceId: 1),
          Commune(id: 102, name: "Tamest", provinceId: 1),
          Commune(id: 103, name: "Charouine", provinceId: 1),
          Commune(id: 104, name: "Reggane", provinceId: 1),
          Commune(id: 105, name: "In Zghmir", provinceId: 1),
        ];
        break;
      case 2: // Chlef
        communes = [
          Commune(id: 201, name: "Chlef", provinceId: 2),
          Commune(id: 202, name: "Ténès", provinceId: 2),
          Commune(id: 203, name: "Benairia", provinceId: 2),
          Commune(id: 204, name: "El Karimia", provinceId: 2),
          Commune(id: 205, name: "Tadjena", provinceId: 2),
        ];
        break;
      case 16: // Alger
        communes = [
          Commune(id: 1601, name: "Alger Centre", provinceId: 16),
          Commune(id: 1602, name: "Sidi M'Hamed", provinceId: 16),
          Commune(id: 1603, name: "El Madania", provinceId: 16),
          Commune(id: 1604, name: "Hamma El Annasser", provinceId: 16),
          Commune(id: 1605, name: "Bab El Oued", provinceId: 16),
          Commune(id: 1606, name: "Bologhine", provinceId: 16),
          Commune(id: 1607, name: "Casbah", provinceId: 16),
          Commune(id: 1608, name: "Oued Koriche", provinceId: 16),
          Commune(id: 1609, name: "Bir Mourad Raïs", provinceId: 16),
          Commune(id: 1610, name: "El Biar", provinceId: 16),
        ];
        break;
      case 31: // Oran
        communes = [
          Commune(id: 3101, name: "Oran", provinceId: 31),
          Commune(id: 3102, name: "Bir El Djir", provinceId: 31),
          Commune(id: 3103, name: "Es Senia", provinceId: 31),
          Commune(id: 3104, name: "Arzew", provinceId: 31),
          Commune(id: 3105, name: "Bethioua", provinceId: 31),
          Commune(id: 3106, name: "Marsa El Hadjadj", provinceId: 31),
        ];
        break;
      case 25: // Constantine
        communes = [
          Commune(id: 2501, name: "Constantine", provinceId: 25),
          Commune(id: 2502, name: "Hamma Bouziane", provinceId: 25),
          Commune(id: 2503, name: "Didouche Mourad", provinceId: 25),
          Commune(id: 2504, name: "El Khroub", provinceId: 25),
          Commune(id: 2505, name: "Aïn Abid", provinceId: 25),
        ];
        break;
      default:
        // Generate generic communes for other provinces
        communes = [
          Commune(
            id: province.id * 100 + 1,
            name: "${province.name} Centre",
            provinceId: province.id,
          ),
          Commune(
            id: province.id * 100 + 2,
            name: "${province.name} Nord",
            provinceId: province.id,
          ),
          Commune(
            id: province.id * 100 + 3,
            name: "${province.name} Sud",
            provinceId: province.id,
          ),
          Commune(
            id: province.id * 100 + 4,
            name: "${province.name} Est",
            provinceId: province.id,
          ),
          Commune(
            id: province.id * 100 + 5,
            name: "${province.name} Ouest",
            provinceId: province.id,
          ),
        ];
        break;
    }

    notifyListeners();
  }
}

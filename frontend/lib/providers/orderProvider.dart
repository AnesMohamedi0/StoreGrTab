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
  Province province = Province(
    id: 0,
    name: '',
    homeDeliveryFee: 0,
    deskDeliveryFee: 0,
  );

  late Commune commune;

  late int deliveryType; // 2: Pickup, 1: Home Delivery, 0: Desk pickup

  List<Province> provinces = [];
  List<Commune> communes = [];

  OrderProvider() {
    getAllProvinces();
    province = provinces[15];
    getAllCommunesForProvince(province);
    commune = communes[0];
    deliveryType = 0; // Default to Desk pickup
  }

  bool canOrder() {
    return name.isNotEmpty && lastName.isNotEmpty && phoneNumber.isNotEmpty;
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
    if (deliveryType == 1) {
      return province.homeDeliveryFee;
    } else if (deliveryType == 0) {
      return province.deskDeliveryFee;
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

  void setProvince(Province newProvince) {
    province = newProvince;
    deliveryType = 0;
    notifyListeners();
  }

  void setCommune(Commune newCommune) {
    commune = newCommune;
    notifyListeners();
  }

  void getAllProvinces() {
    provinces = [
      Province(
        id: 1,
        name: "Adrar",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 2,
        name: "Chlef",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 3,
        name: "Laghouat",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 4,
        name: "Oum El Bouaghi",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 5,
        name: "Batna",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 6,
        name: "Béjaïa",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 7,
        name: "Biskra",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 8,
        name: "Béchar",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 9,
        name: "Blida",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 10,
        name: "Bouira",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 11,
        name: "Tamanrasset",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 12,
        name: "Tébessa",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 13,
        name: "Tlemcen",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 14,
        name: "Tiaret",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 15,
        name: "Tizi Ouzou",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 16,
        name: "Alger",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 17,
        name: "Djelfa",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 18,
        name: "Jijel",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 19,
        name: "Sétif",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 20,
        name: "Saïda",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 21,
        name: "Skikda",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 22,
        name: "Sidi Bel Abbès",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 23,
        name: "Annaba",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 24,
        name: "Guelma",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 25,
        name: "Constantine",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 26,
        name: "Médéa",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 27,
        name: "Mostaganem",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 28,
        name: "M'Sila",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 29,
        name: "Mascara",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 30,
        name: "Ouargla",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 31,
        name: "Oran",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 32,
        name: "El Bayadh",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 33,
        name: "Illizi",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 34,
        name: "Bordj Bou Arréridj",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 35,
        name: "Boumerdès",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 36,
        name: "El Tarf",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 37,
        name: "Tindouf",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 38,
        name: "Tissemsilt",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 39,
        name: "El Oued",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 40,
        name: "Khenchela",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 41,
        name: "Souk Ahras",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 42,
        name: "Tipaza",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 43,
        name: "Mila",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 44,
        name: "Aïn Defla",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 45,
        name: "Naâma",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 46,
        name: "Aïn Témouchent",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 47,
        name: "Ghardaïa",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 48,
        name: "Relizane",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 49,
        name: "Timimoun",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 50,
        name: "Bordj Badji Mokhtar",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 51,
        name: "Ouled Djellal",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 52,
        name: "Béni Abbès",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 53,
        name: "In Salah",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 54,
        name: "In Guezzam",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 55,
        name: "Touggourt",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 56,
        name: "Djanet",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 57,
        name: "El M'Ghair",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
      Province(
        id: 58,
        name: "El Meniaa",
        homeDeliveryFee: 0.0,
        deskDeliveryFee: 0.0,
      ),
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

    commune = communes[0];

    notifyListeners();
  }
}

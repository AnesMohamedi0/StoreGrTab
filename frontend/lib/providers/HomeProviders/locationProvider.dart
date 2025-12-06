import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/commune.dart';
import 'package:grtabstore/data/models/province.dart';
import 'package:grtabstore/services/apiService.dart';

class LocationProvider extends ChangeNotifier {
  List<Province> provinces = [];
  List<Commune> communes = [];

  LocationProvider() {
    fetchProvincesFromApi();
    fetchCommunesByProvinceIdFromApi(16);
    notifyListeners();
  }

  Future<void> fetchProvincesFromApi() async {
    try {
      final data = await apiService.get('Provinces');
      if (data is List) {
        provinces = data.map((item) => Province.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching provinces: $e');
    }
  }

  Future<void> fetchCommunesByProvinceIdFromApi(int provinceId) async {
    try {
      final data = await apiService.getCommunesByProvinceId(provinceId);
      if (data is List) {
        communes = data.map((item) => Commune.fromJson(item)).toList();
        notifyListeners();
      }
    } catch (e) {
      print('Error fetching communes: $e');
    }
  }
}

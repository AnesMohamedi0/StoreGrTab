import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/ad.dart';
import 'package:grtabstore/services/apiService.dart';

class AdminAdsProvider extends ChangeNotifier {
  List<Ad> _ads = [];
  List<Ad> get ads => _ads;
  bool isOpened = false;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  ApiService apiService = ApiService();

  Future<void> fetchAds() async {
    try {
      final data = await apiService.get('Ads');
      if (data is List && data.isNotEmpty) {
        _ads = data
            .map((item) => Ad.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        _isLoading = false;
      }
    } catch (e) {
      print('Error fetching ads: $e');
    }
    notifyListeners();
  }

  Future<void> createAd(Ad ad) async {
    try {
      final response = await apiService.post('Ads', ad.toJson());
      final newAd = Ad.fromJson(response);
      _ads.add(newAd);
    } catch (e) {
      print('Error creating ad: $e');
    }
    notifyListeners();
  }

  Future<void> updateAd(Ad ad) async {
    try {
      final response = await apiService.put('Ads/${ad.id}', ad.toJson());
      final updatedAd = Ad.fromJson(response);
      final index = _ads.indexWhere((item) => item.id == ad.id);
      if (index != -1) {
        _ads[index] = updatedAd;
      }
    } catch (e) {
      print('Error updating ad: $e');
    }
    notifyListeners();
  }

  Future<void> deleteAd(String id) async {
    try {
      await apiService.delete('Ads/$id');
      _ads.removeWhere((ad) => ad.id == id);
    } catch (e) {
      print('Error deleting ad: $e');
    }
    notifyListeners();
  }

  void toggleAdsPanel() {
    isOpened = !isOpened;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/ad.dart';

class AdsProvider extends ChangeNotifier {
  List<Ad> _ads = [];

  List<Ad> get ads => _ads;

  void setAds(List<Ad> ads) {
    _ads = ads;
    notifyListeners();
  }

  void removeAd(Ad ad) {
    _ads.remove(ad);
    notifyListeners();
  }

  void clearAds() {
    _ads.clear();
    notifyListeners();
  }

  void addAd(Ad ad) {
    _ads.add(ad);
    notifyListeners();
  }
}

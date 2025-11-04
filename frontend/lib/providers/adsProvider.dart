import 'package:flutter/material.dart';
import 'package:grtabstore/data/models/ad.dart';

class AdsProvider extends ChangeNotifier {
  List<Ad> _ads = [];

  List<Ad> get ads => _ads;

  AdsProvider() {
    // Initialize with dummy ads for testing
    _ads = dummyAds();
  }

  List<Ad> dummyAds() {
    return [
      Ad(
        id: '1',
        title: 'Deco Mini 7 V2',
        imageUrl:
            'https://th.bing.com/th/id/R.85c8fb69082bbfbcbbe1b117709b8044?rik=NTm%2feKh%2bhGBBnw&pid=ImgRaw&r=0',
        link: 'https://example.com/ad1',
      ),
      Ad(
        id: '2',
        title: 'Wacom One',
        imageUrl:
            'https://tse2.mm.bing.net/th/id/OIP.j1gfb7c5dkHKE8tmG-MHBQHaHa?w=1000&h=1000&rs=1&pid=ImgDetMain&o=7&rm=3',
        link: 'https://example.com/ad2',
      ),
    ];
  }

  List<Ad> getAds() {
    return _ads;
  }

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

import 'package:flutter/material.dart';
import 'package:grtabstore/providers/AdminProvider/adminAdsProvider.dart';
import 'package:grtabstore/providers/authProvider.dart';
import 'package:grtabstore/providers/HomeProviders/brandsProvider.dart';
import 'package:grtabstore/providers/HomeProviders/cartProvider.dart';
import 'package:grtabstore/providers/HomeProviders/locationProvider.dart';
import 'package:grtabstore/providers/HomeProviders/orderProvider.dart';
import 'package:provider/provider.dart';
import 'package:grtabstore/providers/HomeProviders/productsProvider.dart';
import 'app.dart';
import 'dart:io';

void main() {
  HttpOverrides.global = DevHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => BrandsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(create: (_) => LocationProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AdminAdsProvider()),
      ],
      child: const App(),
    ),
  );
}

class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.badCertificateCallback = (cert, host, port) => true;
    return client;
  }
}

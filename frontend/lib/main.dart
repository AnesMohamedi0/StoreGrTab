import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:grtabstore/providers/productsProvider.dart';
import 'package:grtabstore/providers/adsProvider.dart';
import 'app.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => AdsProvider()),
      ],
      child: const App(),
    ),
  );
}

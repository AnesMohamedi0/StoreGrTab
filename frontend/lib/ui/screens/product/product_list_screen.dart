import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/api/api_client.dart';
import '../../../data/repositories/product_repository.dart';
import '../../../providers/product_provider.dart';
import '../../widgets/product_list.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Products')),
      body: ChangeNotifierProvider(
        create: (_) => ProductProvider(ProductRepository(ApiClient()))..fetch(),
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ProductList(),
        ),
      ),
    );
  }
}

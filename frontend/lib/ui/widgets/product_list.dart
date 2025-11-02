import 'package:flutter/material.dart';
import '../../providers/product_provider.dart';
import 'package:provider/provider.dart';

class ProductList extends StatelessWidget {
  const ProductList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, provider, _) {
        if (provider.loading) return const Center(child: CircularProgressIndicator());
        if (provider.error != null) return Center(child: Text('Error: ${provider.error}'));
        if (provider.products.isEmpty) return const Center(child: Text('No products'));
        return ListView.separated(
          itemCount: provider.products.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, i) {
            final p = provider.products[i];
            return ListTile(
              title: Text(p.name),
              subtitle: Text(p.price.toStringAsFixed(2)),
            );
          },
        );
      },
    );
  }
}

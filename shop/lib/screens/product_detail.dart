import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String productId = ModalRoute.of(context)!.settings.arguments as String;
    final product = Provider.of<ProductProvider>(context, listen: false)
        .findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        child: Center(
          child: Text('Product detail screen'),
        ),
      ),
    );
  }
}

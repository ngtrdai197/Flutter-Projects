import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/constants/routing.dart';
import 'package:shop/providers/products_provider.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Routing.EDIT_PRODUCT);
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<ProductsProvider>(
          builder: (_, products, __) => ListView.builder(
            itemCount: products.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductItem(
                  id: products.items[index].id,
                  title: products.items[index].title,
                  imageUrl: products.items[index].imageUrl,
                  description: products.items[index].description,
                ),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

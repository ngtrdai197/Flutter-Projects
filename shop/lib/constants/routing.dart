import 'package:flutter/material.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/edit_product_screen.dart';
import 'package:shop/screens/orders_screen.dart';
import 'package:shop/screens/product_detail.dart';
import 'package:shop/screens/products_overview.dart';
import 'package:shop/screens/user_products_screen.dart';

class Routing {
  static const HOME_SCREEN = '/';
  static const PRODUCT_DETAIL = '/product-detail';
  static const CART = '/cart';
  static const ORDER = '/order';
  static const USER_PRODUCTS = '/user-products';
  static const EDIT_PRODUCT = '/edit-product';

  static Map<String, Widget Function(BuildContext context)> buildRoutes() {
    return {
      HOME_SCREEN: (context) => ProductOverview(),
      PRODUCT_DETAIL: (context) => ProductDetailScreen(),
      CART: (context) => CartScreen(),
      ORDER: (context) => OrdersScreen(),
      USER_PRODUCTS: (context) => UserProductsScreen(),
      EDIT_PRODUCT: (context) => EditProductScreen(),
    };
  }
}

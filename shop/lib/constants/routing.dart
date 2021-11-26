import 'package:flutter/material.dart';
import 'package:shop/screens/cart_screen.dart';
import 'package:shop/screens/product_detail.dart';
import 'package:shop/screens/products_overview.dart';

class Routing {
  static const HOME_SCREEN = '/';
  static const PRODUCT_DETAIL = '/product-detail';
  static const CART = '/cart';

  static Map<String, Widget Function(BuildContext context)> buildRoutes() {
    return {
      HOME_SCREEN: (context) => ProductOverview(),
      PRODUCT_DETAIL: (context) => ProductDetailScreen(),
      CART: (context) => CartScreen(),
    };
  }
}

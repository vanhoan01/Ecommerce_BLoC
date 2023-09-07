import 'package:ecommerce_bloc/models/models.dart';
import 'package:ecommerce_bloc/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // ignore: avoid_print
    print('This is route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      // ignore: no_duplicate_case_values
      case HomeScreen.routeName:
        return HomeScreen.route();
      case SplashScreen.routeName:
        return SplashScreen.route();
      case CartScreen.routeName:
        return CartScreen.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(
            categoryModel: settings.arguments as CategoryModel);
      case WishlistScreen.routeName:
        return WishlistScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(
            productModel: settings.arguments as ProductModel);
      case CheckoutScreen.routeName:
        return CheckoutScreen.route();
      case OrderConfirmation.routeName:
        return OrderConfirmation.route();
      case PaymentSelection.routeName:
        return PaymentSelection.route();
      case SignInScreen.routeName:
        return SignInScreen.route();
      case UserScreen.routeName:
        return UserScreen.route(id: settings.arguments as String);
      default:
        _errorRoute();
    }
    return _errorRoute();
  }
}

Route _errorRoute() {
  return MaterialPageRoute(
    settings: const RouteSettings(name: 'error'),
    builder: (_) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
    ),
  );
}

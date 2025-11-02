import 'package:flutter/material.dart';
import '../ui/screens/home_screen.dart';
import '../ui/screens/auth/login_screen.dart';
import '../ui/screens/product/product_list_screen.dart';

class Routes {
  static const home = '/';
  static const login = '/login';
  static const products = '/products';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case products:
        return MaterialPageRoute(builder: (_) => const ProductListScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

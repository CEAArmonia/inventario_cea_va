import 'package:flutter/material.dart';
import 'package:inventario_cea_va/presentation/pages/pages.dart';

class AppRoutes {
  static const String homePage = '/';
  static const String loginPage = '/loginPage';
  static const String splashPage = '/splashPage';
  static const String itemPage = '/itemPage';
  static const String inventarioPage = '/inventarioPage';
  static const String dependenciaPage = '/dependenciaPage';

  static Map<String, WidgetBuilder> routes(BuildContext context) {
    return {
      homePage: (context) => const HomePage(),
      loginPage: (context) => LoginPage(),
      splashPage: (context) => const SplashPage(),
      itemPage: (context) => ItemPage(),
      inventarioPage: (context) => InventarioPage(),
      dependenciaPage:(context) => DependenciaPage()
    };
  }
}

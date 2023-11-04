import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventario_cea_va/db/config/server_connection.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';

void main() async {
  await initHiveForFlutter();
  runApp(GraphQLProvider(
    client: ConectarGraphQL().client(),
    child: const ProviderScope(
      child: MainApp(),
    ),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    HiveStore().reset();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeInventory(context),
      routes: AppRoutes.routes(context),
      initialRoute: AppRoutes.splashPage,
    );
  }
}

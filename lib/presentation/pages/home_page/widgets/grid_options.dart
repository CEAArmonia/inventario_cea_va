// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/dependencia_helper.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/presentation/pages/reportes_page/home_page_reportes.dart';
import 'package:inventario_cea_va/presentation/providers/dependencia_provider.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:inventario_cea_va/presentation/providers/item_provider.dart';

class GridOptions extends ConsumerWidget {
  GridOptions({Key? key}) : super(key: key);

  final TextStyle styles = GoogleFonts.lilitaOne(
    color: AppTheme.shadowColor,
    fontSize: 16,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    return GridView.count(
      crossAxisCount: 2,
      children: [
        GestureDetector(
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/hombre-escribiendo.png',
                    height: size.height * .18,
                  ),
                ),
                Text(
                  'Registrar Items',
                  style: styles,
                ),
              ],
            ),
          ),
          onTap: () async {
            final ItemHelper itemHelper = ItemHelper();
            ref.read(tiposItemProvider.notifier).state =
                await itemHelper.getTiposItem();
            Navigator.pushNamed(context, AppRoutes.itemPage);
          },
        ),
        GestureDetector(
          onTap: () async {
            final ItemHelper itemHelper = ItemHelper();
            ref.read(listaItemsProvider.notifier).state =
                await itemHelper.getItems();
            Navigator.pushNamed(context, AppRoutes.inventarioPage);
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/hombre-cajas.png',
                    height: size.height * .18,
                  ),
                ),
                Text(
                  'Inventario',
                  style: styles,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            final DependenciaHelper dependenciaHelper = DependenciaHelper();
            ref.read(listaDependenciaProvider.notifier).state =
                await dependenciaHelper.getDependencias('');
            Navigator.pushNamed(context, AppRoutes.dependenciaPage);
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/classroom.png',
                    height: size.height * .18,
                  ),
                ),
                Text(
                  'Dependencia',
                  style: styles,
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/mujer-asignando.png',
                    height: size.height * .18,
                  ),
                ),
                Text(
                  'Reportes',
                  style: styles,
                ),
              ],
            ),
          ),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePageReportes(),
              ),
            );
          },
        )
      ],
    );
  }
}

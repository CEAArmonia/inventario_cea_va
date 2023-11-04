// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/dependencia_helper.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/presentation/providers/dependencia_provider.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:inventario_cea_va/presentation/providers/item_provider.dart';

class GridOptions extends ConsumerWidget {
  const GridOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        GestureDetector(
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/hombre-escribiendo.png',
                    height: 165,
                  ),
                ),
                Text(
                  'Registrar Items',
                  style: GoogleFonts.lilitaOne(color: AppTheme.shadowColor),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/hombre-cajas.png',
                    height: 165,
                  ),
                ),
                Text(
                  'Inventario',
                  style: GoogleFonts.lilitaOne(color: AppTheme.shadowColor),
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/classroom.png',
                    height: 165,
                  ),
                ),
                Text(
                  'Dependencia',
                  style: GoogleFonts.lilitaOne(color: AppTheme.shadowColor),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

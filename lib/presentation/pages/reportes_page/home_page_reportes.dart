// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/db/db_helpers/usuario_helper.dart';
import 'package:inventario_cea_va/presentation/models/lista_models_reportes.dart';
import 'package:inventario_cea_va/presentation/pages/reportes_page/widgets/bitacora_page.dart';
import 'package:inventario_cea_va/presentation/pages/reportes_page/widgets/inventario_items.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/presentation/providers/user_provider.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

import 'widgets/item_cantidades_bajas_page.dart';

class HomePageReportes extends ConsumerWidget {
  const HomePageReportes({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Reportes',
                textAlign: TextAlign.center,
                style: GoogleFonts.lilitaOne(
                    color: AppTheme.shadowColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: listaReportes.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 20,
                    color: AppTheme.brightColor,
                  ),
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(listaReportes[index].nombre),
                      subtitle: Text(listaReportes[index].desc),
                      trailing: const Icon(LineIcons.fileExport),
                      leading: const Icon(Icons.edit_document),
                      onTap: () async {
                        switch (listaReportes[index].opcion) {
                          case 'bitacora':
                            UsuarioHelper helper = UsuarioHelper();
                            ref.read(listaUsersProvider.notifier).state =
                                await helper.getUsers();
                            ref.read(listaBitacoraProvider.notifier).state =
                                await helper.getBitacoras();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BitacoraPage(),
                              ),
                            );
                            break;
                          case 'cant_bajas':
                            ItemHelper helper = ItemHelper();
                            ref
                                .read(itemCantidadesBajasProvider.notifier)
                                .state = await helper.getItemsCantidadesBajas();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ItemCantidadesBajasPage(),
                              ),
                            );
                            break;
                          case 'inventario':
                            ItemHelper helper = ItemHelper();
                            ref.read(listaItemsProvider.notifier).state =
                                await helper.getItems();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => InventarioItems(),
                              ),
                            );
                            break;
                          default:
                        }
                      },
                    );
                  },
                ),
              )
            ]),
      ),
    );
  }
}

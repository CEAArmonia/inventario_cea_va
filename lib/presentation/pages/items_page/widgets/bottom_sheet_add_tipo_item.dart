// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:inventario_cea_va/presentation/providers/item_provider.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class BottomSheetAddTipoItem extends ConsumerWidget {
  BottomSheetAddTipoItem({Key? key}) : super(key: key);
  final TextEditingController _tfTipoItemController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    _tfTipoItemController.text = ref.watch(tipoItemNombreProvider);

    return Container(
      height: size.height * .20,
      decoration: const BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Agregar Tipo de Item",
                style: GoogleFonts.lilitaOne(
                  fontSize: 15,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
            TextField(
              controller: _tfTipoItemController,
              cursorColor: AppTheme.brightColor,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                label: Text('Tipo de Item'),
                icon: Icon(Icons.list_sharp),
              ),
              onChanged: (value) {
                ref
                    .read(tipoItemNombreProvider.notifier)
                    .update((state) => value);
              },
            ),
            ElevatedButton(
              child: const Text('Agregar Tipo'),
              onPressed: () async {
                ItemHelper helper = ItemHelper();
                TipoItem? tipoItemAdded;
                String tipoItemName = _tfTipoItemController.text;
                if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                  if (tipoItemName != '' && tipoItemName.isNotEmpty) {
                    tipoItemAdded = await helper.addTipoItem(tipoItemName);
                  }
                  if (tipoItemAdded != null) {
                    List<TipoItem> lista = await helper.getTiposItem();
                    lista.add(tipoItemAdded);
                    lista.sort(
                      (a, b) => a.nombre.compareTo(b.nombre),
                    );
                    ref.read(tiposItemProvider.notifier).state = lista;
                    Navigator.pop(context);
                  }
                } else {
                  GlobalFunctions.logoutUser();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.loginPage, (route) => false);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

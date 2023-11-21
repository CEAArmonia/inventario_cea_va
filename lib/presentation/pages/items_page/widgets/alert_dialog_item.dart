// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AlertDialogItem extends ConsumerWidget {
  Icon icon;
  Text title;
  Text content;
  TipoItem tipoItem;
  AlertDialogItem(this.icon, this.title, this.content, this.tipoItem,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      icon: icon,
      title: title,
      content: content,
      actions: [
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () async {
            ItemHelper itemHelper = ItemHelper();
            List<TipoItem> lista = await itemHelper.getTiposItem();
            if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
              TipoItem deletedTipoItem =
                  await itemHelper.deleteTipoItem(tipoItem.id);
              lista.remove(deletedTipoItem);
              ref.read(tiposItemProvider.notifier).state = lista;
              Navigator.pop(context);
            } else {
              GlobalFunctions.logoutUser();
              Navigator.popAndPushNamed(context, AppRoutes.loginPage);
            }
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

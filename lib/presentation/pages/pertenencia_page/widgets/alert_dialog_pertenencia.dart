// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/db/db_helpers/pertenencia_helper.dart';
import 'package:inventario_cea_va/models/item.dart';
import 'package:inventario_cea_va/models/pertenece.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

class AlertDialogPertenencia extends ConsumerWidget {
  Pertenece pertenencia;
  AlertDialogPertenencia(this.pertenencia, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      icon: const Icon(
        LineIcons.boxOpen,
        color: AppTheme.shadowColor,
      ),
      title: const Text(
        'Retornar Item',
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text('Item: ${pertenencia.item.nombre}'),
            Text('Cantidad: ${pertenencia.cantidad}')
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () async {
            PertenenciaHelper pertenenciaHelper = PertenenciaHelper();
            ItemHelper itemHelper = ItemHelper();
            ref.read(listaItemsProvider.notifier).state = await itemHelper.getItems();
            Pertenece pertenenciaRetornada =
                await pertenenciaHelper.retornarPertenencia(pertenencia);
            ref.read(listaPertenenciasProvider.notifier).update((state) {
              Pertenece pertenece = state.firstWhere(
                  (element) => element.id == pertenenciaRetornada.id);
              pertenece.fechaRetorno = pertenenciaRetornada.fechaRetorno;
              pertenece.retornado = pertenenciaRetornada.retornado;
              return state;
            });
            ref.read(listaItemsProvider.notifier).update((state) {
              Item item = state.firstWhere((element) => element.id == pertenenciaRetornada.item.id);
              item.cantidad = item.cantidad + pertenenciaRetornada.cantidad;
              return state;
            }); 
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

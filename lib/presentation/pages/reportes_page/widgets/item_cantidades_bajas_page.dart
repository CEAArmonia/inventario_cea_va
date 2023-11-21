// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/global_data/reportes_helpers/reportes_helpers.dart';
import 'package:inventario_cea_va/presentation/pages/pertenencia_page/widgets/pertenencias_documento_pdf.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

import '../../../../global_data/global_functions.dart';
import '../../../../models/models.dart';

class ItemCantidadesBajasPage extends ConsumerWidget {
  const ItemCantidadesBajasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Item> listaItems = ref.watch(itemCantidadesBajasProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cantidades Bajas de Items'),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.print),
            onPressed: () async {
              ReportesHelper helper = ReportesHelper();
              File reporterFile = await helper.reporteCantidades(
                ref.watch(itemCantidadesBajasProvider),
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PertenenciasDocumentoPdf(reporterFile),
                ),
              );
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: listaItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: listaItems[index].cantidad <= 5
                ? AppTheme.brightColor
                : AppTheme.secondaryColor,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Tipo: ${listaItems[index].tipo.nombre}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Nombre: ${listaItems[index].nombre}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Cantidad: ${listaItems[index].cantidad}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Text('${listaItems[index].desc}'),
                ),
                Expanded(
                  child: Text(
                      'Fecha compra: ${GlobalFunctions.dateToString(listaItems[index].fechaCompra)}'),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

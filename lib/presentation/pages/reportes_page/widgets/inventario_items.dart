// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/reportes_helpers/reportes_helpers.dart';
import 'package:inventario_cea_va/presentation/pages/pertenencia_page/widgets/pertenencias_documento_pdf.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../models/models.dart';

class InventarioItems extends ConsumerWidget {
  InventarioItems({super.key});

  TextStyle estilo = GoogleFonts.lato(
    color: AppTheme.shadowColor,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Item> items = ref.watch(listaItemsProvider);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario'),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.print),
            onPressed: () async {
              ReportesHelper helper = ReportesHelper();
              List<Item> itemsReporte = ref.watch(listaItemsProvider);
              File pdfFile = await helper.reporteInventario(itemsReporte);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PertenenciasDocumentoPdf(pdfFile),
                ),
              );
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * .10,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Ordenar por nombre',
                            style: estilo,
                          ),
                          Checkbox(
                            value: ref.watch(itemCheckBoxNombreProvider),
                            onChanged: (value) {
                              if (value!) {
                                ref
                                    .read(itemCheckBoxNombreProvider.notifier)
                                    .state = true;
                                ref
                                    .read(itemCheckBoxValorProvider.notifier)
                                    .state = false;
                                ref
                                    .read(itemCheckBoxCantidadProvider.notifier)
                                    .state = false;
                                List<Item> listaOrdenada = items;
                                listaOrdenada.sort(
                                  (a, b) => a.nombre.compareTo(b.nombre),
                                );
                                ref.read(listaItemsProvider.notifier).state =
                                    listaOrdenada;
                              } else {
                                ref
                                    .read(itemCheckBoxNombreProvider.notifier)
                                    .state = false;
                                ref.read(listaItemsProvider.notifier).state =
                                    items;
                              }
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Ordenar cantidad',
                            style: estilo,
                          ),
                          Checkbox(
                            value: ref.watch(itemCheckBoxCantidadProvider),
                            onChanged: (value) {
                              if (value!) {
                                ref
                                    .read(itemCheckBoxCantidadProvider.notifier)
                                    .state = true;
                                ref
                                    .read(itemCheckBoxValorProvider.notifier)
                                    .state = false;
                                ref
                                    .read(itemCheckBoxNombreProvider.notifier)
                                    .state = false;
                                List<Item> listaOrdenada = items;
                                listaOrdenada.sort(
                                  (a, b) => a.cantidad.compareTo(b.cantidad),
                                );
                                ref.read(listaItemsProvider.notifier).state =
                                    listaOrdenada;
                              } else {
                                ref
                                    .read(itemCheckBoxCantidadProvider.notifier)
                                    .state = false;
                                ref.read(listaItemsProvider.notifier).state =
                                    items;
                              }
                            },
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Ordenar por precio',
                            style: estilo,
                          ),
                          Checkbox(
                            value: ref.watch(itemCheckBoxValorProvider),
                            onChanged: (value) {
                              if (value!) {
                                ref
                                    .read(itemCheckBoxValorProvider.notifier)
                                    .state = value;
                                ref
                                    .read(itemCheckBoxNombreProvider.notifier)
                                    .state = false;
                                ref
                                    .read(itemCheckBoxCantidadProvider.notifier)
                                    .state = false;
                                List<Item> listaOrdenada = items;
                                listaOrdenada.sort(
                                  (a, b) => a.valor.compareTo(b.valor),
                                );
                                ref.read(listaItemsProvider.notifier).state =
                                    listaOrdenada;
                              } else {
                                ref
                                    .read(itemCheckBoxValorProvider.notifier)
                                    .state = false;
                                ref.read(listaItemsProvider.notifier).state =
                                    items;
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          const ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Nombre'),
                Text('Fecha Compra'),
                Text('Cantidad'),
                Text('Precio'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(items[index].nombre),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          GlobalFunctions.dateToString(
                              items[index].fechaCompra),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${items[index].cantidad}',
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${items[index].valor}',
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

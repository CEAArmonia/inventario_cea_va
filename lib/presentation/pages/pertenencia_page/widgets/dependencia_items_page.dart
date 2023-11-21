// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/pertenencia_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/item.dart';
import 'package:inventario_cea_va/models/item_asignado.dart';
import 'package:inventario_cea_va/models/pertenece.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

class DependenciaItems extends ConsumerWidget {
  final String dependenciaId;
  final TextEditingController _tfNombreItem = TextEditingController();

  DependenciaItems(this.dependenciaId, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    List<Item> listaItems = ref.watch(listaItemsProvider);
    List<ItemAsignado> listaItemsAsignados =
        ref.watch(listaItemsAsignadosProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 25, 15, 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _tfNombreItem,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Ingrese el nombre del item",
                icon: Icon(LineIcons.search),
              ),
              onChanged: (value) {
                List<Item> items = listaOriginal;
                List<Item> itemsFiltrados =
                    items.where((item) => item.nombre.contains(value)).toList();
                ref
                    .read(listaItemsProvider.notifier)
                    .update((state) => itemsFiltrados);
              },
            ),
            SizedBox(
              height: size.height * .01,
            ),
            SizedBox(
              height: size.height * 0.07,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: listaItemsAsignados.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        ItemAsignado item = listaItemsAsignados[index];
                        return Card(
                          elevation: 5,
                          shadowColor: AppTheme.shadowColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  item.nombreItem,
                                  style: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: AppTheme.shadowColor),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '${item.cantidad}',
                                  style: GoogleFonts.lato(
                                      fontSize: 12,
                                      color: AppTheme.shadowColor),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  TextButton(
                    child: const Text('Guardar'),
                    onPressed: () async {
                      PertenenciaHelper pertenenciaHelper = PertenenciaHelper();
                      if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                        List<ItemAsignado> listaAsignados =
                            ref.watch(listaItemsAsignadosProvider);
                        showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator(color: AppTheme.brightColor,)),);
                        for (ItemAsignado item in listaAsignados) {
                          Pertenece pertenencia = await pertenenciaHelper.addPertenencia(item.id, dependenciaId, item.cantidad);
                          int indiceModificado = listaItems.indexWhere((item) => item.id == pertenencia.item.id);
                          ref.read(listaItemsProvider.notifier).update((state) {
                            listaItems[indiceModificado].cantidad = listaItems[indiceModificado].cantidad - pertenencia.cantidad;
                            return listaItems;
                          });
                          //TODO: corregir las peretencias con el gestor de estados
                          ref.read(listaPertenenciasProvider.notifier).update((state) {
                            List<Pertenece> listaPertenencias = ref.watch(listaPertenenciasProvider);
                            listaPertenencias.add(pertenencia);
                            return listaPertenencias;
                          });
                        }
                        Navigator.popUntil(context, ModalRoute.withName(AppRoutes.dependenciaPage));
                        
                      } else {
                        GlobalFunctions.logoutUser();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginPage, (route) => false);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaItems.length,
                itemBuilder: (context, index) {
                  Item item = listaItems[index];
                  return SizedBox(
                    height: 85,
                    child: Card(
                      elevation: 4,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(child: Text(item.nombre)),
                            Text('${item.cantidad}')
                          ],
                        ),
                        subtitle: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(child: Text('Item')),
                            Text('Cantidad')
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                LineIcons.plus,
                                size: 15,
                                weight: 5,
                              ),
                              onPressed: () {
                                if (item.cantidad - 1 >= 0) {
                                  ref
                                      .read(listaItemsProvider.notifier)
                                      .update((state) {
                                    item.cantidad = item.cantidad - 1;
                                    List<Item> nuevaLista =
                                        List.from(listaItems);
                                    return nuevaLista;
                                  });
                                  if (listaItemsAsignados.isEmpty) {
                                    ItemAsignado itemAsignado = ItemAsignado(
                                        id: item.id,
                                        nombreItem: item.nombre,
                                        cantidad: 1);
                                    ref
                                        .read(listaItemsAsignadosProvider
                                            .notifier)
                                        .update((state) {
                                      List<ItemAsignado> list = [];
                                      list.add(itemAsignado);
                                      return list;
                                    });
                                  } else {
                                    int index = listaItemsAsignados.indexWhere(
                                        (asignado) => asignado.id == item.id);
                                    if (index >= 0) {
                                      ref.read(listaItemsAsignadosProvider.notifier).update((state) {
                                        var listaAsignados = ref.watch(listaItemsAsignadosProvider);
                                        int index = listaAsignados.indexWhere((itemAsignado) => itemAsignado.id == item.id);
                                        listaAsignados[index].cantidad = listaAsignados[index].cantidad + 1;
                                        return listaAsignados;
                                      });
                                    } else {
                                      ItemAsignado itemAsignado = ItemAsignado(
                                          id: item.id,
                                          nombreItem: item.nombre,
                                          cantidad: 1);
                                      ref
                                          .read(listaItemsAsignadosProvider
                                              .notifier)
                                          .update((state) {
                                        List<ItemAsignado> list =
                                            listaItemsAsignados;
                                        list.add(itemAsignado);
                                        return list;
                                      });
                                    }
                                  }
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(LineIcons.minus, size: 15),
                              onPressed: () {
                                if (listaItemsAsignados.isNotEmpty) {
                                  int indiceAsignado = listaItemsAsignados.indexWhere((itemAsignado) => itemAsignado.id == item.id);
                                  if(indiceAsignado >= 0){
                                    listaItemsAsignados[indiceAsignado].cantidad = listaItemsAsignados[indiceAsignado].cantidad - 1;
                                    ref.read(listaItemsAsignadosProvider.notifier).update((state) {
                                      List<ItemAsignado> nuevaLista = List.from(listaItemsAsignados);
                                      return nuevaLista;
                                    });
                                    ref.read(listaItemsProvider.notifier).update((state) {
                                      item.cantidad = item.cantidad + 1;
                                      List<Item> nuevaLista = List.from(listaItems);
                                      return nuevaLista;
                                    });
                                    if(listaItemsAsignados[indiceAsignado].cantidad - 1 < 0){
                                      ref.read(listaItemsAsignadosProvider.notifier).update((state) {
                                        List<ItemAsignado> nuevaLista = [];
                                        return nuevaLista;
                                      });
                                    }
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

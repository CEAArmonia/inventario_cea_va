// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/item.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

class BottomSheetAddItems extends ConsumerWidget {
  String itemId;
  BottomSheetAddItems(this.itemId, {super.key});

  Timer? temporizador;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int cantidad = ref.watch(itemCantidadAddedProvider);
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .25,
      decoration: const BoxDecoration(
        color: AppTheme.secondaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              LineIcons.boxes,
              size: 50,
              color: AppTheme.shadowColor,
            ),
            Text(
              'Cantidades a Añadir',
              style: GoogleFonts.lilitaOne(
                fontSize: 25,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 100,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Cantidad: $cantidad',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      GestureDetector(
                        child: IconButton(
                          icon: const Icon(LineIcons.arrowCircleUp),
                          onPressed: () {
                            cantidad++;
                            ref.read(itemCantidadAddedProvider.notifier).state =
                                cantidad;
                          },
                        ),
                        onLongPressUp: () {
                          temporizador!.cancel();
                        },
                        onLongPress: () {
                          Duration duracion = const Duration(milliseconds: 100);
                          temporizador = Timer.periodic(duracion, (timer) {
                            cantidad += 10;
                            ref.read(itemCantidadAddedProvider.notifier).state =
                                cantidad;
                          });
                        },
                      ),
                      GestureDetector(
                        child: IconButton(
                          icon: const Icon(LineIcons.arrowCircleDown),
                          onPressed: () {
                            cantidad > 0 ? cantidad-- : cantidad;
                            ref.read(itemCantidadAddedProvider.notifier).state =
                                cantidad;
                          },
                        ),
                        onLongPressUp: () {
                          temporizador!.cancel();
                        },
                        onLongPress: () {
                          Duration duracion = const Duration(milliseconds: 100);
                          temporizador = Timer.periodic(duracion, (timer) {
                            cantidad > 10 ? cantidad -= 10 : cantidad;
                            ref.read(itemCantidadAddedProvider.notifier).state =
                                cantidad;
                          });
                        },
                      ),
                    ],
                  ),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LineIcons.infoCircle),
                        SizedBox(width: 10),
                        Text('Presionar sostenido para grandes incrementos')
                      ])
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  child: const Text('Aceptar'),
                  onPressed: () async {
                    ItemHelper itemHelper = ItemHelper();
                    if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                      Item item =
                          await itemHelper.addItemNumber(itemId, cantidad);
                      ref.read(listaItemsProvider.notifier).update((state) {
                        Item itemModficado =
                            state.firstWhere((element) => element.id == itemId);
                        itemModficado.cantidad = item.cantidad;
                        return state;
                      });
                      Navigator.pop(context);
                    } else {
                      GlobalFunctions.logoutUser();
                      Navigator.popAndPushNamed(context, AppRoutes.loginPage);
                    }
                  },
                ),
                TextButton(
                  child: const Text('Cancelar'),
                  onPressed: () {
                    ref.invalidate(itemCantidadAddedProvider);
                    Navigator.pop(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

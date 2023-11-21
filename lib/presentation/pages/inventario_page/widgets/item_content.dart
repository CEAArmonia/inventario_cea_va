// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/responsable_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:inventario_cea_va/presentation/pages/inventario_page/widgets/bottom_sheet_add_items.dart';
import 'package:inventario_cea_va/presentation/pages/inventario_page/widgets/dialog_responsable.dart';
import 'package:inventario_cea_va/presentation/pages/inventario_page/widgets/expanded_theme.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

class ItemContent extends ConsumerWidget {
  Item item;
  ItemContent(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * .25,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppTheme.primaryColor, AppTheme.secondaryColor],
        ),
      ),
      child: Row(children: [
        SizedBox(
          width: size.width / 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Fecha de Compra: ${GlobalFunctions.dateToString(item.fechaCompra)}',
                style: expandedTextStyle,
              ),
              Text(
                'Estado: ${item.estado}',
                style: expandedTextStyle,
              ),
              Text(
                'Cantidad: ${item.cantidad}',
                style: expandedTextStyle,
              ),
              Text(
                'Descripción: ${item.desc}',
                style: expandedTextStyle,
              ),
              Text(
                'Observaciones: ${item.observaciones}',
                style: expandedTextStyle,
              )
            ],
          ),
        ),
        SizedBox(
          width: (size.width / 3) * 1.5,
          child: GridView.count(
            mainAxisSpacing: 10,
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              GestureDetector(
                child: SizedBox(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          LineIcons.shoppingCartArrowDown,
                          size: 30,
                          color: AppTheme.brightColor,
                        ),
                        Text(
                          'Añadir Item',
                          textAlign: TextAlign.center,
                          style: expandedTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => BottomSheetAddItems(item.id),
                  );
                },
              ),
              GestureDetector(
                child: SizedBox(
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          LineIcons.shoppingBag,
                          size: 30,
                          color: AppTheme.brightColor,
                        ),
                        Text(
                          'Asignación',
                          textAlign: TextAlign.center,
                          style: expandedTextStyle,
                        )
                      ],
                    ),
                  ),
                ),
                onTap: () async {
                  ResponsableHelper helper = ResponsableHelper();
                  if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                    ref.read(listaResponsableProvider.notifier).state = await helper.getResponsables();
                    showDialog(context: context, builder: (context) => DialogResponsable(item),);
                  } else {
                    GlobalFunctions.logoutUser();
                    Navigator.popAndPushNamed(context, AppRoutes.loginPage);
                  }
                },
              ),
            ],
          ),
        )
      ]),
    );
  }
}

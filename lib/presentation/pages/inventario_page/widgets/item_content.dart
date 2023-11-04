// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/models/item.dart';
import 'package:inventario_cea_va/presentation/pages/inventario_page/widgets/expanded_theme.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

class ItemContent extends StatelessWidget {
  Item item;
  ItemContent(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        LineIcons.qrcode,
                        size: 30,
                        color: AppTheme.brightColor,
                      ),
                      Text(
                        'Generar Código',
                        textAlign: TextAlign.center,
                        style: expandedTextStyle,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  //TODO: Código para generar código QR
                },
              ),
              GestureDetector(
                child: SizedBox(
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
                onTap: () {
                  //TODO: Código para generar añadir Items
                },
              ),
              GestureDetector(
                child: SizedBox(
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
                        'Responsable',
                        textAlign: TextAlign.center,
                        style: expandedTextStyle,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  //TODO: Código para generar código QR
                },
              ),
              GestureDetector(
                child: SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        LineIcons.alternateExchange,
                        size: 30,
                        color: AppTheme.brightColor,
                      ),
                      Text(
                        'Dependencia',
                        textAlign: TextAlign.center,
                        style: expandedTextStyle,
                      )
                    ],
                  ),
                ),
                onTap: () {
                  //TODO: Código para generar código QR
                },
              )
            ],
          ),
        )
      ]),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/dependencia_helper.dart';
import 'package:inventario_cea_va/db/db_helpers/item_helper.dart';
import 'package:inventario_cea_va/db/db_helpers/pertenencia_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/global_data/reportes_helpers/reportes_helpers.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:inventario_cea_va/presentation/pages/pertenencia_page/widgets/alert_dialog_pertenencia.dart';
import 'package:inventario_cea_va/presentation/pages/pertenencia_page/widgets/dependencia_items_page.dart';
import 'package:inventario_cea_va/presentation/pages/pertenencia_page/widgets/pertenencias_documento_pdf.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import '../../providers/providers.dart';

class PertenenciaPage extends ConsumerWidget {
  final String id;
  const PertenenciaPage(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    List<Pertenece> listaPertenencias = ref.watch(listaPertenenciasProvider);
    Dependencia? dependencia = ref.watch(dependenciaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertenencias'),
        leading: const Icon(LineIcons.objectGroup),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.print),
            onPressed: () async {
              if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                DependenciaHelper dependenciaHelper = DependenciaHelper();
                PertenenciaHelper pertenenciaHelper = PertenenciaHelper();
                ReportesHelper reportesHelper = ReportesHelper();
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                Dependencia dependencia =
                    await dependenciaHelper.getDependenciaPorId(id);
                List<Pertenece> pertenencias =
                    await pertenenciaHelper.getPertenencias(id);
                File reporteFile = await reportesHelper.reportePertenencias(
                    dependencia, pertenencias);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PertenenciasDocumentoPdf(reporteFile),
                    ));
              }
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * .010),
              child: Card(
                child: SizedBox(
                  height: size.height * .10,
                  width: size.width * .95,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        dependencia!.nombre,
                        style: GoogleFonts.lilitaOne(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        dependencia.desc,
                        style: GoogleFonts.lato(
                          color: AppTheme.shadowColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaPertenencias.length,
                itemBuilder: (context, index) {
                  Pertenece pertenencia = listaPertenencias[index];
                  return ListTile(
                    tileColor: pertenencia.retornado
                        ? AppTheme.brightColor
                        : AppTheme.secondaryColor,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FutureBuilder(
                          future: ItemHelper().getItemById(pertenencia.item.id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              Item item = snapshot.data!;
                              return Text(
                                item.nombre,
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              );
                            } else {
                              return const CircularProgressIndicator(
                                color: AppTheme.primaryColor,
                              );
                            }
                          },
                        ),
                        Text(
                          GlobalFunctions.dateToString(pertenencia.fecha),
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Cantidad: ${pertenencia.cantidad}',
                          style: GoogleFonts.lato(fontSize: 13),
                        ),
                        Text(
                          'Retorno: ${pertenencia.retornado ? 'Devuelto' : 'En Posesión'}',
                          style: GoogleFonts.lato(fontSize: 13),
                        ),
                        Text(
                          'Fecha Retorno: ${pertenencia.retornado ? GlobalFunctions.dateToString(pertenencia.fechaRetorno!) : ''} ',
                          style: GoogleFonts.lato(fontSize: 13),
                        )
                      ],
                    ),
                    onTap: () {
                      if (!pertenencia.retornado) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialogPertenencia(pertenencia),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        tooltip: 'Asignar Items',
        child: const Icon(
          LineIcons.pencilRuler,
          size: 30,
        ),
        onPressed: () async {
          ItemHelper itemHelper = ItemHelper();
          if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
            List<Item> listaItems = await itemHelper.getItems();
            ref.read(listaItemsProvider.notifier).update((state) => listaItems);
            listaOriginal = ref.watch(listaItemsProvider);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DependenciaItems(id),
              ),
            );
          } else {
            GlobalFunctions.logoutUser();
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.loginPage, (route) => false);
          }
        },
      ),
    );
  }
}

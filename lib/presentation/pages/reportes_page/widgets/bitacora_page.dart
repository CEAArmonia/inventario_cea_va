// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/usuario_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/reportes_helpers/reportes_helpers.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:inventario_cea_va/presentation/pages/pertenencia_page/widgets/pertenencias_documento_pdf.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/presentation/providers/user_provider.dart';
import 'package:line_icons/line_icons.dart';

class BitacoraPage extends ConsumerWidget {
  const BitacoraPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Bitacora> listaBitacoras = ref.watch(listaBitacoraProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bitacora de accesos'),
        actions: [
          IconButton(
            icon: const Icon(LineIcons.print),
            onPressed: () async {
              User? usuarioSeleccionado = ref.watch(userDropdownSelected);
              List<Bitacora> listaBitacoras = ref.watch(listaBitacoraProvider);
              ReportesHelper reportesHelper = ReportesHelper();
              reportesHelper.reporteBitacorasAcceso(
                  usuarioSeleccionado, listaBitacoras);
              File reporteFile = await reportesHelper.reporteBitacorasAcceso(
                  usuarioSeleccionado, listaBitacoras);
              ref.invalidate(userDropdownSelected);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PertenenciasDocumentoPdf(reporteFile),
                ),
              );
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Center(
              child: DropdownButton<User>(
                alignment: AlignmentDirectional.bottomCenter,
                hint: const Text('Seleccione Usuario'),
                value: ref.watch(userDropdownSelected),
                items: ref.watch(listaUsersProvider).map((user) {
                  return DropdownMenuItem<User>(
                    value: user,
                    child: Text(user.nombre),
                  );
                }).toList(),
                onChanged: (value) async {
                  UsuarioHelper helper = UsuarioHelper();
                  ref.read(userDropdownSelected.notifier).state = value;
                  ref.read(listaBitacoraProvider.notifier).state =
                      await helper.getBitacorasByUser(value!.id);
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listaBitacoras.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(listaBitacoras[index].usuario!.nombre),
                        Text(GlobalFunctions.dateToString(
                            listaBitacoras[index].fecha))
                      ],
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          child: Row(
                            children: [
                              const Text('Administrador: '),
                              Text(listaBitacoras[index].usuario!.administrador
                                  ? 'Si'
                                  : 'No'),
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            children: [
                              const Text('Teléfono: '),
                              Text(listaBitacoras[index].usuario!.telefono),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

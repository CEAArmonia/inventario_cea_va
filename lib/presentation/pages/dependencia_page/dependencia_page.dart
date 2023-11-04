// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/dependencia_helper.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/dependencia.dart';
import 'package:inventario_cea_va/presentation/pages/pages.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';

class DependenciaPage extends ConsumerWidget {
  DependenciaPage({Key? key}) : super(key: key);

  final TextEditingController _tfDependenciaNombreController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    List<Dependencia> listaDependencia = ref.watch(listaDependenciaProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dependencias'),
        leading: const Icon(LineIcons.school),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: _tfDependenciaNombreController,
                decoration: InputDecoration(
                  icon: const Icon(LineIcons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(LineIcons.plusCircle),
                    onPressed: () {
                      if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                        showDialog(
                          context: context,
                          builder: (context) => AddDependecia(),
                        );
                      } else {
                        jwtUsuarioConectado = '';
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginPage, (route) => false);
                      }
                    },
                  ),
                  labelText: "Nombre de Dependencia",
                ),
                onChanged: (value) async {
                  DependenciaHelper dependenciaHelper = DependenciaHelper();
                  List<Dependencia> listaDependencias =
                      await dependenciaHelper.getDependencias(value);
                  ref
                      .read(listaDependenciaProvider.notifier)
                      .update((state) => listaDependencias);
                },
              ),
              SizedBox(
                height: size.height * .01,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: listaDependencia.length,
                  itemBuilder: (context, index) {
                    Dependencia dependencia = listaDependencia[index];
                    return Card(
                      margin: const EdgeInsets.all(8),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        title: Text(dependencia.nombre),
                        subtitle: Text(dependencia.desc),
                        contentPadding: const EdgeInsets.only(left: 4),
                        leading: const Icon(LineIcons.school),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(LineIcons.trash),
                              tooltip: 'Eliminar Dependencia',
                              onPressed: () async {
                                if (!JwtDecoder.isExpired(
                                    jwtUsuarioConectado)) {
                                  DependenciaHelper helper =
                                      DependenciaHelper();
                                  Dependencia? dependenciaEliminada =
                                      await helper
                                          .removeDependency(dependencia.id);
                                  if (dependenciaEliminada != null) {
                                    List<Dependencia> listaDependencias =
                                        await helper.getDependencias('');
                                    ref
                                        .read(listaDependenciaProvider.notifier)
                                        .update((state) => listaDependencias);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Dependencia Eliminada')));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'No se puede eliminar la Dependencia')));
                                  }
                                } else {
                                  jwtUsuarioConectado = '';
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRoutes.loginPage, (route) => false);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(LineIcons.editAlt),
                              tooltip: 'Editar Dependencia',
                              onPressed: () {
                                if (!JwtDecoder.isExpired(
                                    jwtUsuarioConectado)) {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        EditDependecia(dependencia.id),
                                  );
                                } else {
                                  jwtUsuarioConectado = '';
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRoutes.loginPage, (route) => false);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(LineIcons.directions),
                              tooltip: 'Pertenencias',
                              onPressed: () {
                                if (!JwtDecoder.isExpired(
                                    jwtUsuarioConectado)) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PertenenciaPage(dependencia.id),
                                    ),
                                  );
                                } else {
                                  jwtUsuarioConectado = '';
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRoutes.loginPage, (route) => false);
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

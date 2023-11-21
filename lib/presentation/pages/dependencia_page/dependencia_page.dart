// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/dependencia_helper.dart';
import 'package:inventario_cea_va/db/db_helpers/pertenencia_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/dependencia.dart';
import 'package:inventario_cea_va/presentation/pages/pages.dart';
import 'package:inventario_cea_va/presentation/providers/providers.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
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
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  icon: const Icon(LineIcons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(
                      LineIcons.plusCircle,
                      color: AppTheme.shadowColor,
                    ),
                    onPressed: () {
                      if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                        showDialog(
                          context: context,
                          builder: (context) => AddDependecia(),
                        );
                      } else {
                        GlobalFunctions.logoutUser();
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
                        leading: const Icon(
                          LineIcons.school,
                          color: AppTheme.shadowColor,
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                LineIcons.trash,
                                color: AppTheme.shadowColor,
                              ),
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
                                  GlobalFunctions.logoutUser();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRoutes.loginPage, (route) => false);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                LineIcons.editAlt,
                                color: AppTheme.shadowColor,
                              ),
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
                                  GlobalFunctions.logoutUser();
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRoutes.loginPage, (route) => false);
                                }
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                LineIcons.directions,
                                color: AppTheme.shadowColor,
                              ),
                              tooltip: 'Pertenencias',
                              onPressed: () async {
                                PertenenciaHelper helper = PertenenciaHelper();
                                if (!JwtDecoder.isExpired(
                                    jwtUsuarioConectado)) {
                                  ref
                                          .read(listaPertenenciasProvider.notifier)
                                          .state =
                                      await helper
                                          .getPertenencias(dependencia.id);
                                  //TODO: AQuí!!
                                  ref
                                      .read(dependenciaProvider.notifier)
                                      .update((state) => dependencia);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PertenenciaPage(dependencia.id),
                                    ),
                                  );
                                } else {
                                  GlobalFunctions.logoutUser();
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

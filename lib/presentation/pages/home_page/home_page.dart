// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/usuario_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/presentation/pages/home_page/widgets/dialog_add_user.dart';
import 'package:inventario_cea_va/presentation/pages/home_page/widgets/grid_options.dart';
import 'package:inventario_cea_va/presentation/pages/home_page/widgets/home_bottom_sheet.dart';
import 'package:inventario_cea_va/presentation/pages/home_page/widgets/user_conf_bottomsheet.dart';
import 'package:inventario_cea_va/presentation/providers/login_provider.dart';
import 'package:inventario_cea_va/presentation/providers/user_provider.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:line_icons/line_icons.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuario = ref.watch(usuarioLogueadoProvider);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(
              LineIcons.home,
            ),
            SizedBox(
              width: 10,
            ),
            Text('Inicio'),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          const Text(
                            'Bienvenido',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(usuario)
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(LineIcons.userCog),
                      onPressed: () {
                        if (usuarioLogueado!.administrador) {
                          showDialog(
                            context: context,
                            builder: (context) => UserConfBottomSheet(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'No tiene permisos para realizar esa tarea'),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(LineIcons.userPlus),
                      onPressed: () {
                        if (usuarioLogueado!.administrador) {
                          showDialog(
                            context: context,
                            builder: (context) => DialogAddUser(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'No tiene permisos para realizar esa tarea'),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.verified_user,
                      ),
                      onPressed: () async {
                        UsuarioHelper helper = UsuarioHelper();
                        ref.read(listaUsersProvider.notifier).state = await helper.getUsers();
                        if (usuarioLogueado!.administrador) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => const HomeBottomSheet(),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'No tiene permisos para realizar esa tarea'),
                            ),
                          );
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(LineIcons.alternateSignOut),
                      onPressed: () {
                        GlobalFunctions.logoutUser();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginPage, (route) => false);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .015,
              ),
              Expanded(
                child: GridOptions(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

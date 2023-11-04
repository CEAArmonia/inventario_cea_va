import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/models/user.dart';
import 'package:inventario_cea_va/presentation/pages/home_page/widgets/grid_options.dart';
import 'package:inventario_cea_va/presentation/pages/home_page/widgets/user_conf_bottomsheet.dart';
import 'package:inventario_cea_va/presentation/providers/login_provider.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
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
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleChildScrollView(
                            child: UserConfBottomSheet(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(LineIcons.alternateSignOut),
                      onPressed: () {
                        jwtUsuarioConectado = '';
                        usuarioLogueado = User(
                          id: 'id',
                          nombre: 'nombre',
                          telefono: 'telefono',
                          ci: 'ci',
                        );
                        Navigator.popAndPushNamed(context, AppRoutes.loginPage);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: size.height * .45,
                child: GridOptions(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

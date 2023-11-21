import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:inventario_cea_va/presentation/providers/user_provider.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';

class HomeBottomSheet extends ConsumerWidget {
  const HomeBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    List<User> users = ref.watch(listaUsersProvider);
    return Container(
      height: size.height * .3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Habilitar/Deshabilitar Usuario',
            style: GoogleFonts.lilitaOne(
              fontSize: 25,
              color: AppTheme.shadowColor,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                User user = users[index];
                return SwitchListTile(
                  value: user.activo!,
                  activeColor: AppTheme.brightColor,
                  inactiveThumbColor: AppTheme.shadowColor,
                  title: Text(
                    user.nombre,
                    style: GoogleFonts.lato(
                      color: AppTheme.primaryColor,
                      fontSize: 15,
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(listaUsersProvider.notifier).update((state) {
                      User usuarioSeleccionado =
                          state.firstWhere((element) => element.id == user.id);
                      usuarioSeleccionado.activo = value;
                      return state;
                    });
                  },
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Aceptar',
              style: GoogleFonts.lato(
                color: AppTheme.shadowColor,
                fontSize: 15,
              ),
            ),
          )
        ],
      ),
    );
  }
}

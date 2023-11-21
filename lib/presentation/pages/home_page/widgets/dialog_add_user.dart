// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/usuario_helper.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/presentation/providers/login_provider.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

import '../../../../global_data/global_functions.dart';
import '../../../../models/models.dart';

class DialogAddUser extends ConsumerWidget {
  DialogAddUser({super.key});

  final TextEditingController _tfNombre = TextEditingController();
  final TextEditingController _tfPassword = TextEditingController();
  final TextEditingController _tfTelefono = TextEditingController();
  final TextEditingController _tfCi = TextEditingController();
  bool admin = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    bool obscureText = ref.watch(isObscureText);
    return AlertDialog(
      icon: const Icon(
        LineIcons.userPlus,
        size: 35,
        color: AppTheme.shadowColor,
      ),
      title: const Text('Añadir Usuario'),
      content: SizedBox(
        width: size.width * .7,
        height: size.height * .4,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _tfNombre,
                decoration: const InputDecoration(
                  hintText: 'Nombre Completo',
                  icon: Icon(LineIcons.user),
                ),
              ),
              TextField(
                controller: _tfCi,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Cédula de Identidad',
                  icon: Icon(LineIcons.identificationCardAlt),
                ),
              ),
              TextField(
                controller: _tfTelefono,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Teléfono',
                  icon: Icon(LineIcons.phone),
                ),
              ),
              TextField(
                controller: _tfPassword,
                obscureText: obscureText,
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  icon: const Icon(LineIcons.lock),
                  suffixIcon: IconButton(
                    onPressed: () {
                      ref
                          .read(isObscureText.notifier)
                          .update((state) => !obscureText);
                    },
                    icon: obscureText
                        ? const Icon(LineIcons.eye)
                        : const Icon(LineIcons.eyeSlash),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Administración:',
                    style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.shadowColor,
                    ),
                  ),
                  RoundCheckBox(
                    borderColor: AppTheme.brightColor,
                    uncheckedWidget: const Icon(
                      Icons.close,
                      color: AppTheme.shadowColor,
                    ),
                    checkedColor: AppTheme.primaryColor,
                    isChecked: admin,
                    onTap: (p0) {
                      admin = p0!;
                    },
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text(
                      'Añadir',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                        final UsuarioHelper helper = UsuarioHelper();
                        if (validarVacios()) {
                          User? usuarioNuevo = await helper.agregarUsuario(
                              _tfNombre.text,
                              _tfTelefono.text,
                              _tfCi.text,
                              _tfPassword.text,
                              admin);
                          if (usuarioNuevo != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content:
                                    Text('Usuario agregado correctamente.'),
                              ),
                            );
                          }
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Llene los espacios correctamente.'),
                            ),
                          );
                        }
                      } else {
                        GlobalFunctions.logoutUser();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginPage, (route) => false);
                      }
                    },
                  ),
                  TextButton(
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  bool validarVacios() {
    if (_tfNombre.text.isNotEmpty &&
        _tfPassword.text.isNotEmpty &&
        _tfTelefono.text.isNotEmpty &&
        _tfCi.text.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}

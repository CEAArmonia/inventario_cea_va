// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/usuario_helper.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/models.dart';
import 'package:inventario_cea_va/presentation/providers/login_provider.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:roundcheckbox/roundcheckbox.dart';

class UserConfBottomSheet extends ConsumerWidget {
  UserConfBottomSheet({Key? key}) : super(key: key);

  final TextEditingController _tfNombre = TextEditingController();
  final TextEditingController _tfPassword = TextEditingController();
  final TextEditingController _tfTelefono = TextEditingController();
  final TextEditingController _tfCi = TextEditingController();
  bool admin = false;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final obscureText = ref.watch(isObscureText);

    _tfNombre.text = ref.watch(usuarioLogueadoProvider);
    _tfTelefono.text = ref.watch(usuarioTelefonoProvider);
    _tfCi.text = ref.watch(usuarioCiProvider);
    _tfPassword.text = ref.watch(usuarioPasswordProvider);

    return AlertDialog(
      icon: const Icon(
        LineIcons.userCog,
        size: 30,
        color: AppTheme.shadowColor,
      ),
      title: const Text('Modificar Usuario'),
      content: Container(
        height: size.height * .40,
        width: size.width * .7,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 35,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: _tfNombre,
                decoration: const InputDecoration(
                  hintText: 'Nombre Completo',
                  icon: Icon(LineIcons.user),
                ),
                onEditingComplete: () {
                  ref
                      .read(usuarioLogueadoProvider.notifier)
                      .update((state) => _tfNombre.text);
                },
              ),
              TextField(
                controller: _tfTelefono,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  hintText: 'Teléfono',
                  icon: Icon(LineIcons.phone),
                ),
                onEditingComplete: () {
                  ref
                      .read(usuarioTelefonoProvider.notifier)
                      .update((state) => _tfTelefono.text);
                },
              ),
              TextField(
                controller: _tfCi,
                decoration: const InputDecoration(
                  hintText: 'Cédula de Identidad',
                  icon: Icon(LineIcons.identificationCardAlt),
                ),
                onEditingComplete: () {
                  ref
                      .read(usuarioCiProvider.notifier)
                      .update((state) => _tfCi.text);
                },
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
                onEditingComplete: () {
                  ref
                      .read(usuarioPasswordProvider.notifier)
                      .update((state) => _tfPassword.text);
                },
              ),
              const SizedBox(height: 10),
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
                    isChecked: ref.watch(usuarioAdministradorProvider),
                    onTap: (p0) {
                      ref.read(usuarioAdministradorProvider.notifier).state =
                          p0!;
                      admin = p0;
                    },
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child:
                        const Text('Modificar', style: TextStyle(fontSize: 16)),
                    onPressed: () async {
                      if (!JwtDecoder.isExpired(jwtUsuarioConectado)) {
                        UsuarioHelper helper = UsuarioHelper();
                        String? password;
                        if (_tfPassword.text.isEmpty) {
                          password = null;
                        } else {
                          password = _tfPassword.text;
                        }
                        User usuarioModificado = await helper.editarUsuario(
                            _tfNombre.text,
                            _tfTelefono.text,
                            _tfCi.text,
                            password,
                            admin);
                        ref.read(usuarioLogueadoProvider.notifier).state =
                            usuarioModificado.nombre;
                        ref.read(usuarioTelefonoProvider.notifier).state =
                            usuarioModificado.telefono;
                        ref.read(usuarioCiProvider.notifier).state =
                            usuarioModificado.ci;
                        ref.invalidate(usuarioPasswordProvider);
                        Navigator.pop(context);
                      } else {
                        GlobalFunctions.logoutUser();
                        Navigator.pushNamedAndRemoveUntil(
                            context, AppRoutes.loginPage, (route) => false);
                      }
                    },
                  ),
                  TextButton(
                    child:
                        const Text('Cancelar', style: TextStyle(fontSize: 16)),
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
}

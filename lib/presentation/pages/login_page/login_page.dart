// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/db/db_helpers/login_helper.dart';
import 'package:inventario_cea_va/presentation/providers/login_provider.dart';
import 'package:inventario_cea_va/routes/routes.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:line_icons/line_icons.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController tfCiController = TextEditingController();
  final TextEditingController tfPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;

    final obscureText = ref.watch(isObscureText);
    final mensaje = ref.watch(mensajeNoLogueo);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/login_image.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Container(
            height: size.height * .4,
            width: size.width * .75,
            decoration: const BoxDecoration(
              color: Color.fromARGB(133, 255, 133, 76),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: size.height * .05,
                horizontal: size.width * .10,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Ingresar',
                    style: GoogleFonts.lilitaOne(
                        color: AppTheme.secondaryColor,
                        fontSize: 35,
                        fontStyle: FontStyle.normal,
                        shadows: [
                          const Shadow(
                            color: AppTheme.shadowColor,
                            offset: Offset(.5, 2),
                            blurRadius: 5,
                          ),
                        ]),
                  ),
                  TextField(
                    cursorColor: AppTheme.shadowColor,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    controller: tfCiController,
                    decoration: const InputDecoration(
                      icon: Icon(
                        LineIcons.identificationCard,
                        color: AppTheme.shadowColor,
                        size: 30,
                      ),
                      hintText: 'Cédula de Identidad',
                    ),
                  ),
                  TextField(
                    cursorColor: AppTheme.shadowColor,
                    textAlign: TextAlign.center,
                    obscureText: obscureText,
                    keyboardType: TextInputType.visiblePassword,
                    controller: tfPasswordController,
                    decoration: InputDecoration(
                      icon: const Icon(
                        LineIcons.lock,
                        color: AppTheme.shadowColor,
                        size: 30,
                      ),
                      hintText: 'Contraseña',
                      suffixIcon: IconButton(
                        icon: obscureText
                            ? const Icon(
                                LineIcons.eye,
                                color: AppTheme.shadowColor,
                              )
                            : const Icon(
                                LineIcons.eyeSlash,
                                color: AppTheme.shadowColor,
                              ),
                        onPressed: () {
                          ref
                              .read(isObscureText.notifier)
                              .update((state) => !state);
                        },
                      ),
                    ),
                  ),
                  Text(
                    mensaje,
                    style: GoogleFonts.lilitaOne(
                      color: AppTheme.secondaryColor,
                      fontSize: 15,
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Iniciar Sesión'),
                    onPressed: () async {
                      String ci = tfCiController.text;
                      String password = tfPasswordController.text;
                      LoginHelper login = LoginHelper();
                      showDialog(
                        context: context,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      );
                      if (await login.loginUsuario(ci, password)) {
                        ref.read(usuarioLogueadoProvider.notifier).state =
                            usuarioLogueado.nombre;
                        ref.read(usuarioTelefonoProvider.notifier).state =
                            usuarioLogueado.telefono;
                        ref.read(usuarioCiProvider.notifier).state =
                            usuarioLogueado.ci;
                        navegarHome(context);
                      } else {
                        ref.read(mensajeNoLogueo.notifier).state =
                            'Usuario o Contraseña incorrectos';
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navegarHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.homePage, (_) => false);
  }
}

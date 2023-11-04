// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/presentation/providers/login_provider.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

class UserConfBottomSheet extends ConsumerWidget {
  UserConfBottomSheet({Key? key}) : super(key: key);

  final TextEditingController _tfNombre = TextEditingController();
  final TextEditingController _tfPassword = TextEditingController();
  final TextEditingController _tfTelefono = TextEditingController();
  final TextEditingController _tfCi = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    final obscureText = ref.watch(isObscureText);

    _tfNombre.text = ref.watch(usuarioLogueadoProvider);
    _tfTelefono.text = ref.watch(usuarioTelefonoProvider);
    _tfCi.text = ref.watch(usuarioCiProvider);
    _tfPassword.text = ref.watch(usuarioPasswordProvider);

    return Container(
      height: size.height * .35,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppTheme.brightColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25,
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
              onChanged: (value) {
                ref
                    .read(usuarioLogueadoProvider.notifier)
                    .update((state) => value);
              },
            ),
            TextField(
              controller: _tfTelefono,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Teléfono',
                icon: Icon(LineIcons.phone),
              ),
              onChanged: (value) {
                ref
                    .read(usuarioTelefonoProvider.notifier)
                    .update((state) => value);
              },
            ),
            TextField(
              controller: _tfCi,
              decoration: const InputDecoration(
                hintText: 'Cédula de Identidad',
                icon: Icon(LineIcons.identificationCardAlt),
              ),
              onChanged: (value) {
                ref.read(usuarioCiProvider.notifier).update((state) => value);
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
                    ref.read(isObscureText.notifier).update((state) => !obscureText);
                  },
                  icon: obscureText
                      ? const Icon(LineIcons.eye)
                      : const Icon(LineIcons.eyeSlash),
                ),
              ),
              onChanged: (value) {
                ref
                    .read(usuarioPasswordProvider.notifier)
                    .update((state) => value);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Modificar Usuario'),
            )
          ],
        ),
      ),
    );
  }
}

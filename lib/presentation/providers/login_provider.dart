import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/models/models.dart';

final usuarioLogueadoProvider = StateProvider<String>(
  (ref) {
    return 'Nombre de Usuario';
  },
);

final usuarioTelefonoProvider = StateProvider<String>(
  (ref) {
    return 'Telefono';
  },
);

final usuarioCiProvider = StateProvider<String>(
  (ref) {
    return 'Cédula de Identidad';
  },
);

final usuarioPasswordProvider = StateProvider<String>(
  (ref) {
    return '';
  },
);

final usuarioAdministradorProvider = StateProvider<bool>((ref) => false);

final isObscureText = StateProvider.autoDispose<bool>((ref) {
  return true;
});

final mensajeNoLogueo = StateProvider.autoDispose<String>((ref) => '');

final tfNombreControllerProvider = StateProvider((ref) => TextEditingController());

final listaBitacoraProvider = StateProvider<List<Bitacora>>((ref) => []);


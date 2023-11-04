// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/dependencia_helper.dart';
import 'package:inventario_cea_va/models/dependencia.dart';
import 'package:inventario_cea_va/presentation/providers/dependencia_provider.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

class AddDependecia extends ConsumerWidget {
  AddDependecia({Key? key}) : super(key: key);

  final TextEditingController _tfNombreDependenciaController =
      TextEditingController();
  final TextEditingController _tfDescDependenciaController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Dependencia> listaDependencia = ref.watch(listaDependenciaProvider);

    return AlertDialog(
      title: const Text('Añadir Dependencia'),
      icon: const Icon(
        LineIcons.school,
        color: AppTheme.primaryColor,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _tfNombreDependenciaController,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                labelText: "Nombre de la dependencia",
              ),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: _tfDescDependenciaController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: "Descripción de la dependencia",
              ),
              onChanged: (value) {},
            ),
          )
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Agregar'),
          onPressed: () async {
            DependenciaHelper helper = DependenciaHelper();
            String nombreDependencia = _tfNombreDependenciaController.text;
            String descDependencia = _tfDescDependenciaController.text;
            Dependencia? dependencia = await helper.addDependencia(nombreDependencia, descDependencia);
            if (dependencia != null) {
              listaDependencia.add(dependencia);
              ref.read(listaDependenciaProvider.notifier).update((state) => listaDependencia);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dependencia Añadida')));
              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error al agregar o Dependencia ya existente")));
            }
          },
        ),
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}

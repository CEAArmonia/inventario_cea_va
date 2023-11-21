// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/db/db_helpers/dependencia_helper.dart';
import 'package:inventario_cea_va/models/dependencia.dart';
import 'package:inventario_cea_va/presentation/providers/dependencia_provider.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';
import 'package:line_icons/line_icons.dart';

class EditDependecia extends ConsumerWidget {
  final String id;
  EditDependecia(this.id, {Key? key}) : super(key: key);

  final TextEditingController _tfNombreDependenciaController =
      TextEditingController();
  final TextEditingController _tfDescDependenciaController =
      TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text('Editar Dependencia'),
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
          child: const Text('Modificar'),
          onPressed: () async {
            if (_tfNombreDependenciaController.text.isNotEmpty &&
                _tfDescDependenciaController.text.isNotEmpty) {
              DependenciaHelper helper = DependenciaHelper();
              String nombreDependencia = _tfNombreDependenciaController.text;
              String descDependencia = _tfDescDependenciaController.text;
              bool dependencia = await helper.editDependencia(
                  id, nombreDependencia, descDependencia);
              if (dependencia) {
                DependenciaHelper helper = DependenciaHelper();
                List<Dependencia> listaDependencia =
                    await helper.getDependencias('');
                ref
                    .read(listaDependenciaProvider.notifier)
                    .update((state) => listaDependencia);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Dependencia Editada'),
                  ),
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text("Error al Editar o Dependencia ya inexistente"),
                  ),
                );
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Campos Vacios'),
                ),
              );
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

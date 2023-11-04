import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/tipo_item.dart';
import 'package:inventario_cea_va/presentation/providers/item_provider.dart';
import 'package:inventario_cea_va/theme/app_theme.dart';

class DropdownTipoItem extends ConsumerWidget {
  const DropdownTipoItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tiposItem = ref.watch(tiposItemProvider);
    final tipoItemValue = ref.watch(dropdownTipoItemValueProvider);

    return DropdownButton(
      value: tipoItemValue,
      hint: const Text('Tipo'),
      style: GoogleFonts.lato(
        fontSize: 13,
        color: AppTheme.shadowColor,
        fontWeight: FontWeight.bold,
      ),
      iconDisabledColor: AppTheme.primaryColor,
      iconEnabledColor: AppTheme.shadowColor,
      dropdownColor: AppTheme.secondaryColor,
      items: tiposItem.map((TipoItem tipo) {
        return DropdownMenuItem(
          value: tipo.id,
          child: Text(
            tipo.nombre,
            maxLines: 2,
          ),
        );
      }).toList(),
      onChanged: (value) {
        ref
            .read(dropdownTipoItemValueProvider.notifier)
            .update((state) => value);
        itemType = value!;
      },
    );
  }
}

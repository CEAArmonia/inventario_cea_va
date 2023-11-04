import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/presentation/providers/item_provider.dart';

class DateTimePicker {
  Future<void> selectDate(BuildContext context, WidgetRef ref) async {
    final DateTime dateNow = GlobalFunctions.stringToDate(ref.read(fechaActualProvider));
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 1200),
      ),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != dateNow) {
      ref
          .watch(fechaActualProvider.notifier)
          .update((state) => GlobalFunctions.dateToString(picked));
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/global_data/global_functions.dart';
import 'package:inventario_cea_va/models/tipo_item.dart';

final fechaActualProvider = StateProvider<String>(
  (ref) {
    return GlobalFunctions.dateToString(DateTime.now());
  },
);

final dropdownEstadoValueProvider = StateProvider<String?>((ref) {
  return null;
});

final tiposItemProvider = StateProvider<List<TipoItem>>((ref) => []);

final dropdownTipoItemValueProvider = StateProvider.autoDispose<String?>((ref) {
  return null;
});

final tipoItemNombreProvider = StateProvider.autoDispose<String>((ref) => '');

final listaItemsProvider =StateProvider((ref) => []);
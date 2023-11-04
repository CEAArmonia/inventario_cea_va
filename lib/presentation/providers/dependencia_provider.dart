import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/models/dependencia.dart';

final listaDependenciaProvider = StateProvider<List<Dependencia>>((ref) => []);

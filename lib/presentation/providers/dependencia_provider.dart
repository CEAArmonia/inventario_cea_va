import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/models/dependencia.dart';

final listaDependenciaProvider = StateProvider<List<Dependencia>>((ref) => []);

final nombreDependenciaProvider = StateProvider<String>((ref) => '');

final descDependenciaProvider = StateProvider<String>((ref) => '');

final dependenciaProvider = StateProvider<Dependencia?>((ref) => null);


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/models/responsable.dart';

final cedulaAsignacionProvider = StateProvider<String>((ref) => '');

final nombreAsignacionProvider = StateProvider<String>((ref) => '');

final cargoAsignacionProvider = StateProvider<String>((ref) => '');

final telefonoAsignacionProvider = StateProvider<String>((ref) => '');

final cantidadAsignacionProvider = StateProvider<String>((ref) => '0');

final listaResponsableProvider = StateProvider<List<Responsable>>((ref) => []);
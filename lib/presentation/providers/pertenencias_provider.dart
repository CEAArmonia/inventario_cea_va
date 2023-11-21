

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/models/pertenece.dart';

final listaPertenenciasProvider = StateProvider<List<Pertenece>>((ref) => []);
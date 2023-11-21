
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventario_cea_va/models/user.dart';

final listaUsersProvider = StateProvider<List<User>>((ref) => []);

final userDropdownSelected = StateProvider<User?>((ref) => null);
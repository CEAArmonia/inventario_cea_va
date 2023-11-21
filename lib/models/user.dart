import 'package:inventario_cea_va/models/models.dart';

class User {
  String id;
  String nombre;
  String telefono;
  String ci;
  String? password;
  bool administrador;
  bool? activo;
  List<Bitacora>? bitacoras;

  User({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.ci,
    this.password,
    required this.administrador,
    this.activo,
    this.bitacoras
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'ci': ci,
      'administrador': administrador,
      'activo': activo,
      'bitacoras': bitacoras!.map((e) => e.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      ci: json['ci'],
      administrador: json['administrador'],
      activo: json['activo'],
      bitacoras: json['bitacoras'] != null ? List<Bitacora>.from(json["bitacoras"].map((x) => Bitacora.
      fromJson(x))) : [],
    );
  }
}

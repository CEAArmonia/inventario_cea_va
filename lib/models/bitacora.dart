import 'package:inventario_cea_va/models/user.dart';

class Bitacora {
  String id;
  DateTime fecha;
  User? usuario;

  Bitacora({required this.id, required this.fecha, required this.usuario});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'usuario': usuario!.toJson(),
    };
  }

  factory Bitacora.fromJson(Map<String, dynamic> json) {
    return Bitacora(
      id: json['id'],
      fecha: DateTime.parse(json['fecha']),
      usuario: json['usuario'] != null ? User.fromJson(json['usuario']) : null,
    );
  }
}

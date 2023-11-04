
class Bitacora {
  String id;
  DateTime fecha;
  String usuarioId;

  Bitacora({required this.id, required this.fecha, required this.usuarioId});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(),
      'usuario_id': usuarioId
    };
  }

  factory Bitacora.fromJson(Map<String, dynamic> json) {
    return Bitacora(
      id: json['id'],
      fecha: json['fecha'],
      usuarioId: json['usuarioId'],
    );
  }
}

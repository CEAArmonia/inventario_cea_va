import 'package:inventario_cea_va/models/dependencia.dart';
import 'package:inventario_cea_va/models/item.dart';

class Pertenece {
  String id;
  Dependencia dependencia;
  int cantidad;
  DateTime fecha;
  DateTime? fechaRetorno;
  bool retornado;
  Item item;

  Pertenece(
      {required this.id,
      required this.dependencia,
      required this.cantidad,
      required this.fecha,
      this.fechaRetorno,
      required this.retornado,
      required this.item});

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "dependencia": dependencia.toJson(),
      "cantidad": cantidad,
      "fecha": fecha.toIso8601String(),
      "fecha_retorno": fechaRetorno == null ? DateTime(1800) : fechaRetorno!.toIso8601String(),
      "retornado": retornado,
      "item": item.toJson()
    };
  }

  factory Pertenece.fromJson(Map<String, dynamic> json) {
    return Pertenece(
      id: json["id"],
      dependencia: Dependencia.fromJson(json['dependencia']),
      cantidad: json["cantidad"],
      fecha: DateTime.parse(json["fecha"]),
      fechaRetorno: json['fecha_retorno'] != null ? DateTime.parse(json["fecha_retorno"]) : DateTime(1800),
      retornado: json["retornado"],
      item: Item.fromJson(json["item"]),
    );
  }
}

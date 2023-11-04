class TipoItem {
  String id;
  String nombre;

  TipoItem({
    required this.id,
    required this.nombre,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }

  factory TipoItem.fromJson(Map<String, dynamic> json) {
    return TipoItem(
      id: json['id'],
      nombre: json['nombre'],
    );
  }
}

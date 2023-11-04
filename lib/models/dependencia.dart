class Dependencia {
  String id;
  String nombre;
  String desc;

  Dependencia({
    required this.id,
    required this.nombre,
    required this.desc,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      'nombre': nombre,
      'desc': desc,
    };
  }

  factory Dependencia.fromJson(json) {
    return Dependencia(
      id: json['id'],
      nombre: json['nombre'],
      desc: json['desc'],
    );
  }
}

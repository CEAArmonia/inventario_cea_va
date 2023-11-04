class Dependencia {
  String nombre;
  String desc;

  Dependencia({
    required this.nombre,
    required this.desc,
  });

  Map<String, dynamic> toJson() {
    return {
      'nombre': nombre,
      'desc': desc,
    };
  }

  factory Dependencia.fromJson(json) {
    return Dependencia(
      nombre: json['nombre'],
      desc: json['desc'],
    );
  }
}

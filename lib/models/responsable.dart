class Responsable {
  String id;
  String ci;
  String nombre;
  String cargo;
  String telefono;

  Responsable({
    required this.id,
    required this.ci,
    required this.nombre,
    required this.cargo,
    required this.telefono,
  });

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "ci": ci,
      "nombre": nombre,
      "cargo": cargo,
      "telefono": telefono,
    };
  }

  factory Responsable.fromJson(Map<String, dynamic> json) {
    return Responsable(
      id: json["id"],
      ci: json["ci"],
      nombre: json["nombre"],
      cargo: json["cargo"],
      telefono: json["telefono"],
    );
  }
}

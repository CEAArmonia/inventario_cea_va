class User {
  String id;
  String nombre;
  String telefono;
  String ci;
  String? password;

  User({
    required this.id,
    required this.nombre,
    required this.telefono,
    required this.ci,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'telefono': telefono,
      'ci': ci,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nombre: json['nombre'],
      telefono: json['telefono'],
      ci: json['ci'],
    );
  }
}

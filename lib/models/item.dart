class Item {
  String id;
  String nombre;
  DateTime fechaCompra;
  String? desc;
  num valor;
  String? ubicacion;
  String estado;
  int cantidad;
  String? observaciones;
  int tiempoVida;
  String tipo;

  Item({
    required this.id,
    required this.nombre,
    required this.fechaCompra,
    this.desc,
    required this.valor,
    this.ubicacion,
    required this.estado,
    required this.cantidad,
    this.observaciones,
    required this.tiempoVida,
    required this.tipo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'desc': desc ?? '',
      'fechaCompra': fechaCompra.toIso8601String(),
      'valor': valor,
      'ubicacion': ubicacion ?? '',
      'cantidad': cantidad,
      'estado': estado,
      'observaciones': observaciones ?? '',
      'tiempoVida': tiempoVida,
      'tipo': tipo,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      nombre: json['nombre'],
      desc: json['desc'] == null ? '' : json['desc'].toString(),
      fechaCompra: DateTime.parse(json['fechaCompra']),
      valor: json['valor'],
      ubicacion: json['ubicacion'] == null ? '' : json['ubicacion'].toString(),
      cantidad: json['cantidad'],
      estado: json['estado'] ? 'Activo' : 'Inactivo',
      observaciones:
          json["obs"] == null ? '' : json["obs"].toString(),
      tiempoVida: json['tiempoVida'],
      tipo: json['tipo']['id'],
    );
  }
}

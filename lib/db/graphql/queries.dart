
String getTiposItemGql = r"""query ObtenerTiposItem {
  obtenerTiposItem {
    id
    nombre
  }
}""";

String getItemsGql = r"""query ObtenerItems {
  obtenerItems {
    id
    codigo
    nombre
    desc
    cantidad
    fechaCompra
    valor
    ubicacion
    estado
    obs
    tiempoVida
    mantenimientos
    tipo {
      id
      nombre
    }
  }
}""";

String getItemsByNameGql = r"""
query ObtenerItemsPorNombre($nombre: String) {
  obtenerItemsPorNombre(nombre: $nombre) {
    id
    codigo
    nombre
    desc
    cantidad
    fechaCompra
    valor
    ubicacion
    estado
    obs
    tiempoVida
    mantenimientos
    tipo {
      id
      nombre
    }
  }
}""";

String getDependenciasByNameGql = r"""query ObtenerDependencias($nombre: String) {
  obtenerDependencias(nombre: $nombre) {
    id
    nombre
    desc
  }
}""";
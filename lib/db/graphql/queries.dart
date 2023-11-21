
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

String getItemByIdGql = r"""query ObtenerItemPorId($obtenerItemPorIdId: ID) {
  obtenerItemPorId(id: $obtenerItemPorIdId) {
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

String getPertenenciasGql = r"""query ObtenerPertenencias($obtenerPertenenciasId: ID) {
  obtenerPertenencias(id: $obtenerPertenenciasId) {
    id
    cantidad
    fecha
    fecha_retorno
    retornado
    item {
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
    dependencia {
      id
      nombre
      desc
    }
  }
}""";

String getDependenciaPorIdGql = r"""query ObtenerDependenciaPorId($obtenerDependenciaPorIdId: ID) {
  obtenerDependenciaPorId(id: $obtenerDependenciaPorIdId) {
    id
    nombre
    desc
  }
}""";

String getResponsablesGql = r"""query ObtenerResponsables {
  obtenerResponsables {
    id
    nombre
    ci
    cargo
    telefono
  }
}""";

String getResponsablesPorCiGql = r"""query ObtenerResponsablesPorCi($ci: String) {
  obtenerResponsablesPorCi(ci: $ci) {
    id
    nombre
    ci
    cargo
    telefono
  }
}""";

String getBitacorasGql = r"""query ObtenerBitacoras {
  obtenerBitacoras {
    id
    fecha
    usuario {
      id
      nombre
      telefono
      ci
      password
      administrador
    }
  }
}""";

String getUsersGql = r"""query ObtenerUsuarios {
  obtenerUsuarios {
    id
    nombre
    telefono
    ci
    password
    administrador
    activo
    bitacoras {
      id
      fecha
    }
  }
}""";

String getBitacorasByUserGql = r"""query ObtenerBitacorasPorUsuario($usuarioId: ID) {
  obtenerBitacorasPorUsuario(usuarioId: $usuarioId) {
    id
    fecha
    usuario {
      id
      nombre
      telefono
      ci
      password
      administrador
      activo
    }
  }
}""";

String getCantidadesBajasGql = r"""query ObtenerItemsCantidad {
  obtenerItemsCantidad {
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
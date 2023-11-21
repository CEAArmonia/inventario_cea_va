
String loginUsuarioGql = r"""mutation LoguearUsuario($input: LoguearUsuarioInput) {
  loguearUsuario(input: $input)
}""";

String addTipoItemGql = r"""mutation AgregarTipoItem($nombre: String) {
  agregarTipoItem(nombre: $nombre) {
    id
    nombre  
  }
}""";

String deleteTipoItemGql = r"""mutation EliminarTipoItem($eliminarTipoItemId: String) {
  eliminarTipoItem(id: $eliminarTipoItemId) {
    id
    nombre
  }
}""";

String addItemGql = r"""mutation AgregarItem($input: ItemInput) {
  agregarItem(input: $input) {
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

String addMaintenanceGql = r"""mutation AgregarMantenimiento($agregarMantenimientoId: ID, $fecha: Date) {
  agregarMantenimiento(id: $agregarMantenimientoId, fecha: $fecha)
}""";

String addDependencyGql = r"""mutation AgregarDependencias($input: DependenciaInput) {
  agregarDependencias(input: $input) {
    id
    nombre
    desc
  }
}""";

String editDependenciaGql = r"""mutation EditarDependencia($editarDependenciaId: ID, $input: DependenciaInput) {
  editarDependencia(id: $editarDependenciaId, input: $input)
}""";

String removeDependecyGql = r"""mutation EliminarDependecia($eliminarDependeciaId: ID) {
  eliminarDependecia(id: $eliminarDependeciaId) {
    id
    nombre
    desc
  }
}""";

String addPertenenciaGql = r"""mutation AsignarPertenencia($itemId: ID, $dependenciaId: ID, $cantidad: Int) {
  asignarPertenencia(itemId: $itemId, dependenciaId: $dependenciaId, cantidad: $cantidad) {
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
  }
}""";

String returnPertenenciaGql = r"""mutation RetornoPertenencia($pertenenciaId: ID) {
  retornoPertenencia(pertenenciaId: $pertenenciaId) {
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

String agregarCantidadesItemGql = r"""mutation AgregarCantidadesItem($itemId: ID, $cantidad: Int) {
  agregarCantidadesItem(itemId: $itemId, cantidad: $cantidad) {
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

String asignarItemResponsableGql = r"""mutation AsignarItemResponsable($input: AsignarItemResponsableInput) {
  asignarItemResponsable(input: $input)
}""";

String editarUsuarioGql = r"""mutation EditarUsuario($input: RegistroUsuarioInput) {
  editarUsuario(input: $input) {
    id
    nombre
    telefono
    ci
    administrador
    activo
  }
}""";

String agregarUsuarioGql = r"""mutation AgregarUsuario($input: RegistroUsuarioInput) {
  agregarUsuario(input: $input) {
    id
    nombre
    telefono
    ci
    password
    administrador
    activo
  }
}""";
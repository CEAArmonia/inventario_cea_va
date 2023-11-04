
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
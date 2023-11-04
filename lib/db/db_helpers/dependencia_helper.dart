import 'dart:ffi';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventario_cea_va/db/config/server_connection.dart';
import 'package:inventario_cea_va/db/graphql/mutations.dart';
import 'package:inventario_cea_va/db/graphql/queries.dart';
import 'package:inventario_cea_va/models/dependencia.dart';

class DependenciaHelper {
  final GraphQLClient _client = ConectarGraphQL().client().value;

  Future<List<Dependencia>> getDependencias(String name) async {
    QueryOptions options = QueryOptions(
      document: gql(getDependenciasByNameGql),
      variables: {"nombre": name},
    );
    var result = await _client.query(options);
    var listaDependencias = result.data!['obtenerDependencias'];
    List<Dependencia> dependencias = [];
    for (var dependencia in listaDependencias) {
      dependencias.add(Dependencia.fromJson(dependencia));
    }
    return dependencias;
  }

  Future<Dependencia?> addDependencia(String name, String desc) async {
    MutationOptions options = MutationOptions(
      document: gql(addDependencyGql),
      variables: {
        "input": {
          "desc": desc,
          "nombre": name,
        }
      },
    );
    var result = await _client.mutate(options);
    var response = result.data!['agregarDependencias'];
    if (response != null) {
      return Dependencia.fromJson(response);
    }
    return null;
  }

  Future<bool> editDependencia(String id, String nombre, String desc) async {
    MutationOptions options = MutationOptions(
      document: gql(editDependenciaGql),
      variables: {
        "editarDependenciaId": id,
        "input": {
          "desc": desc,
          "nombre": nombre,
        }
      },
    );
    var result = await _client.mutate(options);
    bool response = result.data!['editarDependencia'];
    return response;
  }

  Future<Dependencia?> removeDependency(String id) async {
    MutationOptions options = MutationOptions(
      document: gql(removeDependecyGql),
      variables: {
        "eliminarDependeciaId": id,
      },
    );
    var result = await _client.mutate(options);
    var response = result.data!['eliminarDependecia'];
    if (response != null) {
      return Dependencia.fromJson(response);
    }
    return null;
  }
}

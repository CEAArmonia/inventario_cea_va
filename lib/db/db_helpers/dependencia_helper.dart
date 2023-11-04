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
      document: gql(addDependency),
      variables: {
        "input": {
          "desc": desc,
          "nombre": name,
        }
      },
    );
    var result = await _client.mutate(options);
    var response = result.data!['agregarDependencias'];
    if(response != null){
      return Dependencia.fromJson(response);
    }
    return null;
  }
}

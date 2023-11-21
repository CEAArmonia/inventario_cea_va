
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventario_cea_va/db/config/server_connection.dart';
import 'package:inventario_cea_va/db/graphql/mutations.dart';
import 'package:inventario_cea_va/db/graphql/queries.dart';
import 'package:inventario_cea_va/models/pertenece.dart';

class PertenenciaHelper {
  final GraphQLClient _client = ConectarGraphQL().client().value;

  Future<List<Pertenece>> getPertenencias(String id) async {
    QueryOptions options = QueryOptions(
      document: gql(getPertenenciasGql),
      variables: {"obtenerPertenenciasId": id},
    );
    var result = await _client.query(options);
    List response = result.data!['obtenerPertenencias'];
    List<Pertenece> pertenencias = response.map(
      (data) {
        return Pertenece.fromJson(data); 
      },
    ).toList();
    return pertenencias;
  }

  Future<Pertenece> addPertenencia(
      String itemId, String dependenciaId, int cantidad) async {
    MutationOptions options = MutationOptions(
      document: gql(addPertenenciaGql),
      variables: {
        "cantidad": cantidad,
        "itemId": itemId,
        "dependenciaId": dependenciaId
      },
    );
    var result = await _client.mutate(options);
    Pertenece pertenencia = Pertenece.fromJson(result.data!['asignarPertenencia']);
    return pertenencia;
  }

  Future<Pertenece> retornarPertenencia (Pertenece pertenece) async {
    MutationOptions options = MutationOptions(
      document: gql(returnPertenenciaGql),
      variables: {"pertenenciaId": pertenece.id}
    );
    var result = await _client.mutate(options);
    Pertenece pertenencia = Pertenece.fromJson(result.data!['retornoPertenencia']);
    return pertenencia;
  }
  
}

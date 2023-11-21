import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventario_cea_va/db/config/server_connection.dart';
import 'package:inventario_cea_va/db/graphql/mutations.dart';
import 'package:inventario_cea_va/db/graphql/queries.dart';
import 'package:inventario_cea_va/models/models.dart';

class ResponsableHelper {
  final GraphQLClient _client = ConectarGraphQL().client().value;

  Future<List<Responsable>> getResponsablesPorCi(String ci) async {
    MutationOptions options = MutationOptions(
      document: gql(getResponsablesPorCiGql),
      variables: {"ci": ci},
    );

    var response = await _client.mutate(options);
    var result = response.data!['obtenerResponsablesPorCi'];
    List<Responsable> responsables = [];
    for (var item in result) {
      responsables.add(Responsable.fromJson(item));
    }
    return responsables;
  }

  Future<List<Responsable>> getResponsables() async {
    MutationOptions options = MutationOptions(
      document: gql(getResponsablesGql),
    );

    var response = await _client.mutate(options);
    var result = response.data!['obtenerResponsables'];
    List<Responsable> responsables = [];
    for (var item in result) {
      responsables.add(Responsable.fromJson(item));
    }
    return responsables;
  }

  Future<bool> asignarItemResponsable(String ci, String nombre, String cargo,
      String itemId, String tel, int cantidad) async {
    MutationOptions options = MutationOptions(
      document: gql(asignarItemResponsableGql),
      variables: {
        "input": {
          "cantidad": cantidad,
          "cargo": cargo,
          "ci": ci,
          "itemId": itemId,
          "nombre": nombre,
          "telefono": tel
        }
      },
    );

    var result = await _client.mutate(options);
    bool response = result.data!['asignarItemResponsable'];
    return response;
  }
}

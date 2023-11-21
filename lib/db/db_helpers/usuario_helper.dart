import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventario_cea_va/db/config/server_connection.dart';
import 'package:inventario_cea_va/db/graphql/mutations.dart';
import 'package:inventario_cea_va/db/graphql/queries.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:inventario_cea_va/models/models.dart';

class UsuarioHelper {
  final GraphQLClient _client = ConectarGraphQL().client().value;

  Future<User> editarUsuario(
      String nombre, String tel, String ci, String? pass, bool admin) async {
    MutationOptions options = MutationOptions(
      document: gql(editarUsuarioGql),
      variables: {
        "input": {
          "administrador": admin,
          "ci": ci,
          "nombre": nombre,
          "password": pass,
          "telefono": tel,
        }
      },
    );

    var result = await _client.mutate(options);
    var response = result.data!['editarUsuario'];
    return usuarioLogueado = User.fromJson(response);
  }

  Future<User?> agregarUsuario(
      String nombre, String tel, String ci, String? pass, bool admin) async {
    MutationOptions options =
        MutationOptions(document: gql(agregarUsuarioGql), variables: {
      "input": {
        "administrador": admin,
        "ci": ci,
        "nombre": nombre,
        "password": pass,
        "telefono": tel
      }
    });

    var result = await _client.mutate(options);
    var response = result.data!["agregarUsuario"];
    if (response != null) {
      return User.fromJson(response);
    } else {
      return response;
    }
  }

  Future<List<Bitacora>> getBitacoras() async {
    QueryOptions options = QueryOptions(document: gql(getBitacorasGql));

    var result = await _client.query(options);
    var response = result.data!['obtenerBitacoras'];
    List<Bitacora> lista = [];
    for (var bitacora in response) {
      lista.add(Bitacora.fromJson(bitacora));
    }
    return lista;
  }

  Future<List<Bitacora>> getBitacorasByUser(String userId) async {
    QueryOptions options = QueryOptions(
      document: gql(getBitacorasByUserGql),
      variables: {"usuarioId": userId},
    );

    var result = await _client.query(options);
    var response = result.data!['obtenerBitacorasPorUsuario'];
    List<Bitacora> lista = [];
    if (response != [] && response != null) {
      for (var bitacora in response) {
        lista.add(Bitacora.fromJson(bitacora));
      }
      return lista;
    }
    return lista;
  }

  Future<List<User>> getUsers() async {
    QueryOptions options = QueryOptions(document: gql(getUsersGql));

    var result = await _client.query(options);
    var response = result.data!['obtenerUsuarios'];
    List<User> lista = [];
    for (var user in response) {
      lista.add(User.fromJson(user));
    }
    return lista;
  }
}

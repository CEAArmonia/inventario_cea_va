import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventario_cea_va/db/config/server_connection.dart';
import 'package:inventario_cea_va/db/graphql/mutations.dart';
import 'package:inventario_cea_va/models/user.dart';
import 'package:inventario_cea_va/global_data/global_variables.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginHelper {
  final GraphQLClient _client = ConectarGraphQL().client().value;

  Future<bool> loginUsuario(String ci, String password) async {
    MutationOptions options = MutationOptions(
      document: gql(loginUsuarioGql),
      variables: {
        "input": {
          "ci": ci,
          "password": password,
        }
      },
    );

    var result = await _client.mutate(options);

    if(result.hasException){
      return false;
    } else {
      jwtUsuarioConectado = result.data!['loguearUsuario'];
      var jwt = JwtDecoder.decode(jwtUsuarioConectado);
      usuarioLogueado = User.fromJson(jwt['usuario']);
      return true;
    }
  }

  String jwtDecodificado(String jwt){
    var result = JwtDecoder.decode(jwt);
    return result['usuario']['nombre'];
  }
}

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:inventario_cea_va/db/config/server_connection.dart';
import 'package:inventario_cea_va/db/graphql/mutations.dart';
import 'package:inventario_cea_va/db/graphql/queries.dart';
import 'package:inventario_cea_va/models/item.dart';
import 'package:inventario_cea_va/models/tipo_item.dart';

class ItemHelper {
  final GraphQLClient _client = ConectarGraphQL().client().value;

  Future<List<Item>> getItems() async {
    List<Item> listaItems = [];
    QueryOptions options = QueryOptions(document: gql(getItemsGql));

    var result = await _client.query(options);
    var items = result.data!['obtenerItems'];
    for (var item in items) {
      listaItems.add(Item.fromJson(item));
    }
    return listaItems;
  }

  Future<List<Item>> getItemsByName(String name) async {
    List<Item> listaItems = [];
    QueryOptions options = QueryOptions(
      document: gql(getItemsByNameGql),
      variables: {"nombre": name},
    );

    var result = await _client.query(options);
    var items = result.data!['obtenerItemsPorNombre'];
    for (var item in items) {
      listaItems.add(Item.fromJson(item));
    }
    return listaItems;
  }

  Future<List<TipoItem>> getTiposItem() async {
    List<TipoItem> listaTipos = [];
    QueryOptions options = QueryOptions(
      document: gql(getTiposItemGql),
    );

    var result = await _client.query(options);

    if (result.hasException) {
      return listaTipos;
    } else {
      var listaTiposAux = result.data!['obtenerTiposItem'];
      for (var item in listaTiposAux) {
        listaTipos.add(TipoItem.fromJson(item));
      }
      return listaTipos;
    }
  }

  Future<TipoItem> addTipoItem(String nombre) async {
    MutationOptions options = MutationOptions(
      document: gql(addTipoItemGql),
      variables: {"nombre": nombre},
    );

    var result = await _client.mutate(options);
    var tipoItem = result.data!['agregarTipoItem'];
    return TipoItem.fromJson(tipoItem);
  }

  Future<TipoItem> deleteTipoItem(String id) async {
    MutationOptions options = MutationOptions(
      document: gql(deleteTipoItemGql),
      variables: {"eliminarTipoItemId": id},
    );

    var result = await _client.mutate(options);
    var tipoItem = result.data!['eliminarTipoItem'];
    return TipoItem.fromJson(tipoItem);
  }

  Future<Item> addItem(
      String itemName,
      String itemDesc,
      String itemObs,
      String itemLocation,
      double itemValue,
      int itemLife,
      int itemMaintenance,
      int itemQuantity,
      String itemState,
      String itemType,
      DateTime buyDate) async {
    MutationOptions options = MutationOptions(
      document: gql(addItemGql),
      variables: {
        "input": {
          "codigo": null,
          "desc": itemDesc,
          "estado": itemState,
          "fechaCompra": buyDate.toIso8601String(),
          "nombre": itemName,
          "obs": itemObs,
          "tiempoVida": itemLife,
          "tipo": itemType,
          "ubicacion": itemLocation,
          "valor": itemValue,
          "cantidad": itemQuantity
        }
      },
    );
    var result = await _client.mutate(options);
    var itemJson = result.data!['agregarItem'];
    return Item.fromJson(itemJson);
  }

  void assignMaintenance(
      DateTime buyDate, int months, int life, String idItem) async {
    if (months != 0 && life != 0) {
      List<DateTime> maintenanceDates = [];
      DateTime maintenance = buyDate;
      DateTime endDate =
          DateTime(buyDate.year + life, buyDate.month, buyDate.day);
      while (maintenance.isBefore(endDate)) {
        maintenance = DateTime(
            maintenance.year, maintenance.month + months, maintenance.day);
        maintenanceDates.add(maintenance);
      }
      for (var date in maintenanceDates) {
        MutationOptions options = MutationOptions(
          document: gql(addMaintenance),
          variables: {
            "agregarMantenimientoId": idItem,
            "fecha": date.toIso8601String()
          },
        );
        await _client.mutate(options);
      }
    }
  }
}

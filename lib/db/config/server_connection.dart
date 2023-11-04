import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ConectarGraphQL {
  final HttpLink httpLink = HttpLink('https://5l9vp1qc-3000.brs.devtunnels.ms/graphql');
  final WebSocketLink webSocket =
      WebSocketLink('ws://5l9vp1qc-3000.brs.devtunnels.ms/graphql');

  ValueNotifier<GraphQLClient> client() {
    return ValueNotifier(
      GraphQLClient(
        link: httpLink.concat(webSocket),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
  }
}

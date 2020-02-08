import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'routes.dart';

void main() => runApp(MyApp());

final httpLink = HttpLink(uri: "https://countries.trevorblades.com/");

ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    cache: InMemoryCache(),
    link: httpLink,
  ),
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: "GQL App",
        onGenerateRoute: generateRoutes,
        initialRoute: '/',
      ),
    );
  }
}

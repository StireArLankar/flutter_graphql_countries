import 'package:flutter/material.dart';

import 'country_list.dart';
import 'continents_list.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => ContinensList());
    case 'countries':
      return MaterialPageRoute(builder: (_) => CountryList(settings.arguments));
    default:
      return MaterialPageRoute(builder: (_) => DefaultScreen(settings.name));
  }
}

class DefaultScreen extends StatelessWidget {
  final String name;

  DefaultScreen(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('No route defined for $name'),
      ),
      appBar: AppBar(),
    );
  }
}

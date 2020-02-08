import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const continents = r"""
  query getContinents{
    continents {
      name
      code
    }
  }
""";

class ContinensList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Continents List"),
      ),
      body: Query(
        options: QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          documentNode: gql(continents),
        ),
        builder: (result, {fetchMore, refetch}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Continents not found.',
                    style: TextStyle(fontSize: 40),
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text(
                      'Try again!',
                      style: TextStyle(fontSize: 40),
                    ),
                    onPressed: refetch,
                  )
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: result.data['continents'].length,
            itemBuilder: (BuildContext context, int index) {
              final continent = result.data['continents'][index];
              final code = continent['code'].toString();

              return ListTile(
                title: Text(
                  'Continent name: ${continent['name']}',
                ),
                subtitle: Text(
                  'Continent code: ${continent['code']}',
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    'countries',
                    arguments: code,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'country.model.dart';

const query = r"""
  query GetContinent($code : String!){
    continent(code:$code){
      name
      countries{
        code
        name
        currency
        emoji
      }
    }
  }
""";

class CountryList extends StatelessWidget {
  final String code;

  CountryList(this.code);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Countries List"),
      ),
      body: Query(
        options: QueryOptions(
          fetchPolicy: FetchPolicy.cacheFirst,
          documentNode: gql(query),
          variables: {"code": code},
        ),
        builder: (result, {refetch, fetchMore}) {
          if (result.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (result.data == null) {
            return Center(
              child: Column(
                children: <Widget>[
                  Text('Countries not found.'),
                  RaisedButton(
                    child: Text('Try again!'),
                    onPressed: refetch,
                  )
                ],
              ),
            );
          }

          return _countriesView(result);
        },
      ),
    );
  }

  ListView _countriesView(QueryResult result) {
    final countryList = result.data['continent']['countries'];

    return ListView.separated(
      itemCount: countryList.length,
      itemBuilder: (context, index) {
        final country = Country.fromJson(countryList[index]);
        return ListTile(
          title: Text(country.name),
          subtitle: Text('Currency: ${country.currency}'),
          leading: CircleAvatar(
            radius: 40,
            child: Text(
              country.emoji,
              style: TextStyle(fontSize: 30),
            ),
            backgroundColor: Colors.black12,
          ),
          onTap: () {
            final snackBar = SnackBar(
              content: Text('Selected Country: ${country.name}'),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          },
        );
      },
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.cyanAccent,
          thickness: 4,
        );
      },
    );
  }
}

import 'package:country_list_app/data/model.dart';
import 'package:country_list_app/view/country_detail_page.dart';
import 'package:flutter/material.dart';

class SearchDlgte extends SearchDelegate<String> {
  final List<Country> countries;

  SearchDlgte(this.countries);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults(context);
  }

  Widget _buildSearchResults(BuildContext context) {
    final List<Country> results = query.isEmpty
        ? countries
        : countries
            .where((country) =>
                country.name.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final country = results[index];
        return ListTile(
          title: Text(country.name),
          subtitle: Text('Capital: ${country.capitals.join(', ')}'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CountryDetailScreen(country),
              ),
            );
          },
        );
      },
    );
  }
}

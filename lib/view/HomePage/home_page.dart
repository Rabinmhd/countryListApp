import 'package:country_list_app/data/model.dart';
import 'package:country_list_app/provider/home_provider.dart';
import 'package:country_list_app/tools/searchDelegate.dart';
import 'package:country_list_app/view/country_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countryProvider = Provider.of<CountryProvider>(context);
    countryProvider.fetchAndSetCountries();

    // Get unique continent names
    List<String> continentNames =
        countryProvider.countries.map((e) => e.region).toSet().toList();

    // Filtered list of countries based on search query
    List<Country> filteredCountries = countryProvider.countries;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String? selected = await showSearch<String>(
                context: context,
                delegate: SearchDlgte(filteredCountries),
              );
              if (selected != null && selected.isNotEmpty) {
                // Perform search and update the filteredCountries list
                filteredCountries = countryProvider.countries
                    .where((country) => country.name
                        .toLowerCase()
                        .contains(selected.toLowerCase()))
                    .toList();
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: continentNames.length,
        itemBuilder: (context, index) {
          final continent = continentNames[index];
          final continentCountries =
              filteredCountries.where((c) => c.region == continent).toList();
          return ExpansionTile(
            title: Text(
              continent,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            children: continentCountries.map((country) {
              return ListTile(
                leading: Image.network(country.flag, width: 50, height: 30),
                title: Text(country.name),
                subtitle: Text('Capital: ${country.capitals.join(', ')}'),
                trailing: Text('Population: ${country.population.toString()}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CountryDetailScreen(country)),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

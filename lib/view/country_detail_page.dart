import 'package:country_list_app/data/model.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  final Country country;

  const CountryDetailScreen(this.country, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Image.network(country.flag,
                  width: 200, height: 120, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            _buildDetailRow('Name', country.name),
            _buildDetailRow('Population', country.population.toString()),
            _buildDetailRow('Region', country.region),
            _buildDetailRow('Subregion', country.subregion),
            _buildDetailRow('Capital', country.capitals.join(', ')),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

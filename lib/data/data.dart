import 'dart:convert';

import 'package:country_list_app/data/model.dart';
import 'package:http/http.dart' as http;

Future<List<Country>> fetchCountries() async {
  final response =
      await http.get(Uri.parse('https://restcountries.com/v3.1/all'));
  if (response.statusCode == 200) {
    //print(response.body);
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((json) {
      return Country(
        name: json['name']['common'] ?? "",
        capitals: List<String>.from(json['capital'] ?? []),
        population: json['population'] ?? "",
        region: json['region'] ?? "",
        subregion: json['subregion'] ?? "",
        flag: json['flags']['png'] ?? "",
      );
    }).toList();
  } else {
    throw Exception('Failed to load countries');
  }
}

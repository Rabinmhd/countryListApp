import 'package:country_list_app/data/data.dart';
import 'package:country_list_app/data/model.dart';
import 'package:flutter/material.dart';

class CountryProvider extends ChangeNotifier {
  List<Country> _countries = [];

  List<Country> get countries => _countries;

  void fetchAndSetCountries() async {
    try {
      _countries = await fetchCountries();
      notifyListeners();
    } catch (error) {
      print('Error fetching countries: $error');
    }
  }
}

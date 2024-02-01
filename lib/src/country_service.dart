import 'package:collection/collection.dart';
import 'package:flutter_country_picker/src/country_model.dart';
import 'package:flutter_country_picker/src/res/country_codes.dart';

class CountryService {
  CountryService()
      : _countries = countryCodes.map((c) => Country.fromJson(c)).toList();

  final List<Country> _countries;

  /// Return list with all countries
  List<Country> getAll() => _countries;

  /// Returns the first country that mach the given code.
  Country? findByCode(String? code) {
    final uppercaseCode = code?.toUpperCase();
    return _countries.firstWhereOrNull((c) => c.countryCode == uppercaseCode);
  }

  /// Returns the first country that mach the given name.
  Country? findByName(String? name) =>
      _countries.firstWhereOrNull((c) => c.name == name);

  /// Returns a list with all the countries that mach the given codes list.
  List<Country> findCountriesByCode(List<String> codes) {
    final List<String> codes0 = codes.map((c) => c.toUpperCase()).toList();
    final List<Country> countries = [];

    for (final code in codes0) {
      final Country? country = findByCode(code);
      if (country != null) {
        countries.add(country);
      }
    }

    return countries;
  }
}

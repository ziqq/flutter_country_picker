import 'package:flutter/material.dart';

import 'country_localizations.dart';
import 'country_parser.dart';
import 'helpers/utils.dart';

///The country Model that has all the country
///information needed from the [country_picker]
@immutable
class Country {
  static const Country worldWide = Country(
    phoneCode: '',
    countryCode: 'WW',
    e164Sc: -1,
    geographic: false,
    level: -1,
    name: 'World Wide',
    example: '',
    displayName: 'World Wide (WW)',
    displayNameNoCountryCode: 'World Wide',
    e164Key: '',
  );

  ///The country phone code
  final String phoneCode;

  ///The country code, ISO (alpha-2)
  final String countryCode;
  final int e164Sc;
  final bool geographic;
  final int level;

  /// The country name in English
  final String name;

  /// The country name localized
  final String? nameLocalized;

  /// An example of a telephone number without the phone code
  final String example;

  /// Country name (country code) [phone code]
  final String displayName;

  /// An example of a telephone number with the phone code and plus sign
  final String? fullExampleWithPlusSign;

  /// Country name (country code)
  final String displayNameNoCountryCode;
  final String e164Key;

  @Deprecated(
    'The modern term is displayNameNoCountryCode. '
    'This feature was deprecated after v1.0.6.',
  )
  String get displayNameNoE164Cc => displayNameNoCountryCode;

  String? getTranslatedName(BuildContext context) {
    return CountryLocalizations.of(context)
        ?.countryName(countryCode: countryCode);
  }

  const Country({
    required this.phoneCode,
    required this.countryCode,
    required this.e164Sc,
    required this.geographic,
    required this.level,
    required this.name,
    required this.example,
    required this.displayName,
    required this.displayNameNoCountryCode,
    required this.e164Key,
    this.nameLocalized = '',
    this.fullExampleWithPlusSign,
  });

  Country copyWith({
    String? phoneCode,
    String? countryCode,
    int? e164Sc,
    String? e164Key,
    bool? geographic,
    int? level,
    String? name,
    String? nameLocalized,
    String? example,
    String? displayName,
    String? fullExampleWithPlusSign,
    String? displayNameNoCountryCode,
  }) {
    return Country(
      phoneCode: phoneCode ?? this.phoneCode,
      countryCode: countryCode ?? this.countryCode,
      e164Sc: e164Sc ?? this.e164Sc,
      e164Key: e164Key ?? this.e164Key,
      geographic: geographic ?? this.geographic,
      level: level ?? this.level,
      name: name ?? this.name,
      nameLocalized: nameLocalized ?? this.nameLocalized,
      example: example ?? this.example,
      displayName: displayName ?? this.displayName,
      fullExampleWithPlusSign:
          fullExampleWithPlusSign ?? this.fullExampleWithPlusSign,
      displayNameNoCountryCode:
          displayNameNoCountryCode ?? this.displayNameNoCountryCode,
    );
  }

  Country.from({required Map<String, dynamic> json})
      : phoneCode = json['e164_cc'] as String,
        countryCode = json['iso2_cc'] as String,
        e164Sc = json['e164_sc'] as int,
        geographic = json['geographic'] as bool,
        level = json['level'] as int,
        name = json['name'] as String,
        nameLocalized = '',
        example = json['example'] as String,
        displayName = json['display_name'] as String,
        fullExampleWithPlusSign =
            json['full_example_with_plus_sign'] as String?,
        displayNameNoCountryCode = json['display_name_no_e164_cc'] as String,
        e164Key = json['e164_key'] as String;

  static Country parse(String country) {
    if (country == worldWide.countryCode) {
      return worldWide;
    } else {
      return CountryParser.parse(country);
    }
  }

  static Country? tryParse(String country) {
    if (country == worldWide.countryCode) {
      return worldWide;
    } else {
      return CountryParser.tryParse(country);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['e164_cc'] = phoneCode;
    data['iso2_cc'] = countryCode;
    data['e164_sc'] = e164Sc;
    data['geographic'] = geographic;
    data['level'] = level;
    data['name'] = name;
    data['example'] = example;
    data['display_name'] = displayName;
    data['full_example_with_plus_sign'] = fullExampleWithPlusSign;
    data['display_name_no_e164_cc'] = displayNameNoCountryCode;
    data['e164_key'] = e164Key;
    return data;
  }

  bool startsWith(String query, CountryLocalizations? localizations) {
    // ignore: no_leading_underscores_for_local_identifiers
    String _query = query;

    if (query.startsWith('+')) {
      _query = query.replaceAll('+', '').trim();
    }
    return phoneCode.startsWith(_query.toLowerCase()) ||
        name.toLowerCase().startsWith(_query.toLowerCase()) ||
        countryCode.toLowerCase().startsWith(_query.toLowerCase()) ||
        (localizations
                ?.countryName(countryCode: countryCode)
                ?.toLowerCase()
                .startsWith(_query.toLowerCase()) ??
            false);
  }

  bool get iswWorldWide => countryCode == Country.worldWide.countryCode;

  @override
  String toString() =>
      'Country(countryCode: $countryCode, name: $name, nameLocalized: $nameLocalized, phoneCode: $phoneCode)';

  @override
  bool operator ==(Object other) {
    if (other is Country) {
      return other.countryCode == countryCode && other.phoneCode == phoneCode;
    }

    return super == other;
  }

  @override
  int get hashCode => countryCode.hashCode ^ phoneCode.hashCode;

  /// provides country flag as emoji.
  /// Can be displayed using
  ///
  ///```Text(country.flagEmoji)```
  String get flagEmoji => Utils.countryCodeToEmoji(countryCode);
}

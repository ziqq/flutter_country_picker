import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:grouped_list/grouped_list.dart';

import 'country.dart';
import 'country_list_theme_data.dart';
import 'country_localizations.dart';
import 'country_service.dart';
import 'res/country_codes.dart';
import 'helpers/utils.dart';

const _kDefaultTextStyle = TextStyle(fontSize: 16);

class CountryListView extends StatefulWidget {
  /// Called when a country is select.
  ///
  /// The country picker passes the new value to the callback.
  final ValueChanged<Country> onSelect;

  /// An optional [showPhoneCode] argument can be used to show phone code.
  final bool showPhoneCode;

  /// An optional [exclude] argument can be used to exclude(remove) one ore more
  /// country from the countries list. It takes a list of country code(iso2).
  /// Note: Can't provide both [exclude] and [countryFilter]
  final List<String>? exclude;

  /// An optional [countryFilter] argument can be used to filter the
  /// list of countries. It takes a list of country code(iso2).
  /// Note: Can't provide both [countryFilter] and [exclude]
  final List<String>? countryFilter;

  /// An optional [favorite] argument can be used to show countries
  /// at the top of the list. It takes a list of country code(iso2).
  final List<String>? favorite;

  /// An optional argument for customizing the
  /// country list bottom sheet.
  final CountryListThemeData? countryListTheme;

  /// An optional argument for initially expanding virtual keyboard
  final bool searchAutofocus;

  /// An optional argument for showing "World Wide" option at the beginning of the list
  final bool showWorldWide;

  /// An optional argument for hiding the search bar
  final bool showSearch;

  const CountryListView({
    Key? key,
    required this.onSelect,
    this.exclude,
    this.favorite,
    this.countryFilter,
    this.showPhoneCode = false,
    this.countryListTheme,
    this.searchAutofocus = false,
    this.showWorldWide = false,
    this.showSearch = true,
  })  : assert(
          exclude == null || countryFilter == null,
          'Cannot provide both exclude and countryFilter',
        ),
        super(key: key);

  @override
  State<CountryListView> createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  final CountryService _countryService = CountryService();

  late bool _searchAutofocus;
  late List<Country> _countryList;
  late List<Country> _filteredList;
  late TextEditingController _searchController;

  // List<Country>? _favoriteList;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _countryList = _countryService.getAll();

    _countryList = countryCodes.map((c) => Country.from(json: c)).toList();

    // Remove duplicates country if not use phone code
    if (!widget.showPhoneCode) {
      final ids = _countryList.map((e) => e.countryCode).toSet();
      _countryList.retainWhere((country) => ids.remove(country.countryCode));
    }

    // if (widget.favorite != null) {
    //   _favoriteList = _countryService.findCountriesByCode(widget.favorite!);
    // }

    if (widget.exclude != null) {
      _countryList.removeWhere(
        (element) => widget.exclude!.contains(element.countryCode),
      );
    }

    if (widget.countryFilter != null) {
      _countryList.removeWhere(
        (element) => !widget.countryFilter!.contains(element.countryCode),
      );
    }

    _filteredList = <Country>[];

    if (widget.showWorldWide) {
      _filteredList.add(Country.worldWide);
    }

    _filteredList.addAll(_countryList);

    _searchAutofocus = widget.searchAutofocus;
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CountryLocalizations? t = CountryLocalizations.of(context);

    final String searchPlaceholder =
        t?.countryName(countryCode: 'search') ?? 'Поиск';
    final String cancelButtonText =
        t?.countryName(countryCode: 'cancel') ?? 'Отмена';

    final Color stickyHeaderBackgroundColor = CupertinoDynamicColor.resolve(
      CupertinoColors.secondarySystemBackground,
      context,
    );

    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: widget.countryListTheme?.borderRadius?.topLeft ??
            const Radius.circular(10),
        topRight: widget.countryListTheme?.borderRadius?.topRight ??
            const Radius.circular(10),
      ),
      child: Column(
        children: [
          if (widget.showSearch) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: stickyHeaderBackgroundColor,
                border: Border(
                  bottom: BorderSide(
                    color: CupertinoDynamicColor.resolve(
                      CupertinoColors.separator,
                      context,
                    ),
                  ),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: CupertinoSearchTextField(
                      placeholder: searchPlaceholder,
                      autofocus: _searchAutofocus,
                      controller: _searchController,
                      onChanged: _filterSearchResults,
                      suffixInsets: const EdgeInsetsDirectional.only(end: 5),
                      style: widget.countryListTheme?.searchTextStyle ??
                          _kDefaultTextStyle,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: Text(cancelButtonText),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),
          ],
          Expanded(
            child: GroupedListView(
              shrinkWrap: true,
              useStickyGroupSeparators: true,
              elements: _filteredList,
              groupBy: (Country e) => e
                  .copyWith(
                      nameLocalized: t
                          ?.countryName(countryCode: e.countryCode)
                          ?.replaceAll(RegExp(r'\s+'), ' '))
                  .nameLocalized
                  ?.characters
                  .first,
              stickyHeaderBackgroundColor: stickyHeaderBackgroundColor,
              separator: Divider(
                thickness: 1,
                height: 1,
                indent: 16,
                endIndent: 16,
                color: CupertinoDynamicColor.resolve(
                  CupertinoColors.separator,
                  context,
                ),
              ),
              groupSeparatorBuilder: (String? name) => Container(
                color: stickyHeaderBackgroundColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                child: Text(
                  name ?? '',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: CupertinoDynamicColor.resolve(
                      MediaQueryData.fromWindow(
                                WidgetsBinding.instance.window,
                              ).platformBrightness ==
                              Brightness.dark
                          ? CupertinoColors.label
                          : CupertinoColors.placeholderText,
                      context,
                    ),
                  ),
                ),
              ),
              itemBuilder: (_, Country e) => _CountryListItem(
                country: e,
                onSelect: widget.onSelect,
                countryListTheme: widget.countryListTheme,
              ),

              // children: [
              //   if (_favoriteList != null) ...[
              //     ..._favoriteList!
              //         .map((c) => _CountryListItem(
              //               country: c,
              //               onSelect: widget.onSelect,
              //               countryListTheme: widget.countryListTheme,
              //             ))
              //         .toList(),
              //     const Padding(
              //       padding: EdgeInsets.symmetric(horizontal: 16.0),
              //       child: Divider(thickness: 1, height: 1),
              //     ),
              //   ],
              //   ..._filteredList
              //       .map((c) => _CountryListItem(
              //             country: c,
              //             onSelect: widget.onSelect,
              //             countryListTheme: widget.countryListTheme,
              //           ))
              //       .toList(),
              // ],
            ),
          ),
        ],
      ),
    );
  }

  void _filterSearchResults(String query) {
    List<Country> searchResult = <Country>[];

    final CountryLocalizations? localizations =
        CountryLocalizations.of(context);

    if (query.isEmpty) {
      searchResult.addAll(_countryList);
    } else {
      searchResult = _countryList
          .where((c) => c.startsWith(query, localizations))
          .toList();
    }

    setState(() => _filteredList = searchResult);
  }
}

class _CountryListItem extends StatelessWidget {
  final Country country;

  /// Called when a country is select.
  ///
  /// The country picker passes the new value to the callback.
  final ValueChanged<Country>? onSelect;

  /// An optional argument for customizing the
  /// country list bottom sheet.
  final CountryListThemeData? countryListTheme;

  const _CountryListItem({
    required this.country,
    this.countryListTheme,
    this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    final TextStyle textStyle = countryListTheme?.textStyle ??
        _kDefaultTextStyle.copyWith(
          color: CupertinoDynamicColor.resolve(
            CupertinoColors.label,
            context,
          ),
        );

    return Material(
      // Add Material Widget with transparent color
      // so the ripple effect of InkWell will show on tap
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          onSelect?.call(country.copyWith(
            nameLocalized: CountryLocalizations.of(context)
                ?.countryName(countryCode: country.countryCode)
                ?.replaceAll(RegExp(r'\s+'), ' '),
          ));
          Navigator.pop(context);
        },
        child: ListTile(
          dense: true,
          minLeadingWidth: 0,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          leading: _Flag(
            country: country,
            countryListTheme: countryListTheme,
          ),
          trailing: Text(
            '${isRtl ? '' : '+'}${country.phoneCode}${isRtl ? '+' : ''}',
            style: textStyle,
          ),
          title: Text(
            CountryLocalizations.of(context)
                    ?.countryName(countryCode: country.countryCode)
                    ?.replaceAll(RegExp(r'\s+'), ' ') ??
                country.name,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}

class _Flag extends StatelessWidget {
  final Country country;
  final CountryListThemeData? countryListTheme;

  const _Flag({
    Key? key,
    required this.country,
    this.countryListTheme,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;
    return SizedBox(
      // the conditional 50 prevents irregularities caused by the flags in RTL mode
      width: isRtl ? 50 : null,
      child: Text(
        country.iswWorldWide
            ? '\uD83C\uDF0D'
            : Utils.countryCodeToEmoji(country.countryCode),
        style: TextStyle(
          fontSize: countryListTheme?.flagSize ?? 25,
        ),
      ),
    );
  }
}

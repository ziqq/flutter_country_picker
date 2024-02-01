import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_country_picker/src/country_localizations.dart';
import 'package:flutter_country_picker/src/country_model.dart';
import 'package:flutter_country_picker/src/country_picker_theme_data.dart';
import 'package:flutter_country_picker/src/country_service.dart';
import 'package:flutter_country_picker/src/helpers/constants.dart';
import 'package:flutter_country_picker/src/helpers/utils.dart';
import 'package:grouped_list/grouped_list.dart';

class CountryListView extends StatefulWidget {
  const CountryListView({
    required this.onSelect,
    super.key,
    this.exclude,
    this.favorite,
    this.countryFilter,
    this.countryPickerThemeData,
    this.padding = kDefaultPadding,
    this.showSearch = true,
    this.showPhoneCode = false,
    this.showWorldWide = false,
    this.searchAutofocus = false,
  }) : assert(
          exclude == null || countryFilter == null,
          'Cannot provide both exclude and countryFilter',
        );

  /// An optional argument for hiding the search bar
  final bool showSearch;

  /// An optional [showPhoneCode] argument can be used to show phone code.
  final bool showPhoneCode;

  /// An optional argument for showing "World Wide" option at the beginning of the list
  final bool showWorldWide;

  /// An optional argument for initially expanding virtual keyboard
  final bool searchAutofocus;

  /// An optional argiment for default padding.
  final double padding;

  /// Called when a country is select.
  ///
  /// The country picker passes the new value to the callback.
  final ValueChanged<Country> onSelect;

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
  final CountryPickerThemeData? countryPickerThemeData;

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

    // Remove duplicates country if not use phone code
    if (!widget.showPhoneCode) {
      final ids = _countryList.map((e) => e.countryCode).toSet();
      _countryList.retainWhere((c) => ids.remove(c.countryCode));
    }

    // if (widget.favorite != null) {
    //   _favoriteList = _countryService.findCountriesByCode(widget.favorite!);
    // }

    if (widget.exclude != null) {
      _countryList.removeWhere(
        (e) => widget.exclude!.contains(e.countryCode),
      );
    }

    if (widget.countryFilter != null) {
      _countryList.removeWhere(
        (e) => !widget.countryFilter!.contains(e.countryCode),
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

    final String cancelButtonText =
        t?.countryName(countryCode: 'cancel') ?? 'Отмена';

    final String searchPlaceholder =
        t?.countryName(countryCode: 'search') ?? 'Поиск';

    final CountryPickerThemeData? customThemeData =
        widget.countryPickerThemeData;

    final double effectiveIndent =
        customThemeData?.baseIndent ?? kDefaultIndent;

    final double effectivePadding =
        customThemeData?.basePadding ?? kDefaultPadding;

    final Color effectiveStickyHeaderBackgroundColor =
        customThemeData?.stickyHeaderBackgroundColor ??
            CupertinoDynamicColor.resolve(
                CupertinoColors.secondarySystemBackground, context);

    final Color effectiveDividerColor = customThemeData?.dividerColor ??
        CupertinoDynamicColor.resolve(CupertinoColors.opaqueSeparator, context);

    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft:
              customThemeData?.borderRadius?.topLeft ?? kDefaultBorderRadius,
          topRight:
              customThemeData?.borderRadius?.topRight ?? kDefaultBorderRadius,
        ),
        child: Column(
          children: [
            if (widget.showSearch) ...[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: effectiveIndent,
                  vertical: effectiveIndent / 2,
                ),
                decoration: BoxDecoration(
                  color: effectiveStickyHeaderBackgroundColor,
                  border: Border(
                    bottom: BorderSide(
                      color: effectiveDividerColor,
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
                        suffixInsets: EdgeInsetsDirectional.only(
                          end: effectiveIndent / 2,
                        ),
                        style: widget.countryPickerThemeData?.searchTextStyle ??
                            kDefaultTextStyle,
                      ),
                    ),
                    SizedBox(width: effectiveIndent),
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
                stickyHeaderBackgroundColor:
                    effectiveStickyHeaderBackgroundColor,
                elements: _filteredList,
                groupBy: (country) => country
                    .copyWith(
                        nameLocalized: t
                            ?.countryName(countryCode: country.countryCode)
                            ?.replaceAll(RegExp(r'\s+'), ' '))
                    .nameLocalized
                    ?.characters
                    .first,
                separator: Divider(
                  height: 1,
                  thickness: 1,
                  indent: effectivePadding,
                  endIndent: effectivePadding,
                  color: effectiveDividerColor,
                ),
                groupSeparatorBuilder: (name) => Container(
                  color: effectiveStickyHeaderBackgroundColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: effectivePadding,
                    vertical: effectivePadding / 3,
                  ),
                  child: Text(
                    name ?? '',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: CupertinoDynamicColor.resolve(
                        CupertinoColors.label,
                        context,
                      ),
                    ),
                  ),
                ),
                itemBuilder: (_, e) => _CountryListView$ListItem(
                  country: e,
                  onSelect: widget.onSelect,
                  countryPickerThemeData: widget.countryPickerThemeData,
                ),

                // children: [
                //   if (_favoriteList != null) ...[
                //     ..._favoriteList!
                //         .map((c) => _CountryListView$ListItem(
                //               country: c,
                //               onSelect: widget.onSelect,
                //               countryPickerThemeData: widget.countryPickerThemeData,
                //             ))
                //         .toList(),
                //     const Padding(
                //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                //       child: Divider(thickness: 1, height: 1),
                //     ),
                //   ],
                //   ..._filteredList
                //       .map((c) => _CountryListView$ListItem(
                //             country: c,
                //             onSelect: widget.onSelect,
                //             countryPickerThemeData: widget.countryPickerThemeData,
                //           ))
                //       .toList(),
                // ],
              ),
            ),
          ],
        ),
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

class _CountryListView$ListItem extends StatelessWidget {
  const _CountryListView$ListItem({
    required this.country,
    this.countryPickerThemeData,
    this.onSelect,
    super.key, // ignore: unused_element
  });

  final Country country;

  /// Called when a country is select.
  ///
  /// The country picker passes the new value to the callback.
  final ValueChanged<Country>? onSelect;

  /// An optional argument for customizing the
  /// country list bottom sheet.
  final CountryPickerThemeData? countryPickerThemeData;

  @override
  Widget build(BuildContext context) {
    final bool isRtl = Directionality.of(context) == TextDirection.rtl;

    final TextStyle effectiveTextStyle = countryPickerThemeData?.textStyle ??
        kDefaultTextStyle.copyWith(
          color: CupertinoDynamicColor.resolve(
            CupertinoColors.label,
            context,
          ),
        );

    final EdgeInsetsGeometry effectivePadding =
        countryPickerThemeData?.padding ??
            const EdgeInsets.symmetric(horizontal: kDefaultPadding);

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
          contentPadding: effectivePadding,
          leading: _CountryListView$Flag(
            country: country,
            countryPickerThemeData: countryPickerThemeData,
          ),
          trailing: Text(
            '${isRtl ? '' : '+'}${country.phoneCode}${isRtl ? '+' : ''}',
            style: effectiveTextStyle,
          ),
          title: Text(
            CountryLocalizations.of(context)
                    ?.countryName(countryCode: country.countryCode)
                    ?.replaceAll(RegExp(r'\s+'), ' ') ??
                country.name,
            style: effectiveTextStyle,
          ),
        ),
      ),
    );
  }
}

class _CountryListView$Flag extends StatelessWidget {
  const _CountryListView$Flag({
    required this.country,
    this.countryPickerThemeData,
    super.key, // ignore: unused_element
  });

  final Country country;
  final CountryPickerThemeData? countryPickerThemeData;

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
          fontSize: countryPickerThemeData?.flagSize ?? 25,
        ),
      ),
    );
  }
}

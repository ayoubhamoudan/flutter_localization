import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocale {
  // this class should know the current locale
  Locale locale ;

  AppLocale(this.locale);

  Map<String , String> _loadedLocalizedValues ;

  // we need a version from AppLocale Depending on the context
  static AppLocale of (BuildContext context){
      return Localizations.of(context, AppLocale); // return a localization of AppLocale type
  }

  Future loadLanguages() async {
    String _langFile = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');  // to load Json File
    Map<String , dynamic> _loadedValues = jsonDecode(_langFile);
    _loadedLocalizedValues = _loadedValues.map((key, value) => MapEntry(key , value.toString())); // to map loaded values to kay : value String
  }

  String getTranslated (String key){
    return _loadedLocalizedValues[key]; // return translated value For Specific KeY
  }

  static const LocalizationsDelegate<AppLocale> delegate = _AppLocaleDelegate();
}


class _AppLocaleDelegate extends LocalizationsDelegate<AppLocale> {

  const _AppLocaleDelegate() ; // we can't create many version from this Class
  @override
  // if locale Supported
  bool isSupported(Locale locale) {
    // return locale language if it exist in the list
    return ['en' , 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocale> load(Locale locale) async {
    AppLocale appLocale = AppLocale(locale);
    await appLocale.loadLanguages();
    return appLocale ;
  }

  // true if we have many delegates
  @override
  bool shouldReload(LocalizationsDelegate<AppLocale> old) => false ;

}

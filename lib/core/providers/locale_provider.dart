import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale;

  LocaleProvider({Locale initialLocale = const Locale('en')})
      : _locale = initialLocale;

  Locale get locale => _locale;
  bool get isArabic => _locale.languageCode.toLowerCase() == 'ar';

  void setLocale(Locale locale) {
    if (_locale == locale) return;
    _locale = locale;
    notifyListeners();
  }

  void toggle() {
    setLocale(isArabic ? const Locale('en') : const Locale('ar'));
  }
}


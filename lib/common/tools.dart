import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';

Widget getFlagByLanguageCode(final String lang) {
  switch (lang) {
    case "en":
      return getFlagByCountryCode("GB");
    case "la":
      return const Image(image: AssetImage("assets/image/flag_la.png"), width: 40);
    default:
      return getFlagByCountryCode(lang);
  }
}

Widget getFlagByCountryCode(final String country) {
  return Flag.fromString(country, width: 40);
}

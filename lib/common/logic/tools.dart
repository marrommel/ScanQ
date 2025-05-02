import 'package:flag/flag_widget.dart';
import 'package:flutter/cupertino.dart';

Widget getFlagByLanguageCode(String lang) {
  lang = lang.toLowerCase();

  switch (lang) {
    case "de":
      return const Image(image: AssetImage("assets/image/germany.png"), width: 40);
    case "en":
      return const Image(image: AssetImage("assets/image/usa.png"), width: 40);
    //return getFlagByCountryCode("GB");
    case "la":
      return const Image(image: AssetImage("assets/image/flag_la.png"), width: 40);
    default:
      return getFlagByCountryCode(lang);
  }
}

Widget getFlagByCountryCode(final String country) {
  return Flag.fromString(country, width: 40);
}

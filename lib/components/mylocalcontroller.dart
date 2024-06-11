
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class MyLocaleController extends GetxController {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  void changeLocale(String langCode) {
    Locale newLocale = Locale(langCode);
    _locale = newLocale;
    Get.updateLocale(newLocale);
  }
}

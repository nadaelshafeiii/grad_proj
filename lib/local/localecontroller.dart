import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocaleController extends GetxController {
  Locale initialLang = Locale("en");
  static SharedPreferences? _sharedPreferences;

  MyLocaleController() {
    initSharedPreferences();
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    String? lang = _sharedPreferences!.getString("lang");
    if (lang != null) {
      initialLang = lang == "ar" ? Locale("ar") : Locale("en");
    }
  }

  void changeLang(String codeLang) async {
    Locale locale = Locale(codeLang);
    _sharedPreferences!.setString("lang", codeLang);
    Get.updateLocale(locale);
  }
}

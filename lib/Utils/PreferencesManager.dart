import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  static final PreferencesManager _instance = PreferencesManager._internal();

  PreferencesManager._internal();

  factory PreferencesManager() {
    return _instance;
  }

  Color accent = const Color(0xff2a9d8f);
  Color secondary = const Color(0xfff4a261);
  String lang = "fr";
  String theme = "light";

  static const String _keyAccent = "accent_color";
  static const String _keySecondary = "secondary_color";
  static const String _keyLang = "language";
  static const String _keyTheme = "theme";

  Future<void> loadPref() async {
    final prefs = await SharedPreferences.getInstance();

    String? savedAccent = prefs.getString(_keyAccent);
    String? savedSecondary = prefs.getString(_keySecondary);
    lang = prefs.getString(_keyLang) ?? "fr";
    theme = prefs.getString(_keyTheme) ?? "light";

    if (savedAccent != null) {
      accent = _colorFromHex(savedAccent);
    }
    if (savedSecondary != null) {
      secondary = _colorFromHex(savedSecondary);
    }
  }

  Future<void> changeAccent(Color newColor) async {
    accent = newColor;
    await savePreference(_keyAccent, _colorToHex(newColor));
  }

  Future<void> changeSecondary(Color newColor) async {
    secondary = newColor;
    await savePreference(_keySecondary, _colorToHex(newColor));
  }

  Future<void> changeLang(String newLang) async {
    lang = newLang;
    await savePreference(_keyLang, newLang);
  }

  Future<void> changeTheme(String newTheme) async {
    theme = newTheme;
    await savePreference(_keyTheme, newTheme);
  }

  Future<void> savePreference(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String?> getPreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> removePreference(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  String _colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  Color _colorFromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
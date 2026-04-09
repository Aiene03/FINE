import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsProvider extends ChangeNotifier {
  static const _boxName = 'settings';
  static const _keyUnit = 'unit';
  static const _keyTolerance = 'tolerance';
  static const _keyDefaultBatch = 'default_batch';
  static const _keyThemeMode = 'theme_mode';
  static const _keyFavorites = 'favorites';

  late Box _box;
  String _unit = 'kg';
  double _tolerancePercent = 0.05;
  double _defaultBatchKg = 20.0;
  ThemeMode _themeMode = ThemeMode.system;
  Set<String> _favorites = {};

  String get unit => _unit;
  double get tolerancePercent => _tolerancePercent;
  double get defaultBatchKg => _defaultBatchKg;
  ThemeMode get themeMode => _themeMode;
  Set<String> get favorites => _favorites;
  bool isFavorite(String recipeId) => _favorites.contains(recipeId);

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
    _unit = _box.get(_keyUnit, defaultValue: 'kg') as String;
    _tolerancePercent = (_box.get(_keyTolerance, defaultValue: 0.05) as num)
        .toDouble();
    _defaultBatchKg = (_box.get(_keyDefaultBatch, defaultValue: 20.0) as num)
        .toDouble();
    _themeMode =
        ThemeMode.values[_box.get(_keyThemeMode, defaultValue: 0) as int];
    final favList = _box.get(_keyFavorites, defaultValue: <String>[]) as List;
    _favorites = Set<String>.from(favList);
  }

  double convertFromKg(double kg) => _unit == 'lbs' ? kg * 2.20462 : kg;
  double convertToKg(double value) => _unit == 'lbs' ? value / 2.20462 : value;

  String formatWeight(double kg) {
    final v = convertFromKg(kg);
    return '${v.toStringAsFixed(2)} $_unit';
  }

  Future<void> setUnit(String unit) async {
    _unit = unit;
    await _box.put(_keyUnit, unit);
    notifyListeners();
  }

  Future<void> setTolerance(double percent) async {
    _tolerancePercent = percent;
    await _box.put(_keyTolerance, percent);
    notifyListeners();
  }

  Future<void> setDefaultBatch(double kg) async {
    _defaultBatchKg = kg;
    await _box.put(_keyDefaultBatch, kg);
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    await _box.put(_keyThemeMode, mode.index);
    notifyListeners();
  }

  Future<void> toggleFavorite(String recipeId) async {
    if (_favorites.contains(recipeId)) {
      _favorites.remove(recipeId);
    } else {
      _favorites.add(recipeId);
    }
    await _box.put(_keyFavorites, _favorites.toList());
    notifyListeners();
  }
}

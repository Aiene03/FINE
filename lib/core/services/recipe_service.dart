import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/seed_recipes.dart';
import '../models/animal_category.dart';
import '../models/recipe.dart';

class RecipeService {
  static const _boxName = 'recipes';
  static const _seededKey = 'seeded_v1';
  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
    if (!_box.containsKey(_seededKey)) {
      await _seedDefaultRecipes();
    }
  }

  Future<void> _seedDefaultRecipes() async {
    for (final recipe in SeedRecipes.all) {
      await _box.put(recipe.id, jsonEncode(recipe.toJson()));
    }
    await _box.put(_seededKey, true);
  }

  List<Recipe> getAllRecipes() {
    return _box.keys
        .where((k) => k != _seededKey)
        .map((k) => Recipe.fromJson(jsonDecode(_box.get(k) as String) as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  List<Recipe> getRecipesByAnimal(AnimalCategory animal) {
    return getAllRecipes()
        .where((r) => r.animalCategory == animal)
        .toList();
  }

  Recipe? getRecipeById(String id) {
    final raw = _box.get(id);
    if (raw == null) return null;
    return Recipe.fromJson(jsonDecode(raw as String) as Map<String, dynamic>);
  }

  Future<void> saveRecipe(Recipe recipe) async {
    await _box.put(recipe.id, jsonEncode(recipe.toJson()));
  }

  Future<void> deleteRecipe(String id) async {
    await _box.delete(id);
  }

  Map<AnimalCategory, int> getRecipeCountByAnimal() {
    final recipes = getAllRecipes();
    final map = <AnimalCategory, int>{};
    for (final animal in AnimalCategory.values) {
      map[animal] = recipes.where((r) => r.animalCategory == animal).length;
    }
    return map;
  }

  int get totalRecipeCount => getAllRecipes().length;
}

import 'animal_category.dart';
import 'ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String nameEn;
  final String description;
  final AnimalCategory animalCategory;
  final List<Ingredient> ingredients;
  final double baseBatchKg;
  final bool isCustom;

  const Recipe({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.description,
    required this.animalCategory,
    required this.ingredients,
    this.baseBatchKg = 20.0,
    this.isCustom = false,
  });

  double get totalBaseWeight =>
      ingredients.fold(0.0, (sum, i) => sum + i.baseWeightKg);

  int get ingredientCount => ingredients.length;

  String get animalEmoji => animalCategory.emoji;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nameEn': nameEn,
    'description': description,
    'animalCategory': animalCategory.name,
    'ingredients': ingredients.map((i) => i.toJson()).toList(),
    'baseBatchKg': baseBatchKg,
    'isCustom': isCustom,
  };

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json['id'] as String,
    name: json['name'] as String,
    nameEn: json['nameEn'] as String,
    description: json['description'] as String,
    animalCategory: AnimalCategory.values.firstWhere(
      (a) => a.name == json['animalCategory'],
      orElse: () => AnimalCategory.manok,
    ),
    ingredients: (json['ingredients'] as List)
        .map((i) => Ingredient.fromJson(i as Map<String, dynamic>))
        .toList(),
    baseBatchKg: (json['baseBatchKg'] as num?)?.toDouble() ?? 20.0,
    isCustom: json['isCustom'] as bool? ?? false,
  );
}

import 'ingredient.dart';
import 'recipe.dart';

enum SessionStatus { inProgress, completed, cancelled }

class GrindSession {
  final String id;
  final Recipe recipe;
  final double batchSizeKg;
  final Map<String, double?> measuredWeights;
  final SessionStatus status;
  final DateTime startTime;
  final DateTime? endTime;

  GrindSession({
    required this.id,
    required this.recipe,
    required this.batchSizeKg,
    required this.measuredWeights,
    this.status = SessionStatus.inProgress,
    required this.startTime,
    this.endTime,
  });

  bool isIngredientPassed(Ingredient ingredient) {
    final measured = measuredWeights[ingredient.id];
    if (measured == null) return false;
    return ingredient.isWithinTolerance(measured, batchSizeKg);
  }

  bool isIngredientMeasured(String ingredientId) {
    return measuredWeights[ingredientId] != null;
  }

  int get measuredCount =>
      measuredWeights.values.where((v) => v != null).length;

  int get passedCount =>
      recipe.ingredients.where((i) => isIngredientPassed(i)).length;

  bool get allIngredientsPassed =>
      recipe.ingredients.every((i) => isIngredientPassed(i));

  bool get canStartGrinder => allIngredientsPassed;

  Duration get elapsed =>
      (endTime ?? DateTime.now()).difference(startTime);

  GrindSession copyWith({
    Map<String, double?>? measuredWeights,
    SessionStatus? status,
    DateTime? endTime,
  }) {
    return GrindSession(
      id: id,
      recipe: recipe,
      batchSizeKg: batchSizeKg,
      measuredWeights: measuredWeights ?? Map.from(this.measuredWeights),
      status: status ?? this.status,
      startTime: startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

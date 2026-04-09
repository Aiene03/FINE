import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/grind_session.dart';
import '../models/ingredient.dart';
import '../models/recipe.dart';
import '../models/session_history.dart' as history;

class GrindSessionProvider extends ChangeNotifier {
  GrindSession? _session;
  bool _isGrinding = false;
  int _grindProgress = 0;
  VoidCallback? _onSessionComplete;

  GrindSession? get session => _session;
  bool get isGrinding => _isGrinding;
  int get grindProgress => _grindProgress;
  bool get hasActiveSession => _session != null;

  void setOnSessionComplete(VoidCallback callback) {
    _onSessionComplete = callback;
  }

  void startSession(Recipe recipe, double batchSizeKg) {
    final weights = <String, double?>{
      for (final i in recipe.ingredients) i.id: null,
    };
    _session = GrindSession(
      id: const Uuid().v4(),
      recipe: recipe,
      batchSizeKg: batchSizeKg,
      measuredWeights: Map.from(weights),
      startTime: DateTime.now(),
    );
    _isGrinding = false;
    _grindProgress = 0;
    notifyListeners();
  }

  void updateWeight(String ingredientId, double? weight) {
    if (_session == null) return;
    final updated = Map<String, double?>.from(_session!.measuredWeights);
    updated[ingredientId] = weight;
    _session = _session!.copyWith(measuredWeights: updated);
    notifyListeners();
  }

  bool isIngredientPassed(Ingredient ingredient) {
    return _session?.isIngredientPassed(ingredient) ?? false;
  }

  bool get canStartGrinder => _session?.canStartGrinder ?? false;

  int get passedCount => _session?.passedCount ?? 0;
  int get totalCount => _session?.recipe.ingredientCount ?? 0;

  Future<void> startGrinder() async {
    if (_session == null || !canStartGrinder) return;
    _isGrinding = true;
    _grindProgress = 0;
    notifyListeners();

    for (int i = 0; i <= 100; i += 5) {
      await Future.delayed(const Duration(milliseconds: 200));
      _grindProgress = i;
      notifyListeners();
    }

    _isGrinding = false;
    _session = _session!.copyWith(
      status: SessionStatus.completed,
      endTime: DateTime.now(),
    );
    notifyListeners();
    _onSessionComplete?.call();
  }

  history.SessionHistory? createSessionHistory() {
    if (_session == null) return null;
    return history.SessionHistory(
      id: _session!.id,
      recipeId: _session!.recipe.id,
      recipeName: _session!.recipe.name,
      animalEmoji: _session!.recipe.animalEmoji,
      batchSizeKg: _session!.batchSizeKg,
      ingredientCount: _session!.recipe.ingredientCount,
      passedCount: _session!.passedCount,
      duration: _session!.elapsed,
      status: _session!.status == SessionStatus.completed
          ? history.SessionStatus.completed
          : history.SessionStatus.cancelled,
      completedAt: _session!.endTime ?? DateTime.now(),
    );
  }

  void cancelSession() {
    _session = _session?.copyWith(status: SessionStatus.cancelled);
    _isGrinding = false;
    notifyListeners();
  }

  void clearSession() {
    _session = null;
    _isGrinding = false;
    _grindProgress = 0;
    notifyListeners();
  }

  bool get isCompleted => _session?.status == SessionStatus.completed;
}

enum SessionStatus { inProgress, completed, cancelled }

class SessionHistory {
  final String id;
  final String recipeId;
  final String recipeName;
  final String animalEmoji;
  final double batchSizeKg;
  final int ingredientCount;
  final int passedCount;
  final Duration duration;
  final SessionStatus status;
  final DateTime completedAt;

  SessionHistory({
    required this.id,
    required this.recipeId,
    required this.recipeName,
    required this.animalEmoji,
    required this.batchSizeKg,
    required this.ingredientCount,
    required this.passedCount,
    required this.duration,
    required this.status,
    required this.completedAt,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'recipeId': recipeId,
    'recipeName': recipeName,
    'animalEmoji': animalEmoji,
    'batchSizeKg': batchSizeKg,
    'ingredientCount': ingredientCount,
    'passedCount': passedCount,
    'durationSeconds': duration.inSeconds,
    'status': status.index,
    'completedAt': completedAt.toIso8601String(),
  };

  factory SessionHistory.fromJson(Map<String, dynamic> json) => SessionHistory(
    id: json['id'] as String,
    recipeId: json['recipeId'] as String,
    recipeName: json['recipeName'] as String,
    animalEmoji: json['animalEmoji'] as String,
    batchSizeKg: (json['batchSizeKg'] as num).toDouble(),
    ingredientCount: json['ingredientCount'] as int,
    passedCount: json['passedCount'] as int,
    duration: Duration(seconds: json['durationSeconds'] as int),
    status: SessionStatus.values[json['status'] as int],
    completedAt: DateTime.parse(json['completedAt'] as String),
  );

  double get successRate =>
      ingredientCount > 0 ? (passedCount / ingredientCount) * 100 : 0;
}

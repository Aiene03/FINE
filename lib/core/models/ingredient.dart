class Ingredient {
  final String id;
  final String name;       // Filipino name
  final String nameEn;     // English name
  final double baseWeightKg; // Weight for a 20kg base batch
  final double tolerancePercent; // e.g. 0.05 = 5%

  const Ingredient({
    required this.id,
    required this.name,
    required this.nameEn,
    required this.baseWeightKg,
    this.tolerancePercent = 0.05,
  });

  /// Target weight scaled to the given batch size
  double targetWeightForBatch(double batchKg) {
    return baseWeightKg * (batchKg / 20.0);
  }

  /// Allowed deviation scaled to the given batch size
  double toleranceKgForBatch(double batchKg) {
    return targetWeightForBatch(batchKg) * tolerancePercent;
  }

  /// Check if a measured weight is within tolerance
  bool isWithinTolerance(double measured, double batchKg) {
    final target = targetWeightForBatch(batchKg);
    final tol = toleranceKgForBatch(batchKg);
    return (measured - target).abs() <= tol;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'nameEn': nameEn,
    'baseWeightKg': baseWeightKg,
    'tolerancePercent': tolerancePercent,
  };

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    id: json['id'] as String,
    name: json['name'] as String,
    nameEn: json['nameEn'] as String,
    baseWeightKg: (json['baseWeightKg'] as num).toDouble(),
    tolerancePercent: (json['tolerancePercent'] as num?)?.toDouble() ?? 0.05,
  );

  Ingredient copyWith({
    String? id,
    String? name,
    String? nameEn,
    double? baseWeightKg,
    double? tolerancePercent,
  }) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      nameEn: nameEn ?? this.nameEn,
      baseWeightKg: baseWeightKg ?? this.baseWeightKg,
      tolerancePercent: tolerancePercent ?? this.tolerancePercent,
    );
  }
}

import 'package:flutter/material.dart';

enum AnimalCategory { manok, baboy, pato, kambing, tilapia }

extension AnimalCategoryExtension on AnimalCategory {
  String get displayName {
    switch (this) {
      case AnimalCategory.manok:
        return 'Chicken';
      case AnimalCategory.baboy:
        return 'Pig';
      case AnimalCategory.pato:
        return 'Duck';
      case AnimalCategory.kambing:
        return 'Goat';
      case AnimalCategory.tilapia:
        return 'Tilapia';
    }
  }

  String get emoji {
    switch (this) {
      case AnimalCategory.manok:
        return '🐔';
      case AnimalCategory.baboy:
        return '🐷';
      case AnimalCategory.pato:
        return '🦆';
      case AnimalCategory.kambing:
        return '🐐';
      case AnimalCategory.tilapia:
        return '🐟';
    }
  }

  String get description {
    switch (this) {
      case AnimalCategory.manok:
        return 'Starter, Grower, Layer';
      case AnimalCategory.baboy:
        return 'Starter, Grower, Finisher';
      case AnimalCategory.pato:
        return 'Grower, Layer';
      case AnimalCategory.kambing:
        return 'General Mix';
      case AnimalCategory.tilapia:
        return 'Grower, Starter';
    }
  }

  Color get color {
    switch (this) {
      case AnimalCategory.manok:
        return const Color(0xFFF59E0B);
      case AnimalCategory.baboy:
        return const Color(0xFFEC4899);
      case AnimalCategory.pato:
        return const Color(0xFF3B82F6);
      case AnimalCategory.kambing:
        return const Color(0xFF8B5CF6);
      case AnimalCategory.tilapia:
        return const Color(0xFF06B6D4);
    }
  }

  Color get lightColor {
    switch (this) {
      case AnimalCategory.manok:
        return const Color(0xFFFEF3C7);
      case AnimalCategory.baboy:
        return const Color(0xFFFCE7F3);
      case AnimalCategory.pato:
        return const Color(0xFFDBEAFE);
      case AnimalCategory.kambing:
        return const Color(0xFFEDE9FE);
      case AnimalCategory.tilapia:
        return const Color(0xFFCFFAFE);
    }
  }

  String get tagalogDescription {
    switch (this) {
      case AnimalCategory.manok:
        return 'Food for chickens';
      case AnimalCategory.baboy:
        return 'Food for pigs';
      case AnimalCategory.pato:
        return 'Food for ducks';
      case AnimalCategory.kambing:
        return 'Food for goats';
      case AnimalCategory.tilapia:
        return 'Food for fish';
    }
  }
}

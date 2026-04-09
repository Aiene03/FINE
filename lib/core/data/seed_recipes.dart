import '../models/animal_category.dart';
import '../models/ingredient.dart';
import '../models/recipe.dart';

/// Pre-seeded recipes using common Filipino backyard ingredients.
/// All weights are based on a 20 kg batch.
class SeedRecipes {
  static List<Recipe> get all => [
    ..._manokRecipes,
    ..._baboyRecipes,
    ..._patoRecipes,
    ..._kambingRecipes,
    ..._tilapiaRecipes,
  ];

  // ─────────────────────────────────────────
  // 🐔 MANOK (Chicken)
  // ─────────────────────────────────────────
  static final _manokRecipes = [
    Recipe(
      id: 'manok_starter',
      name: 'Pagkain ng Manok (Starter)',
      nameEn: 'Chicken Starter Feed',
      description:
          'Para sa mga sisiw na 0–4 na linggo. Mataas na protina para sa mabilis na paglaki.',
      animalCategory: AnimalCategory.manok,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'ms_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 10.0,
        ),
        const Ingredient(
          id: 'ms_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 5.0,
        ),
        const Ingredient(
          id: 'ms_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 2.5,
        ),
        const Ingredient(
          id: 'ms_malunggay',
          name: 'Malunggay (Tuyong Pulbos)',
          nameEn: 'Dried Moringa',
          baseWeightKg: 1.0,
        ),
        const Ingredient(
          id: 'ms_niyog',
          name: 'Niyog Sapal (Coconut Meal)',
          nameEn: 'Coconut Meal',
          baseWeightKg: 1.2,
        ),
        const Ingredient(
          id: 'ms_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.3,
        ),
      ],
    ),
    Recipe(
      id: 'manok_grower',
      name: 'Pagkain ng Manok (Grower)',
      nameEn: 'Chicken Grower Feed',
      description:
          'Para sa mga manok na 4–16 na linggo. Mas maraming enerhiya para sa paglaki.',
      animalCategory: AnimalCategory.manok,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'mg_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 11.0,
        ),
        const Ingredient(
          id: 'mg_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 5.5,
        ),
        const Ingredient(
          id: 'mg_kamotekahoy',
          name: 'Kamoteng Kahoy (Tuyong Chips)',
          nameEn: 'Cassava Chips',
          baseWeightKg: 1.5,
        ),
        const Ingredient(
          id: 'mg_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 1.5,
        ),
        const Ingredient(
          id: 'mg_malunggay',
          name: 'Malunggay (Tuyong Pulbos)',
          nameEn: 'Dried Moringa',
          baseWeightKg: 0.3,
        ),
        const Ingredient(
          id: 'mg_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.2,
        ),
      ],
    ),
    Recipe(
      id: 'manok_layer',
      name: 'Pagkain ng Nagbibigay-Itlog',
      nameEn: 'Chicken Layer Feed',
      description:
          'Para sa mga manok na nagbibigay ng itlog. Naglalaman ng calcium para sa malusog na itlog.',
      animalCategory: AnimalCategory.manok,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'ml_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 9.0,
        ),
        const Ingredient(
          id: 'ml_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 5.0,
        ),
        const Ingredient(
          id: 'ml_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 3.0,
        ),
        const Ingredient(
          id: 'ml_kamote',
          name: 'Kamote (Tuyong Chips)',
          nameEn: 'Sweet Potato Chips',
          baseWeightKg: 2.0,
        ),
        const Ingredient(
          id: 'ml_malunggay',
          name: 'Malunggay (Tuyong Pulbos)',
          nameEn: 'Dried Moringa',
          baseWeightKg: 0.7,
        ),
        const Ingredient(
          id: 'ml_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.3,
        ),
      ],
    ),
  ];

  // ─────────────────────────────────────────
  // 🐷 BABOY (Pig)
  // ─────────────────────────────────────────
  static final _baboyRecipes = [
    Recipe(
      id: 'baboy_starter',
      name: 'Pagkain ng Biik (Starter)',
      nameEn: 'Pig Starter Feed',
      description:
          'Para sa mga biik na 1–3 na buwan. Mataas na protina at madaling matustusan.',
      animalCategory: AnimalCategory.baboy,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'bs_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 9.0,
        ),
        const Ingredient(
          id: 'bs_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 5.0,
        ),
        const Ingredient(
          id: 'bs_kamote',
          name: 'Kamote (Tuyong Chips)',
          nameEn: 'Sweet Potato Chips',
          baseWeightKg: 3.0,
        ),
        const Ingredient(
          id: 'bs_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 2.5,
        ),
        const Ingredient(
          id: 'bs_niyog',
          name: 'Niyog Sapal (Coconut Meal)',
          nameEn: 'Coconut Meal',
          baseWeightKg: 0.3,
        ),
        const Ingredient(
          id: 'bs_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.2,
        ),
      ],
    ),
    Recipe(
      id: 'baboy_grower',
      name: 'Pagkain ng Baboy (Grower)',
      nameEn: 'Pig Grower Feed',
      description:
          'Para sa mga baboy na 3–5 na buwan. Balanced na enerhiya at sustansya.',
      animalCategory: AnimalCategory.baboy,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'bg_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 8.0,
        ),
        const Ingredient(
          id: 'bg_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 5.0,
        ),
        const Ingredient(
          id: 'bg_kamote',
          name: 'Kamote (Tuyong Chips)',
          nameEn: 'Sweet Potato Chips',
          baseWeightKg: 3.0,
        ),
        const Ingredient(
          id: 'bg_gabi',
          name: 'Gabi (Tuyong Chips)',
          nameEn: 'Taro Chips',
          baseWeightKg: 2.0,
        ),
        const Ingredient(
          id: 'bg_niyog',
          name: 'Niyog Sapal (Coconut Meal)',
          nameEn: 'Coconut Meal',
          baseWeightKg: 1.5,
        ),
        const Ingredient(
          id: 'bg_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 0.3,
        ),
        const Ingredient(
          id: 'bg_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.2,
        ),
      ],
    ),
    Recipe(
      id: 'baboy_finisher',
      name: 'Panghuling Pagkain ng Baboy',
      nameEn: 'Pig Finisher Feed',
      description:
          'Para sa mga baboy na malapit nang patayin. Nagbibigay ng enerhiya para sa mas maraming karne.',
      animalCategory: AnimalCategory.baboy,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'bf_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 10.0,
        ),
        const Ingredient(
          id: 'bf_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 5.5,
        ),
        const Ingredient(
          id: 'bf_kamotekahoy',
          name: 'Kamoteng Kahoy (Tuyong Chips)',
          nameEn: 'Cassava Chips',
          baseWeightKg: 3.0,
        ),
        const Ingredient(
          id: 'bf_niyog',
          name: 'Niyog Sapal (Coconut Meal)',
          nameEn: 'Coconut Meal',
          baseWeightKg: 1.2,
        ),
        const Ingredient(
          id: 'bf_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.3,
        ),
      ],
    ),
  ];

  // ─────────────────────────────────────────
  // 🦆 PATO (Duck)
  // ─────────────────────────────────────────
  static final _patoRecipes = [
    Recipe(
      id: 'pato_grower',
      name: 'Pagkain ng Pato (Grower)',
      nameEn: 'Duck Grower Feed',
      description:
          'Para sa mga batang pato. Ginagamit ang palay at kangkong na matatagpuan sa paligid.',
      animalCategory: AnimalCategory.pato,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'pg_palay',
          name: 'Palay (Hindi Nigilingang Bigas)',
          nameEn: 'Unmilled Rice (Palay)',
          baseWeightKg: 8.0,
        ),
        const Ingredient(
          id: 'pg_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 5.0,
        ),
        const Ingredient(
          id: 'pg_kangkong',
          name: 'Kangkong (Tuyong Dahon)',
          nameEn: 'Dried Water Spinach',
          baseWeightKg: 3.0,
        ),
        const Ingredient(
          id: 'pg_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 3.0,
        ),
        const Ingredient(
          id: 'pg_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 1.0,
        ),
      ],
    ),
    Recipe(
      id: 'pato_layer',
      name: 'Pagkain ng Pato (Layer)',
      nameEn: 'Duck Layer Feed',
      description:
          'Para sa mga patong nagbibigay ng itlog. Naglalaman ng mas maraming protina.',
      animalCategory: AnimalCategory.pato,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'pl_palay',
          name: 'Palay (Hindi Nigilingang Bigas)',
          nameEn: 'Unmilled Rice (Palay)',
          baseWeightKg: 9.0,
        ),
        const Ingredient(
          id: 'pl_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 5.0,
        ),
        const Ingredient(
          id: 'pl_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 4.5,
        ),
        const Ingredient(
          id: 'pl_kangkong',
          name: 'Kangkong (Tuyong Dahon)',
          nameEn: 'Dried Water Spinach',
          baseWeightKg: 1.2,
        ),
        const Ingredient(
          id: 'pl_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.3,
        ),
      ],
    ),
  ];

  // ─────────────────────────────────────────
  // 🐐 KAMBING (Goat)
  // ─────────────────────────────────────────
  static final _kambingRecipes = [
    Recipe(
      id: 'kambing_general',
      name: 'Pagkain ng Kambing',
      nameEn: 'Goat General Feed',
      description:
          'Pangkalahatang pagkain para sa mga kambing. Ginagamit ang ipil-ipil na karaniwan sa bakuran.',
      animalCategory: AnimalCategory.kambing,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'kg_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 8.0,
        ),
        const Ingredient(
          id: 'kg_ipilipil',
          name: 'Ipil-ipil Dahon (Tuyong)',
          nameEn: 'Dried Ipil-ipil Leaves',
          baseWeightKg: 5.0,
        ),
        const Ingredient(
          id: 'kg_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 4.0,
        ),
        const Ingredient(
          id: 'kg_malunggay',
          name: 'Malunggay (Tuyong Pulbos)',
          nameEn: 'Dried Moringa',
          baseWeightKg: 2.0,
        ),
        const Ingredient(
          id: 'kg_kamotekahoy',
          name: 'Kamoteng Kahoy (Tuyong Chips)',
          nameEn: 'Cassava Chips',
          baseWeightKg: 0.7,
        ),
        const Ingredient(
          id: 'kg_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.3,
        ),
      ],
    ),
  ];

  // ─────────────────────────────────────────
  // 🐟 TILAPIA
  // ─────────────────────────────────────────
  static final _tilapiaRecipes = [
    Recipe(
      id: 'tilapia_grower',
      name: 'Pagkain ng Tilapia (Grower)',
      nameEn: 'Tilapia Grower Feed',
      description:
          'Para sa mga tilapia na lumalaki. Mataas sa protina gamit ang dilis.',
      animalCategory: AnimalCategory.tilapia,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'tg_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 8.0,
        ),
        const Ingredient(
          id: 'tg_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 6.0,
        ),
        const Ingredient(
          id: 'tg_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 4.0,
        ),
        const Ingredient(
          id: 'tg_malunggay',
          name: 'Malunggay (Tuyong Pulbos)',
          nameEn: 'Dried Moringa',
          baseWeightKg: 1.7,
        ),
        const Ingredient(
          id: 'tg_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.3,
        ),
      ],
    ),
    Recipe(
      id: 'tilapia_starter',
      name: 'Pagkain ng Tilapia (Starter)',
      nameEn: 'Tilapia Starter Feed',
      description:
          'Para sa maliliit na tilapia o fingerlings. Mas pinong giniling para madaling kainin.',
      animalCategory: AnimalCategory.tilapia,
      baseBatchKg: 20,
      ingredients: [
        const Ingredient(
          id: 'ts_darak',
          name: 'Darak (Ipa ng Bigas)',
          nameEn: 'Rice Bran',
          baseWeightKg: 7.0,
        ),
        const Ingredient(
          id: 'ts_dilis',
          name: 'Dilis (Tuyong Isda)',
          nameEn: 'Dried Fish (Dilis)',
          baseWeightKg: 5.0,
        ),
        const Ingredient(
          id: 'ts_mais',
          name: 'Mais (Giling)',
          nameEn: 'Cracked Corn',
          baseWeightKg: 5.5,
        ),
        const Ingredient(
          id: 'ts_malunggay',
          name: 'Malunggay (Tuyong Pulbos)',
          nameEn: 'Dried Moringa',
          baseWeightKg: 2.2,
        ),
        const Ingredient(
          id: 'ts_asin',
          name: 'Asin',
          nameEn: 'Salt',
          baseWeightKg: 0.3,
        ),
      ],
    ),
  ];
}

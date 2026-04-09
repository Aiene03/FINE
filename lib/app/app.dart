import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../core/models/animal_category.dart';
import '../core/services/recipe_service.dart';
import '../core/services/settings_provider.dart';
import '../features/home/home_screen.dart';
import '../features/recipe_book/animal_category_screen.dart';
import '../features/recipe_book/recipe_list_screen.dart';
import '../features/recipe_book/recipe_detail_screen.dart';
import '../features/grind_session/grind_session_screen.dart';
import '../features/grind_session/session_summary_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/history/history_screen.dart';
import 'theme.dart';

final _appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (ctx, state) => const HomeScreen()),
    GoRoute(
      path: '/recipes',
      builder: (ctx, state) => const AnimalCategoryScreen(),
      routes: [
        GoRoute(
          path: ':animal',
          builder: (ctx, state) {
            final animalName = state.pathParameters['animal']!;
            final animal = AnimalCategory.values.firstWhere(
              (a) => a.name == animalName,
              orElse: () => AnimalCategory.manok,
            );
            return RecipeListScreen(animal: animal);
          },
          routes: [
            GoRoute(
              path: ':recipeId',
              builder: (ctx, state) {
                final recipeId = state.pathParameters['recipeId']!;
                final recipeService = ctx.read<RecipeService>();
                final recipe = recipeService.getRecipeById(recipeId);
                if (recipe == null) {
                  return Scaffold(
                    appBar: AppBar(title: const Text('Not Found')),
                    body: const Center(child: Text('Recipe not found.')),
                  );
                }
                return RecipeDetailScreen(recipe: recipe);
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/grind',
      builder: (ctx, state) => const GrindSessionScreen(),
    ),
    GoRoute(
      path: '/grind/summary',
      builder: (ctx, state) => const SessionSummaryScreen(),
    ),
    GoRoute(path: '/settings', builder: (ctx, state) => const SettingsScreen()),
    GoRoute(path: '/history', builder: (ctx, state) => const HistoryScreen()),
  ],
);

class FeedGrinderApp extends StatelessWidget {
  const FeedGrinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    return MaterialApp.router(
      title: 'Feed Grinder',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: settings.themeMode,
      routerConfig: _appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}

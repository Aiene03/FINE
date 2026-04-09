import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'core/services/grind_session_provider.dart';
import 'core/services/recipe_service.dart';
import 'core/services/session_history_service.dart';
import 'core/services/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  final recipeService = RecipeService();
  await recipeService.init();

  final settingsProvider = SettingsProvider();
  await settingsProvider.init();

  final sessionHistoryService = SessionHistoryService();
  await sessionHistoryService.init();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: [
        Provider<RecipeService>.value(value: recipeService),
        Provider<SessionHistoryService>.value(value: sessionHistoryService),
        ChangeNotifierProvider<SettingsProvider>.value(value: settingsProvider),
        ChangeNotifierProvider<GrindSessionProvider>(
          create: (_) => GrindSessionProvider(),
        ),
      ],
      child: const FeedGrinderApp(),
    ),
  );
}

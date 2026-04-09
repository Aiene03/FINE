FINE (Feed Grinder) App - Thesis Documentation
Thesis Objectives
General Objective: To develop a mobile application that assists Filipino farmers in managing animal feed recipes and tracking grinding sessions for livestock (chickens, pigs, ducks, goats, and tilapia).
Specific Objectives:
1.Provide a recipe database for different animal categories with ingredient formulations.
2.Enable farmers to calculate feed batch sizes based on selected recipes.
3.Track grinding session history for production monitoring.
4.Offer a user-friendly interface with bilingual support (English/Tagalog).
5.Provide offline functionality using local storage.

App Flow
1.Home Screen: Dashboard for stats, quick actions, and recent sessions.
2.Recipes: Browse by animal category (Manok, Baboy, Pato, Kambing, Tilapia).
3.Recipe List & Detail: View specific formulations and step-by-step instructions.
4.Grind Session: Start a new session, select a recipe, set batch size (kg), and follow the progress guide.
5.Session Summary: Review completed session details.
6.History: View past activities and production logs.
7.Settings: Toggle theme (Light/Dark) and view app info.

Technology Stack
Framework: Flutter 3.38.7
Language: Dart 3.10.7
State Management: Provider
Database: Hive (Offline-first local storage)
Navigation: GoRouter
UI/UX: Google Fonts (Poppins), Flutter Animate
Target: Android (API 21+) and iOS (12.0+)

Services Architecture
RecipeService: Handles loading, filtering, and counting recipes.
GrindSessionProvider: Manages the active session state and batch calculations.
SessionHistoryService: Manages saving and retrieving completed sessions from Hive.
SettingsProvider: Controls theme modes and app configurations.

Data Structure (Models)
AnimalCategory: Enum for the 5 supported livestock types.
Ingredient: Name and base quantity.
Recipe: Name, description, animal category, and list of ingredients.
GrindSession: Record of recipe used, batch size, and completion timestamp.

Key Features
Batch Calculator: Automatically scales ingredient quantities based on total target weight.
Offline Access: All data is stored locally; no internet required for daily operations.
Bilingual UI: Optimized for local farmers using Tagalog and English.
Color-Coded Categories: Visual cues for easy navigation (e.g., Amber for Chicken, Pink for Pigs).

import 'package:flutter/foundation.dart' as foundation;

import 'models.dart';
import 'recipe_repository.dart';

class AppStateModel extends foundation.ChangeNotifier {
  List<Recipe> _recipes = [];
  List<Recipe> recipeSearch = [];

  List<Recipe> getRecipes() {
    return List.from(_recipes);
  }

  // Search the recipes
  void search(String searchTerms) async {
    recipeSearch.clear();
    try {
      recipeSearch = await RecipesRepository().search(searchTerms);
      notifyListeners();
    } on Exception catch (ex) {}
  }

  // Loads the recipes of available products from the repo.
  void loadRecipes() async {
    try {
      _recipes = await RecipesRepository().fetchRecipes();
      notifyListeners();
    } on Exception catch (ex) {}
  }

  void saveRecipe(Recipe recipe) async {
    final serverRecipe = await RecipesRepository().saveRecipes(recipe);
    _recipes.add(serverRecipe);
    notifyListeners();
  }
}

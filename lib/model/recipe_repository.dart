import 'package:flutter/widgets.dart';

import 'models.dart';

class RecipesRepository {
  static final RecipesRepository _instance = RecipesRepository._internal();

  factory RecipesRepository() {
    return _instance;
  }

  RecipesRepository._internal();

  static var _recipeList = [
    Recipe(
        id: "1",
        numberOfServings: 1,
        title: "Яичница",
        description:
            "Яичница из 2 яиц + 1 ломтик черного хлеба с сыром + свежие овощи",
        tags: ['Breakfast'],
        ingredients: [
          RecipeIngredient(
              id: "1",
              isOptional: false,
              amount: "2 шт.",
              product: Product(id: "1", title: "Яйцо куриное")),
          RecipeIngredient(
              id: "2",
              isOptional: false,
              amount: "2 ломтика.",
              product: Product(id: "2", title: "Тостовый хлеб"),
              description: "Черного или зернового хлеба"),
          RecipeIngredient(
              id: "3",
              isOptional: false,
              amount: "30 гр.",
              product: Product(id: "4", title: "Творожный сыр")),
          RecipeIngredient(
              id: "4",
              isOptional: false,
              amount: "30 гр.",
              product: Product(id: "4", title: "Слабосоленая красная рыба"),
              options: [
                RecipeIngredient(
                  id: "5",
                  isOptional: false,
                  amount: "40 гр.",
                  product: Product(id: "5", title: "Тунец консервированный"),
                ),
                RecipeIngredient(
                    id: "6",
                    isOptional: false,
                    amount: "40 гр.",
                    product: Product(id: "6", title: "Куриное филе"),
                    description: "Вес в сыром виде"),
              ]),
        ],
        instructions: [
          Instruction(order: 0, description: "Пожарить яйчницу"),
          Instruction(order: 1, description: "На хлеб намазать творожный сыр"),
          Instruction(order: 2, description: "На хлеб положить красной рыбы")
        ],
        preparationMinutes: 10,
        cookingMinutes: 10),
    Recipe(
        id: "2",
        numberOfServings: 1,
        title: "Bikini Martini",
        description:
            "An awesome drink to sip by the pool! Garnish with an orange wheel.",
        tags: ['Cocktail'],
        ingredients: [
          RecipeIngredient(
              id: "1",
              isOptional: false,
              amount: "¾ fluid ounce ",
              product: Product(id: "1", title: "vodka")),
          RecipeIngredient(
            id: "2",
            isOptional: false,
            amount: "1 fluid ounce",
            product: Product(id: "2", title: "coconut rum"),
          ),
          RecipeIngredient(
              id: "3",
              isOptional: false,
              amount: "1 fluid ounce",
              product: Product(id: "4", title: "pineapple juice")),
          RecipeIngredient(
              id: "4",
              isOptional: false,
              amount: "1 dash",
              product: Product(id: "4", title: "grenadine syrup")),
        ],
        instructions: [
          Instruction(
              order: 0,
              description:
                  "Combine rum, vodka and pineapple juice in a drink shaker. Shake firmly until frothy. Pour in a martini glass, add a touch of grenadine in the middle. Garnish with an orange wheel."),
        ],
        preparationMinutes: 5,
        cookingMinutes: 5),
    Recipe(
        id: "3",
        numberOfServings: 8,
        title: "100% Fruit 'Cake'",
        description:
            "his cake was a hit with the children and parents at our two-year-old's birthday party. It is perfect for raw, vegan, gluten/wheat-free, refined sugar-free diets (and children who don't need sugar!). This cake was inspired by a 100% watermelon cake we had the year before.",
        tags: ['Cake'],
        ingredients: [
          RecipeIngredient(
              id: "1",
              isOptional: false,
              amount: "1 seedless",
              product: Product(id: "1", title: "watermelon")),
          RecipeIngredient(
              id: "2",
              isOptional: false,
              amount: "2 cups",
              product: Product(id: "2", title: "strawberries"),
              description: "hulled and sliced"),
          RecipeIngredient(
              id: "3",
              isOptional: true,
              amount: "1",
              product: Product(id: "4", title: "cantaloupe"),
              description: "seeded, peeled, and sliced"),
          RecipeIngredient(
              id: "4",
              isOptional: true,
              amount: "1",
              product: Product(id: "4", title: "fresh pineapple"),
              description: "seeded, peeled, and sliced"),
        ],
        instructions: [
          Instruction(
              order: 0,
              description:
                  "To create the base tier of the cake, cut 3 slices of watermelon, 1 to 2 inches thick, crossways through the center of the melon. Trim the rind from the watermelon slices, and place the largest slice onto a cake plate. Alternate layering sliced strawberries, slices of cantaloupe, and slices of fresh pineapple; follow with the second-largest watermelon slice. Repeat once more to make a layered fruit stack that looks like a cake."),
          Instruction(
              order: 1,
              description:
                  "Thinly slice a few pieces of remaining melon and pineapple. With cookie cutters or a sharp knife, cut remaining fruit slices into decorative shapes. Decorate the cake tiers with the cut fruit shapes and remaining berries."),
          Instruction(
              order: 2,
              description:
                  "Refrigerate until serving time. To serve, slice the cake with a sharp knife, one wedge at a time, and set the wedge onto a plate."),
        ],
        preparationMinutes: 30,
        cookingMinutes: 30),
  ];

  Future<List<Recipe>> fetchRecipes() async {
    return List.from(_recipeList);
  }

  Future<Recipe> fetchRecipe(String id) async {
    return _recipeList.firstWhere((element) => element.id == id);
  }

  Future<Recipe> saveRecipes(Recipe recipe) async {
    recipe.id = UniqueKey().toString();
    _recipeList.add(recipe);
    return recipe;
  }

  Future<List<Recipe>> search(String text) async {
    return _recipeList.where((recipe) {
      if (_compareTextForSearch(recipe.title, text)) {
        return true;
      }

      final tag = recipe.tags.firstWhere(
          (tag) => _compareTextForSearch(tag, text),
          orElse: () => '');

      return tag.isNotEmpty;
    }).toList();
  }

  bool _compareTextForSearch(String text, String search) {
    text = text.toLowerCase();
    search = search.toLowerCase();
    return text.indexOf(search) > -1;
  }
}

import 'models.dart';

class ProductsRepository {
  static final ProductsRepository _instance = ProductsRepository._internal();

  factory ProductsRepository() {
    return _instance;
  }

  ProductsRepository._internal();

  static final _recipeList = [
    Recipe(
        id: "1",
        numberOfServings: 1,
        title: "Яичница",
        description:
            "Яичница из 2 яиц + 1 ломтик черного хлеба с сыром + свежие овощи",
        ingredients: [
          RecipeIngredient(
              id: "1",
              isOptional: false,
              ingredient: Ingredient(
                  id: "1",
                  amount: "2 шт.",
                  product: Product(id: "1", title: "Яйцо куриное"))),
          RecipeIngredient(
              id: "2",
              isOptional: false,
              ingredient: Ingredient(
                  id: "2",
                  amount: "2 ломтика.",
                  product: Product(id: "2", title: "Тостовый хлеб"),
                  description: "Черного или зернового хлеба")),
          RecipeIngredient(
              id: "3",
              isOptional: false,
              ingredient: Ingredient(
                  id: "3",
                  amount: "30 гр.",
                  product: Product(id: "4", title: "Творожный сыр"))),
          RecipeIngredient(
              id: "4",
              isOptional: false,
              ingredient: Ingredient(
                id: "4",
                amount: "30 гр.",
                product: Product(id: "4", title: "Слабосоленая красная рыба"),
              ),
              options: [
                Ingredient(
                  id: "5",
                  amount: "40 гр.",
                  product: Product(id: "5", title: "Тунец консервированный"),
                ),
                Ingredient(
                    id: "6",
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
  ];

  Future<List<Recipe>> fetchRecipes() async {
    return List.from(_recipeList);
  }

  Future<Recipe> fetchRecipe(String id) async {
    return _recipeList.first;
  }
}

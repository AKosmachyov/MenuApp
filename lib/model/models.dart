// enum Category {
//   all,
//   accessories,
//   clothing,
//   home,
// }

// class Product {
//   const Product({
//     required this.category,
//     required this.id,
//     required this.isFeatured,
//     required this.name,
//     required this.price,
//   });

//   final Category category;
//   final int id;
//   final bool isFeatured;
//   final String name;
//   final int price;

//   String get assetName => '$id-0.jpg';
//   String get assetPackage => 'shrine_images';

//   @override
//   String toString() => '$name (id=$id)';
// }

class Recipe {
  Recipe(
      {required this.id,
      required this.numberOfServings,
      required this.title,
      required this.description,
      this.preparationMinutes,
      this.cookingMinutes,
      required this.ingredients,
      required this.instructions});

  final String id;
  final int numberOfServings;
  final String title;
  final String description;

  int? preparationMinutes;
  int? cookingMinutes;

  List<RecipeIngredient> ingredients;
  List<Instruction> instructions;

  int get totalTime => preparationMinutes ?? 0 + (cookingMinutes ?? 0);
}

class RecipeIngredient {
  RecipeIngredient(
      {required this.id,
      required this.amount,
      required this.product,
      this.description,
      required this.isOptional,
      this.options});

  final String id;
  final String amount;
  final Product product;
  String? description;
  final bool isOptional;
  List<RecipeIngredient>? options;
}

class Product {
  const Product({required this.id, required this.title});

  final String id;
  final String title;
  // image: string;
  // unit: Enum;
}

class Instruction {
  const Instruction({required this.order, required this.description});

  final int order;
  final String description;
}

import 'package:flutter/widgets.dart';

class Recipe {
  Recipe(
      {required this.id,
      required this.numberOfServings,
      required this.title,
      required this.description,
      this.preparationMinutes,
      this.cookingMinutes,
      this.tags = const [],
      required this.ingredients,
      required this.instructions});

  String id;
  int numberOfServings;
  String title;
  String description;

  int? preparationMinutes;
  int? cookingMinutes;

  List<String> tags;
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
  String amount;
  final Product product;
  String? description;
  final bool isOptional;
  List<RecipeIngredient>? options;

  static RecipeIngredient empty() {
    return RecipeIngredient(
      id: UniqueKey().toString(),
      isOptional: false,
      amount: '',
      product: Product(id: UniqueKey().toString(), title: ''),
    );
  }
}

class Product {
  Product({required this.id, required this.title});

  final String id;
  String title;
  // image: string;
  // unit: Enum;
}

class Instruction {
  const Instruction({required this.order, required this.description});

  final int order;
  final String description;
}

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

  factory Recipe.fromJson(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      numberOfServings: map['numberOfServings'],
      title: map['title'],
      description: map['description'],
      preparationMinutes: map['preparationMinutes'],
      cookingMinutes: map['cookingMinutes'],
      tags: List<String>.from(map['tags']),
      ingredients: (map['ingredients'] as List)
          .map((e) => RecipeIngredient.fromJson(e))
          .toList(),
      instructions: (map['instructions'] as List)
          .map((e) => Instruction.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': 'id',
        'numberOfServings': numberOfServings,
        'title': title,
        'description': description,
        'preparationMinutes': preparationMinutes,
        'cookingMinutes': cookingMinutes,
        'tags': tags,
        'ingredients': ingredients.map((e) => e.toJson()).toList(),
        'instructions': instructions.map((e) => e.toJson()).toList(),
      };
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

  factory RecipeIngredient.fromJson(Map<String, dynamic> map) {
    final options = map['options'];
    final optionParsed = options != null
        ? (options as List).map((e) => RecipeIngredient.fromJson(e)).toList()
        : null;
    return RecipeIngredient(
      id: map['id'],
      amount: map['amount'],
      product: Product.fromJson(map['product']),
      description: map['description'],
      isOptional: map['isOptional'],
      options: optionParsed,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'product': product.toJson(),
        'description': description,
        'isOptional': isOptional,
        'options':
            options != null ? options!.map((e) => e.toJson()).toList() : null,
      };
}

class Product {
  Product({required this.id, required this.title});

  final String id;
  String title;
  // image: string;
  // unit: Enum;

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
      };
}

class Instruction {
  const Instruction({required this.order, required this.description});

  final int order;
  final String description;

  factory Instruction.fromJson(Map<String, dynamic> map) {
    return Instruction(
      order: map['order'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toJson() => {
        'order': order,
        'description': description,
      };
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:menu_app/model/models.dart';
import 'package:menu_app/model/products_repository.dart';
import 'package:menu_app/styles.dart';

class RecipeDetailsPage extends StatefulWidget {
  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  Future<Recipe>? futureRecipe;
  int _segmentIndex = 0;

  @override
  void initState() {
    super.initState();
    futureRecipe = ProductsRepository().fetchRecipe("123");
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(middle: Text("Details")),
        child: FutureBuilder<Recipe>(
          future: futureRecipe,
          builder: (context, snapshot) {
            late final Widget pageContent;

            if (snapshot.hasData) {
              pageContent = _buildPageContent(snapshot.data!);
            } else if (snapshot.hasError) {
              pageContent = Center(child: Text("Error"));
            } else {
              pageContent = CircularProgressIndicator();
            }

            return SafeArea(child: pageContent);
          },
        ));
  }

  Widget _buildPageContent(Recipe recipe) {
    var selectedPage = _segmentIndex == 0
        ? _buildIngredientList(recipe)
        : _buildInstructionList(recipe);

    return SingleChildScrollView(
        child: Column(
      children: [
        _buildInfoCard(recipe),
        CupertinoSlidingSegmentedControl(
          groupValue: _segmentIndex,
          children: {
            0: Text('Ingredients'),
            1: Text('Instructions'),
            // 2: Text('Review'),
          },
          onValueChanged: (int? newValue) {
            if (newValue == null) {
              return;
            }
            setState(() {
              _segmentIndex = newValue;
            });
          },
        ),
        SizedBox(height: 10),
        selectedPage
      ],
    ));
  }

  Widget _buildInfoCard(Recipe recipe) {
    var stars = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(CupertinoIcons.star_fill, size: 14, color: Styles.raitingColor),
        Icon(CupertinoIcons.star_fill, size: 14, color: Styles.raitingColor),
        Icon(CupertinoIcons.star_fill, size: 14, color: Styles.raitingColor),
        Icon(CupertinoIcons.star_lefthalf_fill,
            size: 14, color: Styles.raitingColor),
        Icon(CupertinoIcons.star, size: 14, color: Styles.raitingColor),
        SizedBox(width: 5),
        Text("(1.832)",
            style:
                const TextStyle(color: Styles.textSecondaryColor, fontSize: 14))
      ],
    );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Styles.backgroundPrimaryColor,
        boxShadow: [Styles.boxShadow],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(recipe.title, style: Styles.headerTextStyle),
        const SizedBox(height: 5),
        // TODO use author from recipe
        Text(
          "by Author",
          style:
              const TextStyle(color: Styles.textSecondaryColor, fontSize: 16),
        ),
        const SizedBox(height: 5),
        stars,
        Divider(color: Styles.textSecondaryColor),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildInfoCardIcon(
                CupertinoIcons.clock, recipe.totalTime.toString(), "minutes"),
            // TODO icons
            _buildInfoCardIcon(CupertinoIcons.ant,
                recipe.numberOfServings.toString(), "servings"),
            _buildInfoCardIcon(CupertinoIcons.rays,
                recipe.instructions.length.toString(), "steps"),
          ],
        )
      ]),
    );
  }

  Widget _buildInfoCardIcon(IconData icon, String value, String description) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Icon(icon, size: 18),
      const SizedBox(width: 3),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: Styles.headerTextStyle),
          Text(
            description,
            style:
                const TextStyle(color: Styles.textSecondaryColor, fontSize: 16),
          )
        ],
      )
    ]);
  }

  Widget _buildInstructionList(Recipe recipe) {
    return Column(children: [
      for (var item in recipe.instructions) _buildInstructionRow(item)
    ]);
  }

  Widget _buildInstructionRow(Instruction instruction) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Styles.backgroundPrimaryColor,
          boxShadow: [Styles.boxShadow],
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            instruction.order.toString(),
            style: TextStyle(
              color: Styles.primaryColor,
              fontSize: 30,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(instruction.description, style: Styles.headerTextStyle)
            ],
          ))
        ]));
  }

  Widget _buildIngredientList(Recipe recipe) {
    return Column(children: [
      for (var item in recipe.ingredients) _buildIngredientsRow(item)
    ]);
  }

  Widget _buildIngredientsRow(RecipeIngredient recipeIngredient) {
    var icon = Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Styles.backgroundPrimaryColor,
          boxShadow: [Styles.boxShadow],
        ),
        child: Icon(
          CupertinoIcons.leaf_arrow_circlepath,
          size: 40,
        ));

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          icon,
          SizedBox(width: 10),
          Expanded(
              child: Text(recipeIngredient.product.title,
                  style: Styles.headerTextStyle)),
          SizedBox(width: 10),
          Text(recipeIngredient.amount, style: Styles.headerTextStyle),
        ]));
  }
}

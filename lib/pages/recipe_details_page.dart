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
  int _sliding = 0;

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
    // return CupertinoSlidingSegmentedControl(
    //     children: {
    //       0: Text('Ingredients'),
    //       1: Text('Direction'),
    //       2: Text('Review'),
    //     },
    //     groupValue: _sliding,
    //     onValueChanged: (newValue) {
    //       // setState(() {
    //       //   _sliding = newValue.;
    //       // });
    //     });

    return SingleChildScrollView(
      child: Column(
        children: [
          _buildInfoCard(recipe),
          Text("qweqe"),
          SizedBox(height: 700),
          Container(
            child: Text("12313"),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(Recipe recipe) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        color: Colors.white,
        boxShadow: [
          const BoxShadow(
            color: const Color.fromARGB(30, 0, 0, 0),
            offset: const Offset(0, 10),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(recipe.title, style: Styles.headerTextStyle),
        // TODO use author from recipe
        Text(
          "by Author",
          style:
              const TextStyle(color: Styles.textSecondaryColor, fontSize: 16),
        ),
        // TODO raiting bar
        Divider(),
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
}

// class RecipeDetailsPage extends StatelessWidget {
//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(middle: Text("Details")),
//       child: Center(
//         child: Text("Test"),
//       ),
//     );
//     // return Consumer<AppStateModel>(
//     //   builder: (context, model, child) {
//     //     final recipes = model.getRecipes();

//     //     // return CustomScrollView(
//     //     //   semanticChildCount: recipes.length,
//     //     //   slivers: <Widget>[
//     //     //     const CupertinoSliverNavigationBar(
//     //     //       largeTitle: Text('Recipe'),
//     //     //     ),
//     //     //     // SliverSafeArea(
//     //     //     //   top: false,
//     //     //     //   minimum: const EdgeInsets.only(top: 8),
//     //     //     // ),
//     //     //   ],
//     //     // );
//     //   },
//     // );
//   }
// }

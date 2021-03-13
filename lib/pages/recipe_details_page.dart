import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/model/models.dart';
import 'package:menu_app/model/products_repository.dart';
import 'package:provider/provider.dart';

import 'package:menu_app/model/app_state_model.dart';

class RecipeDetailsPage extends StatefulWidget {
  @override
  _RecipeDetailsPageState createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
  Future<Recipe>? futureRecipe;

  @override
  void initState() {
    super.initState();
    futureRecipe = ProductsRepository().fetchRecipe("123");
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text("Details")),
      child: Center(
        child: Text("213"),
      ),
      // child: FutureBuilder<Recipe>(
      //   future: futureRecipe,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return Text("213123");
      //     } else if (snapshot.hasError) {
      //       return Text("Error");
      //     }

      //     return CircularProgressIndicator();
      //   },
      // )
    );
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

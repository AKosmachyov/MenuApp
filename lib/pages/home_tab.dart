import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../model/app_state_model.dart';
import 'package:menu_app/components/recipe_list_row_item.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child) {
        final recipes = model.getRecipes();
        return CupertinoPageScaffold(
            child: CustomScrollView(
          semanticChildCount: recipes.length,
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              largeTitle: Text('Cupertino Store'),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 8),
              sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                if (index < recipes.length) {
                  return RecipeListRowItem(
                      recipe: recipes[index],
                      isLastItem: index == recipes.length);
                }
                return null;
              })),
            ),
          ],
        ));
      },
    );
  }
}

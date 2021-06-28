import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/app_state_model.dart';
import 'package:menu_app/components/recipe_list_row_item.dart';

import 'info_page.dart';

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
            CupertinoSliverNavigationBar(
              largeTitle: Text('Recipes'),
              trailing: CupertinoButton(
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (context) => InfoPage()));
                },
                child: Icon(
                  CupertinoIcons.info,
                ),
              ),
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

import 'package:flutter/cupertino.dart';
import 'package:menu_app/pages/recipe_details_page.dart';
import 'package:provider/provider.dart';

import 'package:menu_app/model/models.dart';

// import 'model/app_state_model.dart';
// import 'model/models.dart';
import '../styles.dart';

class RecipeListRowItem extends StatelessWidget {
  const RecipeListRowItem({required this.recipe, required this.isLastItem});

  final Recipe recipe;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: const EdgeInsets.only(
        left: 16,
        top: 8,
        bottom: 8,
        right: 8,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                recipe.title,
                style: Styles.productRowItemName,
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => RecipeDetailsPage()));
            },
            child: const Icon(
              CupertinoIcons.chevron_right,
              semanticLabel: 'Open',
            ),
          ),
        ],
      ),
    );

    if (isLastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Styles.productRowDivider,
          ),
        ),
      ],
    );
  }
}

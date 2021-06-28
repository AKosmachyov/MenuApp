import 'package:flutter/cupertino.dart';
import 'package:menu_app/components/recipe_list_row_item.dart';
import 'package:provider/provider.dart';

import '../model/app_state_model.dart';
import '../search_bar.dart';
import '../styles.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });

    if (_terms.length > 2) {
      final model = Provider.of<AppStateModel>(context, listen: false);
      model.search(_terms);
    }
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SearchBar(
        controller: _controller,
        focusNode: _focusNode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<AppStateModel>(context);
    final result = model.recipeSearch;

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: [
            _buildSearchBox(),
            Expanded(
              child: ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return RecipeListRowItem(
                        recipe: result[index],
                        isLastItem: index == result.length);
                  }

                  // ProductRowItem(
                  //     product: result[index], lastItem: index == result.length - 1),
                  // itemCount: result.length,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

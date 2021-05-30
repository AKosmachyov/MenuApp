import 'package:flutter/cupertino.dart';
import 'package:menu_app/model/app_state_model.dart';
import 'package:menu_app/model/models.dart';
import 'package:menu_app/styles.dart';
import 'package:provider/provider.dart';

final inputPadding = const EdgeInsets.symmetric(vertical: 15, horizontal: 30);
final inputDecoration = BoxDecoration(
  border: Border.all(width: 0.5, color: Styles.textSecondaryColor),
  borderRadius: BorderRadius.circular(32.0),
);
final offsetBox = const SizedBox(height: 14);

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  // final _formKey = GlobalKey<FormState>(debugLabel: "Add recipe form");
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();

  List<TextEditingController> _ingredientControllerList = [
    TextEditingController()
  ];
  List<TextEditingController> _stepControllerList = [TextEditingController()];

  void addIngredient() {
    setState(() {
      _ingredientControllerList.add(TextEditingController());
    });
  }

  void addStep() {
    setState(() {
      _stepControllerList.add(TextEditingController());
    });
  }

  void saveRecipe() {
    final model = Provider.of<AppStateModel>(context, listen: false);
    String title = _titleController.text;
    if (title.trim().isEmpty) {
      final now = DateTime.now();
      final date = now.day.toString().padLeft(2, '0') +
          '-' +
          now.month.toString().padLeft(2, '0') +
          '-' +
          now.year.toString();
      final time = now.hour.toString() + '-' + now.minute.toString();
      title = date + ' ' + time;
    }

    final tags = _tagsController.text
        .split(',')
        .map((el) => el.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();

    final ingredients = _ingredientControllerList
        .map((el) => el.text.trim())
        .where((ingredient) => ingredient.isNotEmpty)
        .map((ingredient) => RecipeIngredient(
            id: UniqueKey().toString(),
            isOptional: false,
            amount: "2 шт.",
            product: Product(id: UniqueKey().toString(), title: ingredient)))
        .toList();

    int stepNumber = -1;
    final instructions = _stepControllerList
        .map((el) => el.text.trim())
        .where((instruction) => instruction.isNotEmpty)
        .map((instruction) {
      stepNumber += 1;
      return Instruction(order: stepNumber, description: instruction);
    }).toList();

    final recipe = Recipe(
        id: '',
        numberOfServings: 1,
        title: title,
        description: _descriptionController.text,
        tags: tags,
        ingredients: ingredients,
        instructions: instructions,
        preparationMinutes: 10,
        cookingMinutes: 10);

    model.saveRecipe(recipe);
    resetForm();
  }

  void resetForm() {
    setState(() {
      [_titleController, _descriptionController, _tagsController]
          .forEach((list) {
        list.clear();
      });
      [_ingredientControllerList, _stepControllerList].forEach((list) {
        list.clear();
        list.add(TextEditingController());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          CupertinoSliverNavigationBar(largeTitle: Text('Add recipe'))
        ];
      },
      body: SafeArea(
          top: false,
          minimum: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            // key: _formKey,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(List.from([
                    offsetBox,
                    Text("Info", style: Styles.headerTextStyle),
                    CupertinoTextField(
                      placeholder: "Title",
                      controller: _titleController,
                      padding: inputPadding,
                      decoration: inputDecoration,
                    ),
                    offsetBox,
                    CupertinoTextField(
                      placeholder: "Description",
                      controller: _descriptionController,
                      padding: inputPadding,
                      decoration: inputDecoration,
                      maxLines: 5,
                    ),
                    offsetBox,
                    CupertinoTextField(
                      placeholder: "Tags(Breakfast, cakes, ...)",
                      controller: _tagsController,
                      padding: inputPadding,
                      decoration: inputDecoration,
                    ),
                    offsetBox,
                    Text(
                      "Ingredients",
                      style: Styles.headerTextStyle,
                    ),
                    offsetBox,
                  ])),
                ),
                SliverFixedExtentList(
                  itemExtent: 68,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index == _ingredientControllerList.length) {
                        return CupertinoButton(
                            child: Text('Add'), onPressed: addIngredient);
                      }

                      final placeholder = 'Item ' + (index + 1).toString();
                      final textController = _ingredientControllerList[index];
                      return buildCell(textController, placeholder);
                    },
                    childCount: _ingredientControllerList.length + 1,
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                  List.from([
                    offsetBox,
                    Text(
                      "Instructions",
                      style: Styles.headerTextStyle,
                    ),
                    offsetBox,
                  ]),
                )),
                SliverFixedExtentList(
                  itemExtent: 68,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      if (index == _stepControllerList.length) {
                        return CupertinoButton(
                            child: Text('Add'), onPressed: addStep);
                      }

                      final placeholder = 'Step ' + (index + 1).toString();
                      final textController = _stepControllerList[index];
                      return buildCell(textController, placeholder);
                    },
                    childCount: _stepControllerList.length + 1,
                  ),
                ),
                SliverList(
                    delegate: SliverChildListDelegate(
                  List.from([
                    offsetBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoButton.filled(
                            onPressed: saveRecipe, child: Text('Save'))
                      ],
                    ),
                    offsetBox,
                  ]),
                )),
              ],
            ),
          )),
    ));
  }

  Widget buildCell(TextEditingController controller, String placeholder) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: CupertinoTextField(
          placeholder: placeholder,
          controller: controller,
          padding: inputPadding,
          decoration: inputDecoration,
        ));
  }
}

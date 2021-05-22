import 'package:flutter/cupertino.dart';
import 'package:menu_app/styles.dart';

class AddRecipePage extends StatefulWidget {
  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Add recipe"),
        ),
        child: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Info",
                            style: Styles.headerTextStyle,
                          ),
                          CupertinoTextField(
                            placeholder: "Title",
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            onChanged: (v) {
                              print(v);
                            },
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Styles.textSecondaryColor,
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          CupertinoTextField(
                            placeholder: "Time",
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                            onChanged: (v) {
                              print(v);
                            },
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color: Styles.textSecondaryColor,
                              ),
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                          CupertinoTimerPicker(
                            mode: CupertinoTimerPickerMode.hm,
                            onTimerDurationChanged: (value) {
                              print(value);
                            },
                          )
                          // Cuppertino
                          // CupertinoTimerPicker(onTimerDurationChanged: onTimerDurationChanged)
                          // CupertinoPicker(itemExtent: itemExtent, onSelectedItemChanged: onSelectedItemChanged, children: children)
                        ])))));
    // Row(children: [
    // Expanded(
    // CupertinoTextField(placeholder: "Item 1"),
    // ),
    // CupertinoTextField(placeholder: "123"),
    // ]),
    // ]),
    // child: Form(
    //     key: _formKey,
    //     child: Column(children: [

    //       // CupertinoTextField(placeholder: "Time"),
    //       // CupertinoTextField(placeholder: "Number of people"),
    //       // CupertinoTextField(placeholder: "Category"),
    //       // CupertinoTextField(placeholder: "Description"),
    //       // Text("Ingredients"),
    //       Row(children: [
    //         Expanded(
    //           child: CupertinoTextField(placeholder: "Item 1"),
    //         ),
    //         CupertinoTextField(placeholder: "123"),
    //       ]),
    //       // Row(children: [
    //       //   CupertinoTextField(placeholder: "Item 1"),
    //       //   CupertinoTextField(placeholder: "123"),
    //       // ]),
    //       // Text("Instructions"),
    //       // CupertinoTextField(placeholder: "Step 1"),
    //       // CupertinoTextField(placeholder: "Step 2"),
    //       // CupertinoTextField(placeholder: "Step 3"),
    //     ])),
  }
}

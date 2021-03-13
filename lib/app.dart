import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'pages/home_tab.dart';
import 'pages/search_tab.dart';
// import 'pages/shopping_cart_tab.dart';

class CupertinoStoreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // This app is designed only to work vertically, so we limit
    // orientations to portrait up and down.
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return CupertinoApp(
      theme: const CupertinoThemeData(brightness: Brightness.light),
      home: CupertinoStoreHomePage(),
    );
  }
}

class CupertinoStoreHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CupertinoIcons.shopping_cart),
          //   label: 'Cart',
          // ),
        ],
      ),
      tabBuilder: (context, index) {
        late final CupertinoTabView returnValue;
        switch (index) {
          case 0:
            returnValue = CupertinoTabView(builder: (context) => HomeTab());
            break;
          case 1:
            returnValue = CupertinoTabView(builder: (context) => SearchTab());
            break;
          // case 2:
          //   returnValue = CupertinoTabView(builder: (context) {
          //     return CupertinoPageScaffold(
          //       child: ShoppingCartTab(),
          //     );
          //   });
          //   break;
        }
        return returnValue;
      },
    );
  }
}

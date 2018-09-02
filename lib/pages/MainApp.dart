import 'package:Gank.io/common/Constants.dart';
import 'package:Gank.io/pages/cate/CatePage.dart';
import 'package:Gank.io/pages/home/HomePage.dart';
import 'package:Gank.io/pages/profile/ProfilePage.dart';
import 'package:flutter/material.dart';

class MainApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _MainAppState();
  }
}

class _MainAppState extends State<MainApp> with SingleTickerProviderStateMixin {
  int _page = 0;
  PageController pageController;
  String title = Constants.tabHome;

  final List<BottomNavigationBarItem> _bottomBars = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: new Text(Constants.tabHome),
        backgroundColor: Colors.lightBlue),
    new BottomNavigationBarItem(
        icon: new Icon(Icons.category),
        title: new Text(Constants.tabCate),
        backgroundColor: Colors.lightBlue),
    new BottomNavigationBarItem(
        icon: new Icon(Icons.person),
        title: new Text(Constants.tabProfile),
        backgroundColor: Colors.lightBlue),
  ];

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: this._page);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text(title),
          centerTitle: true,
        ),
        body: new PageView(
          controller: pageController,
          physics: new NeverScrollableScrollPhysics(),
          children: <Widget>[HomePage(), CatePage(), ProfilePage()],
          onPageChanged: _onPageChange,
        ),
        bottomNavigationBar: new BottomNavigationBar(
          items: _bottomBars,
          currentIndex: _page,
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.blue,
          onTap: _changeItem,
        ),
      ),
    );
  }

  void _changeItem(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  void _onPageChange(int index) {
    setState(() {
      this._page = index;
      switch (index) {
        case 0:
          title = Constants.tabHome;
          break;
        case 1:
          title = Constants.tabCate;
          break;
        case 2:
          title = Constants.tabProfile;
          break;
        default:
          break;
      }
    });
  }
}

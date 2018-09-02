import 'package:Gank.io/pages/cate/CateTabPage.dart';
import 'package:flutter/material.dart';

class CatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CatePageState();
  }
}

class CatePageState extends State<CatePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  CateTabPage cateTabPage;
  List<CateTabPage> cateTabs;

  @override
  void initState() {
    super.initState();
    cateTabPage = new CateTabPage();
    cateTabs = cateTabPage.initCate();
    _tabController = new TabController(vsync: this, length: cateTabs.length);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new TabBar(
          controller: _tabController,
          tabs: cateTabs.map((CateTabPage page) {
            return new Tab(
              text: page.text,
            );
          }).toList(),
          indicatorColor: Theme.of(context).primaryColor,
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
        ),
      ),
      body: new TabBarView(
          controller: _tabController,
          children: cateTabs.map((CateTabPage page) {
            return page.detailPage;
          }).toList()),
    );
  }
}

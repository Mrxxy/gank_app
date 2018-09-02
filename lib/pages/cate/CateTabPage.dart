import 'package:Gank.io/pages/detail/DetailPage.dart';
import 'package:flutter/material.dart';

class CateTabPage {
  final IconData icon;
  final String text;
  final DetailPage detailPage;

  CateTabPage({this.icon, this.text, this.detailPage});

  List<CateTabPage> initCate() {
    return <CateTabPage>[
      new CateTabPage(
          text: "all",
          detailPage: new DetailPage(
            feedType: ('all'),
            showTitle: false,
          )),
      new CateTabPage(
          text: "Android",
          detailPage: new DetailPage(
            feedType: ('Android'),
            showTitle: false,
          )),
      new CateTabPage(
          text: "瞎推荐",
          detailPage: new DetailPage(
            feedType: ('瞎推荐'),
            showTitle: false,
          )),
      new CateTabPage(
          text: "iOS",
          detailPage: new DetailPage(
            feedType: ('iOS'),
            showTitle: false,
          )),
      new CateTabPage(
          text: "前端",
          detailPage: new DetailPage(
            feedType: ('前端'),
            showTitle: false,
          )),
      new CateTabPage(
          text: "拓展资源",
          detailPage: new DetailPage(
            feedType: ('拓展资源'),
            showTitle: false,
          )),
      new CateTabPage(
          text: "App",
          detailPage: new DetailPage(
            feedType: ('App'),
            showTitle: false,
          )),
      new CateTabPage(
          text: "休息视频",
          detailPage: new DetailPage(
            feedType: ('休息视频'),
            showTitle: false,
          )),
      new CateTabPage(
          text: "福利",
          detailPage: new DetailPage(
            feedType: ('福利'),
            showTitle: false,
          ))
    ];
  }
}

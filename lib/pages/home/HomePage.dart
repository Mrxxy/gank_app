import 'dart:async';
import 'dart:convert';

import 'package:Gank.io/api/Api.dart';
import 'package:Gank.io/api/HttpUtil.dart';
import 'package:Gank.io/common/CommonBuild.dart';
import 'package:Gank.io/model/TodayResp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  ScrollController _controller = new ScrollController();
  var _dataList;
  bool requestError = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('init');
    getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new RefreshIndicator(
          child: requestError
              ? buildExceptionIndicator('网络请求错误')
              : _dataList == null
                  ? new Center(
                      child: new CupertinoActivityIndicator(),
                    )
                  : buildListViewBuilder(
                      context,
                      _dataList,
                      _controller,
                    ),
          onRefresh: _pullToRefresh),
    );
  }

  Future<void> _pullToRefresh() async {
    getDataList();
  }

  void getDataList() {
    List content = new List();
    List title = new List();
    HttpUtil.get(Api.todayUrl, (data) {
      if (data != null) {
        print('home get data $data');
        TodayResp resp = TodayResp.fromJson(jsonDecode(data));
        if (!resp.error) {
          resp.category.forEach((row) {
            if (row == '福利') {
//              title.insert(0, row);
            } else {
              title.add(row);
            }
          });
          title.forEach((title) {
            content.addAll(resp.results[title]);
          });
          if (content.isNotEmpty) {
            setState(() {
              _dataList = content;
            });
          }
        }
      }
    }, (error) {
      print('error $error');
      setState(() {
        requestError = true;
      });
    });
  }
}

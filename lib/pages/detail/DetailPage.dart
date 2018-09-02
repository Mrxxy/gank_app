import 'dart:async';
import 'dart:convert';

import 'package:Gank.io/api/Api.dart';
import 'package:Gank.io/api/HttpUtil.dart';
import 'package:Gank.io/common/CommonBuild.dart';
import 'package:Gank.io/model/CateResp.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DetailPage extends StatefulWidget {
  String feedType;
  bool showTitle = false;

  DetailPage({Key key, this.feedType, this.showTitle}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  var listData;
  var curPage = 1;
  var listTotalSize = 0;
  var requestError = false;
  ScrollController _controller = new ScrollController();

  @override
  void initState() {
    super.initState();
    getDataList(false);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showTitle) {
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(widget.feedType),
        ),
      );
    } else {
      return new Scaffold(
        body: buildDetail(context),
      );
    }
  }

  Widget buildDetail(BuildContext context) {
    return requestError
        ? buildExceptionIndicator("网络请求出错了！")
        : listData == null
            ? new Center(
                child: new CupertinoActivityIndicator(),
              )
            : new RefreshIndicator(
                child: buildListViewBuilder(context, listData, _controller),
                onRefresh: _pullToRefresh);
  }

  Future<void> _pullToRefresh() async {
    curPage = 1;
    getDataList(false);
  }

  _DetailPageState() {
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        curPage++;
        getDataList(true);
      }
    });
  }

  void getDataList(bool isLoadMore) {
    var url = Api.feedUrl;
    url += widget.feedType + '/10/' + this.curPage.toString();
    print('requets url $url');
    HttpUtil.get(url, (data) {
      if (data != null) {
        CateResp cateResp = CateResp.fromJson(jsonDecode(data));
        print('resp is $cateResp');
        if (!cateResp.error) {
          var _listData = cateResp.results;
          if (_listData.isNotEmpty) {
            setState(() {
              if (!isLoadMore) {
                listData = _listData;
              } else {
                List list = new List();
                list.addAll(listData);
                list.addAll(_listData);
                listData = list;
              }
            });
          }
        }
      }
    }, (error) {
      setState(() {
        requestError = true;
        print('request erro: $error');
      });
    });
  }
}

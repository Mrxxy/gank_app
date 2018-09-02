import 'package:Gank.io/common/WebViewPage.dart';
import 'package:Gank.io/model/PostBean.dart';
import 'package:Gank.io/utils/TimeUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildExceptionIndicator(String content) {
  return new Center(
    child: new Text(content),
  );
}

Widget buildListViewBuilder(
    BuildContext context, List results, ScrollController controller) {
  if (results.length == 0) {
    return new Center(
      child: new Text("暂无数据"),
    );
  } else {
    return new ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(2.0),
      controller: controller,
      itemCount: results == null ? 0 : results.length,
      itemBuilder: (BuildContext context, int index) {
        PostBean postBean = PostBean.fromJson(results[index]);
        return buildRow(context, postBean);
      },
    );
  }
}

Widget buildRow(BuildContext context, PostBean postBean) {
  if (postBean.type == '福利') {
    return buildImageRow(context, postBean);
  } else {
    return buildCommonRow(context, postBean);
  }
}

Widget buildImageRow(BuildContext context, PostBean postBean) {
  return new InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(postBean.url, postBean.desc);
        }));
      },
      child: new Card(
        margin: new EdgeInsets.all(2.0),
        child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new SizedBox(
              height: 300.0,
              child: new Stack(
                children: <Widget>[
                  new Positioned.fill(
                      child: new FadeInImage.assetNetwork(
                    placeholder: '暂无',
                    image: postBean.url,
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  )),
                  new Positioned(
                    bottom: 6.0,
                    left: 6.0,
                    right: 6.0,
                    child: new FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.bottomRight,
                      child: new Text(
                        postBean.desc,
                        style:
                            new TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ));
}

Widget buildCommonRow(BuildContext context, PostBean postBean) {
  return new InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
          return new WebViewPage(postBean.url, postBean.desc);
        }));
      },
      child: new Card(
        margin: new EdgeInsets.all(2.0),
        child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            children: <Widget>[
              new Row(children: [
                new Container(
                  margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 4.0),
                  child: new Align(
                    alignment: Alignment.centerLeft,
                    child: new Icon(
                      Icons.access_time,
                      size: 12.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
                new Text(
                  postBean.publishedAt.split('T')[0],
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                new Expanded(
                    child: new Align(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    getTimestampString(DateTime.parse(postBean.publishedAt)),
                    style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                )),
              ]),
              new Container(
                margin: new EdgeInsets.fromLTRB(2.0, 4.0, 2.0, 14.0),
                child: new Align(
                  alignment: Alignment.centerLeft,
                  child: new Text(
                    postBean.desc,
                    style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              new Row(children: [
                new Text(
                  '作者:',
                  style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                ),
                new Text(
                  postBean.who.toString(),
                  style: new TextStyle(fontSize: 12.0, color: Colors.blue),
                ),
                new Expanded(
                    child: new Align(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    postBean.type.toString(),
                    style: new TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                )),
              ]),
            ],
          ),
        ),
      ));
}

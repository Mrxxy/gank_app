import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

// ignore: must_be_immutable
class WebViewPage extends StatefulWidget {
  String url;
  String title;

  WebViewPage(this.url, this.title);

  @override
  State<StatefulWidget> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  FlutterWebviewPlugin webviewPlugin = new FlutterWebviewPlugin();

  @override
  void dispose() {
    // TODO: implement dispose
    webviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      withJavascript: true,
      withLocalStorage: true,
      withZoom: true,
      appBar: new AppBar(
        title: new Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.refresh), onPressed: _refresh)
        ],
      ),
    );
  }

  _refresh() {
    webviewPlugin.reload();
  }
}

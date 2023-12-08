import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  var initialUrl = "https://invoport.com/";
  double _progress = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              webViewController?.reload();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(initialUrl),
              ),
              onWebViewCreated: (controller) {
                webViewController = controller;
              },
              pullToRefreshController: refreshController,
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
          ),
          LinearProgressIndicator(
            value: _progress,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  var initialUrl = "https://invoport.com/";
  RxDouble progress = 0.0.obs;

  void reloadWebView() {
    webViewController?.reload();
  }

  @override
  void onInit() {
    super.onInit();
  }
}



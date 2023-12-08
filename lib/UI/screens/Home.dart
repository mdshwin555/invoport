import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import '../../controller/Home/HomeController.dart';

class Home extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.reloadWebView();

            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(controller.initialUrl),
              ),
              onWebViewCreated: (controller) {
                Get.find<HomeController>().webViewController = controller;
              },
              pullToRefreshController:
                  Get.find<HomeController>().refreshController,
              onProgressChanged: (controller, progress) {
                Get.find<HomeController>().progress.value = progress / 100;
              },
            ),
          ),
          Obx(
            () => LinearProgressIndicator(
              value: controller.progress.value,
            ),
          ),
        ],
      ),
    );
  }
}

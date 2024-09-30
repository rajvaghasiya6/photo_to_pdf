import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:imagetopdf/utils/app_loader.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyWebView extends StatefulWidget {
  final String webURL;
  final String? title;
  final Widget? myWidget;

  const MyWebView({
    super.key,
    required this.webURL,
    this.title,
    this.myWidget,
  });

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController controller;
  RxBool isLoading = true.obs;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            isLoading.value = false;
          },
          onUrlChange: (UrlChange change) {},
          onWebResourceError: (WebResourceError error) {
            isLoading.value = false;
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webURL));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.title != '' || widget.title != null
          ? AppBar(
              centerTitle: false,
              title: Text(widget.title ?? ""),
            )
          : null,
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: isLoading.isFalse
              ? WebViewWidget(
                  controller: controller,
                )
              : const AppLoader(),
        ),
      ),
    );
  }
}

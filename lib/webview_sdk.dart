library webview_sdk;

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewSdk extends StatefulWidget {
  final String token;
  final bool enableJavaScript;

  const WebViewSdk({
    Key? key,
    required this.token,
    this.enableJavaScript = true,
  }) : super(key: key);

  @override
  State<WebViewSdk> createState() => _WebViewSdkState();
}

class _WebViewSdkState extends State<WebViewSdk> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final String initialUrl =
        'http://10.0.2.252:8000/?token=${Uri.encodeComponent(widget.token)}';

    _controller = WebViewController()
      ..setJavaScriptMode(widget.enableJavaScript
          ? JavaScriptMode.unrestricted
          : JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}

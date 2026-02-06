export 'setlary_lite.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SetlaryLiteView extends StatefulWidget {
  final String token;
  final bool enableJavaScript;
  final String? testUrl;

  const SetlaryLiteView({
    super.key,
    required this.token,
    this.enableJavaScript = true,
    this.testUrl,
  });

  @override
  State<SetlaryLiteView> createState() => _SetlaryLiteViewState();
}

class _SetlaryLiteViewState extends State<SetlaryLiteView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final String initialUrl =
        widget.testUrl ??
        'https://stage-lite.setlary.my?token=${Uri.encodeComponent(widget.token)}';

    _controller = WebViewController()
      ..setJavaScriptMode(
        widget.enableJavaScript
            ? JavaScriptMode.unrestricted
            : JavaScriptMode.disabled,
      )
      ..loadRequest(Uri.parse(initialUrl));
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller);
  }
}

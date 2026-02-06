import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SetlaryLite extends StatefulWidget {
  final String url;
  final String token;
  final bool enableJavaScript;

  /// Optional: set height of the container
  final double? height;

  /// Optional: set width of the container
  final double? width;

  const SetlaryLite({
    super.key,
    required this.url,
    required this.token,
    this.enableJavaScript = true,
    this.height,
    this.width,
  });

  @override
  State<SetlaryLite> createState() => _SetlaryLiteState();
}

class _SetlaryLiteState extends State<SetlaryLite> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(
        widget.enableJavaScript
            ? JavaScriptMode.unrestricted
            : JavaScriptMode.disabled,
      )
      ..loadRequest(
        Uri.parse(
          '${widget.url}?token=?token=${Uri.encodeComponent(widget.token)}',
        ),
      );
  }

  void _navigateToWebView() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            Scaffold(body: WebViewWidget(controller: _controller)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToWebView,
      child: Container(
        height: widget.height ?? 48, // default height
        width: widget.width ?? 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset('assets/logo.svg'),
      ),
    );
  }
}

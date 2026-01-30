import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SetlaryLite extends StatefulWidget {
  final String url;

  /// Optional: set height of the container
  final double? height;

  /// Optional: set width of the container
  final double? width;

  const SetlaryLite({
    Key? key,
    required this.url,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  State<SetlaryLite> createState() => _SetlaryLiteState();
}

class _SetlaryLiteState extends State<SetlaryLite> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 400, // default height
      width: widget.width ?? double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8), // optional styling
        child: WebViewWidget(controller: _controller),
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://play-lh.googleusercontent.com/qCNdZAzu204xsA9QJVZNgnqtX9wv5Yb5kbKtXE8ZNV7DcbgE-f2IxhsBejNcwccctCKZ',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

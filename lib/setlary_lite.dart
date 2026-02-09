import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';

class SetlaryLite extends StatefulWidget {
  final String url;
  final String token;
  final bool enableJavaScript;

  /// Optional: set height of the container
  final double? height;

  /// Optional: set width of the container
  final double? width;
  final bool hideTitle;
  final Color? titleColour;
  final double? fontSize;

  const SetlaryLite({
    super.key,
    required this.url,
    required this.token,
    this.enableJavaScript = true,
    this.height,
    this.width,
    this.hideTitle = false,
    this.titleColour,
    this.fontSize,
  });

  @override
  State<SetlaryLite> createState() => _SetlaryLiteState();
}

class _SetlaryLiteState extends State<SetlaryLite> {
  late final InAppWebViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  void _navigateToWebView() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          body: InAppWebView(
            key: UniqueKey(),
            initialUrlRequest: URLRequest(
              url: WebUri(
                '${widget.url}?token=${Uri.encodeComponent(widget.token)}',
              ),
            ),
            onWebViewCreated: (controller) {
              _controller = controller;
            },
            initialSettings: InAppWebViewSettings(
              javaScriptEnabled: true,
              supportZoom: false,
              transparentBackground: false,
              useHybridComposition: true,
              allowsInlineMediaPlayback: true,
              allowFileAccess: false,
            ),
            onLoadResource: (controller, resource) async {
              final resourceUrl = resource.url?.toString();
              if (resourceUrl != null && resourceUrl.endsWith('/close')) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _navigateToWebView,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(8),
            height: widget.height ?? 48, // default height
            width: widget.width ?? 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              'assets/logo.svg',
              package: 'setlary_lite',
              height: 20,
              width: 20,
            ),
          ),
          if (!widget.hideTitle)
            Padding(
              padding: EdgeInsetsGeometry.only(top: 4),
              child: Text(
                'Setlary Lite',
                style: TextStyle(
                  color: widget.titleColour ?? Colors.black87,
                  fontSize: widget.fontSize ?? 12,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

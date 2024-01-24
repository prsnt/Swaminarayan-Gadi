import 'package:appstructure/provider/theme_provider.dart';
import 'package:appstructure/utils/dimentions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AboutUsWebView extends StatefulWidget {
  const AboutUsWebView({Key? key, this.title, this.url}) : super(key: key);
  final String? title, url;

  @override
  _AboutUsWebViewState createState() => _AboutUsWebViewState();
}

class _AboutUsWebViewState extends State<AboutUsWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    params = const PlatformWebViewControllerCreationParams();
    final WebViewController controller = WebViewController.fromPlatformCreationParams(params);
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {},
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(Uri.parse(widget.url!));

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: Dimentions.widthMargin05, vertical: Dimentions.heightMargin05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                      margin: const EdgeInsets.all(10),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: themeProvider.isDarkMode ? const Color(0xFF262829) : const Color(0xFFFFFFFF),
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.08),
                              blurRadius: 5.0,
                            ),
                          ]),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(true);
                        },
                        child: Image.asset(
                          'assets/images/back.png',
                          height: 20,
                          width: 20,
                          color: themeProvider.isDarkMode ? const Color(0xFFDADADA) : const Color(0xFF373A40),
                        ),
                      ),
                      padding: const EdgeInsets.all(10)),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: Dimentions.widthMargin10),
                      child: Text(widget.title!, style: Theme.of(context).textTheme.displayMedium),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: WebViewWidget(controller: _controller),
            ),
          ],
        ),
      ),
    );
  }
}

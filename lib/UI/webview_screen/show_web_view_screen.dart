import 'package:flutter/material.dart';
import 'package:research_app/Resources/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';


PlatformWebViewControllerCreationParams params =
    const PlatformWebViewControllerCreationParams();

class ShowWebViewScreen extends StatelessWidget {
  ShowWebViewScreen({Key? key, required this.url}) : super(key: key);
  final String url;
  var webViewController = WebViewController.fromPlatformCreationParams(params);

  @override
  Widget build(BuildContext context) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..runJavaScript('javascript:(function() { '
          "var sale = document.getElementsByClassName('master_header')[0];"
          'sale.parentNode.removeChild(sale);'
          "var salee = document.getElementsByClassName('footer_back_repeat')[0];"
          'salee.parentNode.removeChild(salee);'
          "var saleee = document.getElementById('simple-chat-button--container');"
          'saleee.parentNode.removeChild(saleee);'
          "var saleeee = document.getElementsByClassName('switcher')[0];"
          'saleeee.parentNode.removeChild(saleeee);'
          '})()')
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            webViewController.runJavaScriptReturningResult(
                'javascript:(function() { '
                "var sale = document.getElementsByClassName('master_header')[0];"
                'sale.parentNode.removeChild(sale);'
                "var salee = document.getElementsByClassName('footer_back_repeat')[0];"
                'salee.parentNode.removeChild(salee);'
                "var saleee = document.getElementById('simple-chat-button--container');"
                'saleee.parentNode.removeChild(saleee);'
                "var saleeee = document.getElementsByClassName('switcher')[0];"
                'saleeee.parentNode.removeChild(saleeee);'
                '})()');
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    return Scaffold(
      // appBar: AppBar(
      //   centerTitle: true,
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   iconTheme:  IconThemeData(color: ColorManager.primaryColor),
      //   // title:  const CustomImage(
      //   //   url: AssetRoute.LogoHorizontal,
      //   //   height: 40,
      //   // ),
      // ),
      body: WebViewWidget(controller: webViewController),
    );
  }
}

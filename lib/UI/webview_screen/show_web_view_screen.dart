// import 'package:flutter/material.dart';
// import 'package:research_app/Resources/colors.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
//
// PlatformWebViewControllerCreationParams params =
//     const PlatformWebViewControllerCreationParams();
//
// class ShowWebViewScreen extends StatelessWidget {
//   ShowWebViewScreen({Key? key, required this.url}) : super(key: key);
//   final String url;
//   var webViewController = WebViewController.fromPlatformCreationParams(params);
//
//   @override
//   Widget build(BuildContext context) {
//     webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..runJavaScript('javascript:(function() { '
//           "var sale = document.getElementsByClassName('master_header')[0];"
//           'sale.parentNode.removeChild(sale);'
//           "var salee = document.getElementsByClassName('footer_back_repeat')[0];"
//           'salee.parentNode.removeChild(salee);'
//           "var saleee = document.getElementById('simple-chat-button--container');"
//           'saleee.parentNode.removeChild(saleee);'
//           "var saleeee = document.getElementsByClassName('switcher')[0];"
//           'saleeee.parentNode.removeChild(saleeee);'
//           '})()')
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//           onPageFinished: (String url) {
//             webViewController.runJavaScriptReturningResult(
//                 'javascript:(function() { '
//                 "var sale = document.getElementsByClassName('master_header')[0];"
//                 'sale.parentNode.removeChild(sale);'
//                 "var salee = document.getElementsByClassName('footer_back_repeat')[0];"
//                 'salee.parentNode.removeChild(salee);'
//                 "var saleee = document.getElementById('simple-chat-button--container');"
//                 'saleee.parentNode.removeChild(saleee);'
//                 "var saleeee = document.getElementsByClassName('switcher')[0];"
//                 'saleeee.parentNode.removeChild(saleeee);'
//                 '})()');
//           },
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(url));
//     return WillPopScope(
//       onWillPop: () async{
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 ShowWebViewScreen(url: 'https://rs.tkamol.sa/public/research'),
//           ),
//         );
//         return true;
//       },
//       child: Scaffold(
//         // appBar: AppBar(
//         //   centerTitle: true,
//         //   backgroundColor: Colors.white,
//         //   elevation: 0,
//         //   iconTheme:  IconThemeData(color: ColorManager.primaryColor),
//         //   // title:  const CustomImage(
//         //   //   url: AssetRoute.LogoHorizontal,
//         //   //   height: 40,
//         //   // ),
//         // ),
//         body: SafeArea(child: WebViewWidget(controller: webViewController)),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:webview_flutter/webview_flutter.dart';

PlatformWebViewControllerCreationParams params =
const PlatformWebViewControllerCreationParams();

class ShowWebViewScreen extends StatelessWidget {
  ShowWebViewScreen({Key? key, required this.url}) : super(key: key);
  final String url;
  var webViewController = WebViewController.fromPlatformCreationParams(params);

  Future<void> _requestLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled
      return Future.error('Location services are disabled.');
    }

    // Check if the app has location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // The user has previously denied location permissions
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // Request location permissions
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        // The user has denied location permissions
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    // Check if the app has location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      // The user has previously denied location permissions
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    } else if (permission == LocationPermission.denied) {
      // Request location permissions
      await _requestLocationPermission();
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // Pass the location data to the WebView
    await webViewController.runJavaScriptReturningResult(
        'getCurrentPosition(${position.latitude}, ${position.longitude})');
  }

  @override
  Widget build(BuildContext context) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            _getCurrentLocation();
          },
          onPageFinished: (String url) {
            _getCurrentLocation();
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ShowWebViewScreen(url: 'https://researchv2.tkamol.sa/public/'),
          ),
        );
        return true;
      },
      child: Scaffold(
        body: SafeArea(child: WebViewWidget(controller: webViewController)),
      ),
    );
  }
}

// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:geolocator/geolocator.dart';
//
// class ShowWebViewScreen extends StatefulWidget {
//   ShowWebViewScreen({Key? key, required this.url}) : super(key: key);
//   final String url;
//
//   @override
//   _ShowWebViewScreenState createState() => _ShowWebViewScreenState();
// }
//
// class _ShowWebViewScreenState extends State<ShowWebViewScreen> {
//   late WebViewController webViewController;
//   final Completer<WebViewController> _controller = Completer<WebViewController>();
//   final String url;
//   Future<void> _requestLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Location services are disabled
//       return Future.error('Location services are disabled.');
//     }
//
//     // Check if the app has location permissions
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       // The user has previously denied location permissions
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     // Request location permissions
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission != LocationPermission.whileInUse &&
//           permission != LocationPermission.always) {
//         // The user has denied location permissions
//         return Future.error(
//             'Location permissions are denied (actual value: $permission).');
//       }
//     }
//   }
//
//   Future<void> _getCurrentLocation() async {
//     // Check if the app has location permissions
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.deniedForever) {
//       // The user has previously denied location permissions
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     } else if (permission == LocationPermission.denied) {
//       // Request location permissions
//       await _requestLocationPermission();
//     }
//
//     // Get the current location
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     // Pass the location data to the WebView
//     await webViewController.runJavaScriptReturningResult(
//         'getCurrentPosition(${position.latitude}, ${position.longitude})');
//   }
//   webViewController = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {},
//
//           onWebResourceError: (WebResourceError error) {},
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(url));
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ShowWebViewScreen(
//                 url: 'https://researchv2.tkamol.sa/public/'),
//           ),
//         );
//         return true;
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child:
//           WebViewWidget(controller: webViewController
//
//             initialUrl: widget.url,
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (WebViewController controller) {
//               _controller.future.then((value) => webViewController = value);
//               _controller.complete(controller);
//             },
//             navigationDelegate: (NavigationRequest request) {
//               if (request.url.startsWith('https://www.youtube.com/')) {
//                 return NavigationDecision.prevent;
//               } else {
//                 return NavigationDecision.navigate;
//               }
//             },
//             onPageFinished: (String url) {
//               _getCurrentLocation();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

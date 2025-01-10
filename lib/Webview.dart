import 'dart:collection';

// import 'package:constructor_io_flutter/constructor_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import 'main.dart';

class Webview extends StatefulWidget {
  const Webview({super.key});

  @override
  _WebviewState createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  final GlobalKey webViewKey = GlobalKey();
  double progress = 0;
  InAppWebViewController? webViewController;
  InAppWebViewSettings settings = InAppWebViewSettings(
      isInspectable: kDebugMode,
      javaScriptEnabled: true,
      mediaPlaybackRequiresUserGesture: false,
      allowsInlineMediaPlayback: true,
      useShouldOverrideUrlLoading: true,
      cacheMode: CacheMode.LOAD_NO_CACHE,
      mixedContentMode: MixedContentMode.MIXED_CONTENT_ALWAYS_ALLOW,
      iframeAllowFullscreen: true);

  // Function to inject JavaScript and modify the srcset attribute
  /*Future appendHttpsToSrcset(InAppWebViewController webViewController) async {
    // Add a delay before executing the JavaScript code
    await Future.delayed(const Duration(seconds: 1)); // 1-second delay

    String script = '''
    var images = document.querySelectorAll('img');
    images.forEach(function(img) {
      // Check if the image has a 'data-flixsrcset' attribute
      var dataSrcset = img.getAttribute('srcset');
      if (dataSrcset) {
        // Split the srcset into individual URLs
        var trimmedUrl = dataSrcset.trim();
        if (!trimmedUrl.startsWith('https://')) {
          var afterReplaceHttps = trimmedUrl.replace(/^\\//, 'https:/'); // Prepend 'https://' if it's missing
        }        
        console.log('Updated:<-->', afterReplaceHttps); // Log the updated srcset
        img.setAttribute('srcset', afterReplaceHttps); // Update the srcset
      }
    });
  ''';

    // Execute the JavaScript in the WebView
    webViewController.evaluateJavascript(source: script);
  }*/

  Future appendHttpsToSrcset(InAppWebViewController webViewController) async {
    // Add a delay before executing the JavaScript code (if necessary, can be adjusted)
    await Future.delayed(const Duration(seconds: 1)); // Optional 1-second delay

    String script = '''
    var images = document.querySelectorAll('img');
    images.forEach(function(img) {
      // Check if the image has a 'srcset' attribute
      var dataSrcset = img.getAttribute('srcset');
      if (dataSrcset) {
        // Split the srcset into individual URLs
        var srcsetUrls = dataSrcset.split(',');

        // Loop through each URL and prepend 'https://' if needed
        var updatedSrcset = srcsetUrls.map(function(url) {
          var trimmedUrl = url.trim();
          if (!trimmedUrl.startsWith('https://')) {
            return trimmedUrl.replace(/^\\//, 'https://'); // Prepend 'https://' if it's missing
          }
          return trimmedUrl; // Return the original URL if it already starts with 'https://'
        }).join(','); // Join the modified URLs back into a single srcset string

        console.log('Updated srcset:', updatedSrcset); // Log the updated srcset
        img.setAttribute('srcset', updatedSrcset); // Update the srcset immediately
      }
    });
  ''';

    // Execute the JavaScript in the WebView
    webViewController.evaluateJavascript(source: script);
  }

  /*if (!kIsWeb) {
  initialFile: "${localhostServer.documentRoot}index.html"
  } else {
  initialUrlRequest: URLRequest(
  url: WebUri.uri(Uri.parse(
  'http://127.0.0.1:8080/${localhostServer.directoryIndex}'))),
  }*/

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Web View Example'),
        ),
        body: Container(
          child: Stack(
            children: [
              InAppWebView(
                  key: webViewKey,
                  webViewEnvironment: webViewEnvironment,
                  //initialFile: "${localhostServer.documentRoot}index.html",
                  /*initialUrlRequest: URLRequest(
                  url: WebUri.uri(Uri.dataFromString(
                      kWebViewSample,
                      mimeType: 'text/html',
                      encoding: Encoding.getByName('utf-8'))),
                ),*/
                  //initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('http://192.168.137.1:3000/'))),
                  //initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('http://localhost:8080/index.html'))),
                  //initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://www.rona.ca/en/product/samsung-free-standing-convection-range-with-air-fry-and-wi-fi-connection-30-in-stainless-steel-ne63a6511ss-ac-22945318'))),
                  initialUrlRequest: URLRequest(
                      url: WebUri.uri(Uri.parse(
                          'http://127.0.0.1:8080/${localhostServer.directoryIndex}'))),
                  initialUserScripts: UnmodifiableListView<UserScript>([]),
                  initialSettings: settings,
                  //pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) async {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      //this.url = url.toString();
                      //urlController.text = this.url;
                    });
                  },
                  /*onPermissionRequest: (controller, request) {
                  return PermissionResponse(
                      resources: request.resources,
                      action: PermissionResponseAction.GRANT);
                },*/
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;
                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunchUrl(uri)) {
                        // Launch the App
                        await launchUrl(
                          uri,
                        );
                        // and cancel the request
                        return NavigationActionPolicy.CANCEL;
                      }
                    }
                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    // Ensure the srcset update happens once the page is loaded
                    await appendHttpsToSrcset(webViewController!);
                    /*pullToRefreshController?.endRefreshing();
                  setState(() {
                    this.url = url.toString();
                    urlController.text = this.url;
                  });*/
                  },
                  onReceivedError: (controller, request, error) {
                    //pullToRefreshController?.endRefreshing();
                    print(error.description);
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      //pullToRefreshController?.endRefreshing();
                    }
                    setState(() {
                      /*this.progress = progress / 100;
                    urlController.text = this.url;*/
                    });
                  },
                  onUpdateVisitedHistory: (controller, url, isReload) {
                    setState(() {
                      /*this.url = url.toString();
                    urlController.text = this.url;*/
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    print(consoleMessage
                        .message); // To capture JavaScript console logs
                  },
                  onReceivedServerTrustAuthRequest:
                      (controller, challenge) async {
                    return ServerTrustAuthResponse(
                        action: ServerTrustAuthResponseAction.PROCEED);
                  }),
              progress < 1.0
                  ? LinearProgressIndicator(value: progress)
                  : Container(),
              Positioned(
                bottom: 0, // Distance from the bottom
                left: 0, // Optional: Align horizontally
                right: 0, // Optional: Align horizontally,
                child: InkWell(
                  onTap: () async {
                    //startSearchSession();
                    getSearch();
                  },
                  child: Container(
                    color: Colors.white,
                    height: 48,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Click Here",
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void getSearch() async {
    try {
      // final results = await constructorIo.search('shoes');
      // for (var result in results) {
      //   print(
      //       'constructorIo:-->Title: ${result.description}, URL: ${result.url}');
      // }
    } catch (e) {
      print('constructorIo:-->Error: $e');
    }
  }

  void startSearchSession() async {
    try {
      // await constructorIo.sessionStart();
    } catch (e) {
      print('constructorIo:-->Error: $e');
    }
  }

  @override
  void dispose() {
    if (!kIsWeb) {
      localhostServer.close();
    }
    super.dispose();
  }
}

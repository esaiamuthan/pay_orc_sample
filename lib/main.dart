// import 'package:constructor_io_flutter/constructor_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:web_view_sample/payment.dart';

final localhostServer = InAppLocalhostServer(documentRoot: 'assets');
// late ConstructorIo constructorIo;
WebViewEnvironment? webViewEnvironment;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterPayOrc.initialize(
    merchantKey: 'test-JR11KGG26DM',
    merchantSecret: 'sec-DC111UM26HQ',
    environment:
        Environment.development, // Switch to Environment.production for live
  );
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.windows) {
    final availableVersion = await WebViewEnvironment.getAvailableVersion();
    assert(availableVersion != null,
        'Failed to find an installed WebView2 runtime or non-stable Microsoft Edge installation.');

    webViewEnvironment = await WebViewEnvironment.create(
        settings: WebViewEnvironmentSettings(
      additionalBrowserArguments: kDebugMode
          ? '--enable-features=msEdgeDevToolsWdpRemoteDebugging'
          : null,
      userDataFolder: 'custom_path',
    ));

    /*webViewEnvironment?.onBrowserProcessExited = (detail) {
      if (kDebugMode) {
        print('Browser process exited with detail: $detail');
      }
    };*/
  }

  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    await InAppWebViewController.setWebContentsDebuggingEnabled(kDebugMode);
  }
  if (!kIsWeb) {
    await localhostServer.start();
  }
  // constructorIo = await ConstructorIo.create(apiKey: 'key_K2hlXt5aVSwoI1Uw');
  // Set the user ID (for a logged in user) used for cross device personalization
  // constructorIo.userId = "uid";
  // await constructorIo.sessionStart();
  // print('constructorIo:-->Session ID -> ${await constructorIo.getSessionId()}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const FirstRoute(),
    );
  }
}

class FirstRoute extends StatelessWidget {
  const FirstRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Pay with custom widget"),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PaymentPage()),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              child: const Text("Pay with PayOrc widget"),
              onPressed: () async {
                await FlutterPayOrc.instance.createPaymentWithWidget(
                  context: context,
                  request: createPayOrcPaymentRequest(),
                  onPaymentResult: (success, {errorMessage}) {
                    if (success) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Payment success')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(errorMessage ?? 'Payment failed')),
                      );
                    }
                  },
                  onLoadingResult: (loading) {},
                  onPopResult: () {},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

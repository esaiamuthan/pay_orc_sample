// import 'package:constructor_io_flutter/constructor_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:web_view_sample/pay.orc.form.dart';

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

class FirstRoute extends StatefulWidget {
  const FirstRoute({super.key});

  @override
  State<FirstRoute> createState() => _FirstRouteState();
}

class _FirstRouteState extends State<FirstRoute> {
  bool loading = false;

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
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.amberAccent),
              child: loading
                  ? SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.purple,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          const Text("Creating payment request...")
                        ],
                      ),
                    )
                  : const Text("Checkout Form"),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => PayOrcForm(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _fetchTransaction(String? pOrderId) async {
    final transaction = await FlutterPayOrc.instance.fetchPaymentTransaction(
      orderId: pOrderId.toString(),
      errorResult: (message) {
        debugPrint('errorResult $message');
      },
    );
    debugPrint('transaction ${transaction?.toJson()}');

    FlutterPayOrc.instance.clearData();
  }
}

// Create the request payload
PayOrcPaymentRequest createPayOrcPaymentRequest() {
  return PayOrcPaymentRequest(
    data: Data(
      className: PayOrcClass.ecom.name.toUpperCase(),
      action: PayOrcAction.sale.name.toUpperCase(),
      captureMethod: PayOrcCaptureMethod.manual.name.toUpperCase(),
      paymentToken: "",
      orderDetails: OrderDetails(
        mOrderId: "1234",
        amount: "500",
        convenienceFee: "0",
        quantity: "1",
        currency: "AED",
        description: "",
      ),
      customerDetails: CustomerDetails(
        mCustomerId: "123",
        name: "John Doe",
        email: "pawan@payorc.com",
        mobile: "987654321",
        code: "971",
      ),
      billingDetails: BillingDetails(
        addressLine1: "address 1",
        addressLine2: "address 2",
        city: "Amarpur",
        province: "Bihar",
        country: "IN",
        pin: "482008",
      ),
      shippingDetails: ShippingDetails(
        shippingName: "Pawan Kushwaha",
        shippingEmail: "",
        shippingCode: "91",
        shippingMobile: "9876543210",
        addressLine1: "address 1",
        addressLine2: "address 2",
        city: "Jabalpur",
        province: "Madhya Pradesh",
        country: "IN",
        pin: "482005",
        locationPin: "https://location/somepoint",
        shippingCurrency: "AED",
        shippingAmount: "10",
      ),
      urls: Urls(
        success: "",
        cancel: "",
        failure: "",
      ),
      parameters: [
        {
          "alpha": "",
          "beta": "",
          "gamma": "",
          "delta": "",
          "epsilon": "",
        }
      ],
      customData: [
        {
          "alpha": "",
          "beta": "",
          "gamma": "",
          "delta": "",
          "epsilon": "",
        }
      ],
    ),
  );
}

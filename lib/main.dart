import 'package:flutter/material.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';
import 'package:web_view_sample/pay.orc.form.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterPayOrc.initialize(
    merchantKey: 'test-JR11KGG26DM',
    merchantSecret: 'sec-DC111UM26HQ',
    environment: Environment.test, // Switch to Environment.live for live
  );
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
      debugShowCheckedModeBanner: false,
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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
                  ? const SizedBox(
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
                          Text("Creating payment request...")
                        ],
                      ),
                    )
                  : const Text("Checkout Form"),
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PayOrcForm(),
                ));
              },
            ),
          ],
        ),
      ),
    );
  }
}

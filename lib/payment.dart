import 'package:flutter/material.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  PayOrcPaymentResponse? paymentResponse;
  bool isLoading = true; // To show loading indicator
  bool isError = false; // To handle errors
  String? errorMessage; // To store error message

  @override
  void initState() {
    super.initState();
    _initializePayment();
  }

  Future<void> _initializePayment() async {
    try {
      // Call createPayment method
      final response = await FlutterPayOrc.instance.createPayment(
        request: createPayOrcPaymentRequest(),
      );

      // Update the state with the response
      setState(() {
        paymentResponse = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
        errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: const Text("Payment")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (isError) {
      return Scaffold(
        appBar: AppBar(title: const Text("Payment")),
        body: Center(
          child: Text(
            'Error: $errorMessage',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }

    // Load the startPayment widget if data is available
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: FlutterPayOrc.instance.createPaymentWithCustomWidget(
        onPaymentResult: (success, {errorMessage}) {
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Payment success')),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage ?? 'Payment failed.')),
            );
          }
        },
      ),
    );
  }
}

// Create the request payload
PayOrcPaymentRequest createPayOrcPaymentRequest() {
  return PayOrcPaymentRequest(
    data: Data(
      className: "ECOM",
      action: "SALE",
      captureMethod: "MANUAL",
      paymentToken: "",
      orderDetails: OrderDetails(
        mOrderId: "1234",
        amount: "100",
        convenienceFee: "0",
        quantity: "2",
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
    ),
  );
}

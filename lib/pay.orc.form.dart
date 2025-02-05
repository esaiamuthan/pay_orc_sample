import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pay_orc/flutter_pay_orc.dart';

class PayOrcForm extends StatefulWidget {
  const PayOrcForm({super.key});

  @override
  State<PayOrcForm> createState() => _PayOrcFormState();
}

class _PayOrcFormState extends State<PayOrcForm> {
  final _formKey = GlobalKey<FormState>();

  PayOrcClass? _selectedClassName = PayOrcClass.ecom;
  PayOrcAction? _selectedAction = PayOrcAction.sale;
  PayOrcCaptureMethod? _selectedCaptureMethod = PayOrcCaptureMethod.manual;

  final List<PayOrcClass> classNames = PayOrcClass.values.toList();
  final List<PayOrcAction> actions = PayOrcAction.values.toList();
  final List<PayOrcCaptureMethod> captureMethods =
      PayOrcCaptureMethod.values.toList();

  // Controllers for various fields
  final TextEditingController _orderIdController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _convenienceFeeController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _customerIdController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final TextEditingController _billingAddress1Controller =
      TextEditingController();
  final TextEditingController _billingAddress2Controller =
      TextEditingController();
  final TextEditingController _billingCityController = TextEditingController();
  final TextEditingController _billingProvinceController =
      TextEditingController();
  final TextEditingController _billingCountryController =
      TextEditingController();
  final TextEditingController _billingPinController = TextEditingController();

  final TextEditingController _shippingNameController = TextEditingController();
  final TextEditingController _shippingEmailController =
      TextEditingController();
  final TextEditingController _shippingCodeController = TextEditingController();
  final TextEditingController _shippingMobileController =
      TextEditingController();
  final TextEditingController _shippingAddress1Controller =
      TextEditingController();
  final TextEditingController _shippingAddress2Controller =
      TextEditingController();
  final TextEditingController _shippingCityController = TextEditingController();
  final TextEditingController _shippingProvinceController =
      TextEditingController();
  final TextEditingController _shippingCountryController =
      TextEditingController();
  final TextEditingController _shippingPinController = TextEditingController();
  final TextEditingController _locationPinController = TextEditingController();
  final TextEditingController _shippingCurrencyController =
      TextEditingController();
  final TextEditingController _shippingAmountController =
      TextEditingController();

  // Controllers for the "urls"
  final _successController = TextEditingController();
  final _cancelController = TextEditingController();
  final _failureController = TextEditingController();

  // Parameters and customData fields
  final List<Map<String, TextEditingController>> _parametersControllers = [];
  final List<Map<String, TextEditingController>> _customDataControllers = [];

  final random = Random();

  @override
  void initState() {
    // Initialize the controllers for parameters and customData
    _parametersControllers.add({
      "alpha": TextEditingController(),
      "beta": TextEditingController(),
      "gamma": TextEditingController(),
      "delta": TextEditingController(),
      "epsilon": TextEditingController(),
    });

    _customDataControllers.add({
      "alpha": TextEditingController(),
      "beta": TextEditingController(),
      "gamma": TextEditingController(),
      "delta": TextEditingController(),
      "epsilon": TextEditingController(),
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PayOrc Payment Form'),
        actions: [
          TextButton(
              onPressed: () {
                // Names
                _nameController.text = 'John Dev';
                _shippingNameController.text = 'John';

                // email
                _emailController.text = 'test@mail.com';
                _shippingEmailController.text = 'test@mail.com';

                // address
                _billingAddress1Controller.text = 'address 1';
                _billingAddress2Controller.text = 'address2';
                _shippingAddress1Controller.text = 'address 1';
                _shippingAddress2Controller.text = 'address 2';

                // city
                _billingCityController.text = 'Chennai';
                _shippingCityController.text = 'Chennai';

                // city
                _mobileController.text = '9874563210';
                _shippingMobileController.text = '9856321470';

                _codeController.text = '91';
                _shippingCodeController.text = '91';

                // zipcode
                _billingPinController.text = "600006";
                _shippingPinController.text = "600006";

                _orderIdController.text = "${random.nextInt(89999) + 10000}";
                _customerIdController.text = "${random.nextInt(89999) + 10000}";

                _currencyController.text = "AED";
                _shippingCurrencyController.text = "AED";

                _amountController.text = "100";
                _shippingAmountController.text = "10";
                _convenienceFeeController.text = "2";

                _billingProvinceController.text = "Tamil Nadu";
                _shippingProvinceController.text = "Tamil Nadu";

                _billingCountryController.text = "IN";
                _shippingCountryController.text = "IN";
              },
              child: const Text('Prefill'))
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<PayOrcClass>(
                decoration: const InputDecoration(
                  labelText: 'Class Name',
                  border: OutlineInputBorder(),
                ),
                value: _selectedClassName,
                items: classNames
                    .map((className) => DropdownMenuItem(
                          value: className,
                          child: Text(className.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedClassName = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a class name' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<PayOrcAction>(
                decoration: const InputDecoration(
                  labelText: 'Action',
                  border: OutlineInputBorder(),
                ),
                value: _selectedAction,
                items: actions
                    .map((action) => DropdownMenuItem(
                          value: action,
                          child: Text(action.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedAction = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select an action' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<PayOrcCaptureMethod>(
                decoration: const InputDecoration(
                  labelText: 'Capture Method',
                  border: OutlineInputBorder(),
                ),
                value: _selectedCaptureMethod,
                items: captureMethods
                    .map((method) => DropdownMenuItem(
                          value: method,
                          child: Text(method.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCaptureMethod = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a capture method' : null,
              ),
              const SizedBox(height: 24),
              const Text('Order Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _orderIdController,
                decoration: const InputDecoration(labelText: 'Order ID'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Amount'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _convenienceFeeController,
                decoration: const InputDecoration(labelText: 'Convenience Fee'),
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              TextFormField(
                controller: _currencyController,
                decoration: const InputDecoration(labelText: 'Currency'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 16),
              const Text('Customer Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _customerIdController,
                decoration: const InputDecoration(labelText: 'Customer ID'),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _mobileController,
                decoration: const InputDecoration(labelText: 'Mobile'),
              ),
              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: 'Code'),
              ),
              const SizedBox(height: 16),
              const Text('Billing Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _billingAddress1Controller,
                decoration: const InputDecoration(labelText: 'Address Line 1'),
              ),
              TextFormField(
                controller: _billingAddress2Controller,
                decoration: const InputDecoration(labelText: 'Address Line 2'),
              ),
              TextFormField(
                controller: _billingCityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextFormField(
                controller: _billingProvinceController,
                decoration: const InputDecoration(labelText: 'Province'),
              ),
              TextFormField(
                controller: _billingCountryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
              TextFormField(
                controller: _billingPinController,
                decoration: const InputDecoration(labelText: 'Pin'),
              ),
              const SizedBox(height: 16),
              const Text('Shipping Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _shippingNameController,
                decoration: const InputDecoration(labelText: 'Shipping Name'),
              ),
              TextFormField(
                controller: _shippingEmailController,
                decoration: const InputDecoration(labelText: 'Shipping Email'),
              ),
              TextFormField(
                controller: _shippingCodeController,
                decoration: const InputDecoration(labelText: 'Shipping Code'),
              ),
              TextFormField(
                controller: _shippingMobileController,
                decoration: const InputDecoration(labelText: 'Shipping Mobile'),
              ),
              TextFormField(
                controller: _shippingAddress1Controller,
                decoration:
                    const InputDecoration(labelText: 'Shipping Address Line 1'),
              ),
              TextFormField(
                controller: _shippingAddress2Controller,
                decoration:
                    const InputDecoration(labelText: 'Shipping Address Line 2'),
              ),
              TextFormField(
                controller: _shippingCityController,
                decoration: const InputDecoration(labelText: 'Shipping City'),
              ),
              TextFormField(
                controller: _shippingProvinceController,
                decoration:
                    const InputDecoration(labelText: 'Shipping Province'),
              ),
              TextFormField(
                controller: _shippingCountryController,
                decoration:
                    const InputDecoration(labelText: 'Shipping Country'),
              ),
              TextFormField(
                controller: _shippingPinController,
                decoration: const InputDecoration(labelText: 'Shipping Pin'),
              ),
              TextFormField(
                controller: _locationPinController,
                decoration: const InputDecoration(labelText: 'Location Pin'),
              ),
              TextFormField(
                controller: _shippingCurrencyController,
                decoration:
                    const InputDecoration(labelText: 'Shipping Currency'),
              ),
              TextFormField(
                controller: _shippingAmountController,
                decoration: const InputDecoration(labelText: 'Shipping Amount'),
              ),
              const SizedBox(height: 16),
              const Text("URLs", style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _successController,
                decoration: const InputDecoration(labelText: "Success URL"),
              ),
              TextFormField(
                controller: _cancelController,
                decoration: const InputDecoration(labelText: "Cancel URL"),
              ),
              TextFormField(
                controller: _failureController,
                decoration: const InputDecoration(labelText: "Failure URL"),
              ),
              const SizedBox(height: 16.0),
              const Text("Parameters",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ..._parametersControllers.map((controllers) {
                return Column(
                  children: controllers.entries.map((entry) {
                    return TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(labelText: entry.key),
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 16.0),
              const Text("Custom Data",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              ..._customDataControllers.map((controllers) {
                return Column(
                  children: controllers.entries.map((entry) {
                    return TextFormField(
                      controller: entry.value,
                      decoration: InputDecoration(labelText: entry.key),
                    );
                  }).toList(),
                );
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amberAccent),
                onPressed: () {
                  _createPaymentRequest(context);
                },
                child: const Text("Pay now with PayOrc widget"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _clearAllFields();
    super.dispose();
  }

// Create the request payload
  PayOrcPaymentRequest createPayOrcPaymentRequest() {
    return PayOrcPaymentRequest(
      data: Data(
        className: _selectedClassName!.name.toString().toUpperCase(),
        action: _selectedAction!.name.toString().toUpperCase(),
        captureMethod: _selectedCaptureMethod!.name.toString().toUpperCase(),
        paymentToken: "",
        orderDetails: OrderDetails(
          mOrderId: _orderIdController.text.toString(),
          amount: _amountController.text.toString(),
          convenienceFee: _convenienceFeeController.text.toString(),
          quantity: _quantityController.text.toString(),
          currency: _currencyController.text.toString(),
          description: _descriptionController.text.toString(),
        ),
        customerDetails: CustomerDetails(
          mCustomerId: _customerIdController.text.toString(),
          name: _nameController.text.toString(),
          email: _emailController.text.toString(),
          mobile: _mobileController.text.toString(),
          code: _codeController.text.toString(),
        ),
        billingDetails: BillingDetails(
          addressLine1: _billingAddress1Controller.text.toString(),
          addressLine2: _billingAddress2Controller.text.toString(),
          city: _billingCityController.text.toString(),
          province: _billingProvinceController.text.toString(),
          country: _billingCountryController.text.toString(),
          pin: _billingPinController.text.toString(),
        ),
        shippingDetails: ShippingDetails(
          shippingName: _shippingNameController.text.toString(),
          shippingEmail: _shippingEmailController.text.toString(),
          shippingCode: _shippingCodeController.text.toString(),
          shippingMobile: _shippingMobileController.text.toString(),
          addressLine1: _shippingAddress1Controller.text.toString(),
          addressLine2: _shippingAddress2Controller.text.toString(),
          city: _shippingCityController.text.toString(),
          province: _shippingProvinceController.text.toString(),
          country: _shippingCountryController.text.toString(),
          pin: _shippingPinController.text.toString(),
          locationPin: _locationPinController.text.toString(),
          shippingCurrency: _shippingCurrencyController.text.toString(),
          shippingAmount: _shippingAmountController.text.toString(),
        ),
        urls: Urls(
          success: _successController.text.toString(),
          cancel: _cancelController.text.toString(),
          failure: _failureController.text.toString(),
        ),
        parameters: [
          {
            "alpha":
                _parametersControllers.first["alpha"]?.value.text.toString(),
          },
          {
            "beta": _parametersControllers.first["beta"]?.value.text.toString(),
          },
          {
            "gamma":
                _parametersControllers.first["gamma"]?.value.text.toString(),
          },
          {
            "delta":
                _parametersControllers.first["delta"]?.value.text.toString(),
          },
          {
            "epsilon":
                _parametersControllers.first["epsilon"]?.value.text.toString(),
          }
        ],
        customData: [
          {
            "alpha":
                _customDataControllers.first["alpha"]?.value.text.toString(),
          },
          {
            "beta": _customDataControllers.first["beta"]?.value.text.toString(),
          },
          {
            "gamma":
                _customDataControllers.first["gamma"]?.value.text.toString(),
          },
          {
            "delta":
                _customDataControllers.first["delta"]?.value.text.toString(),
          },
          {
            "epsilon":
                _customDataControllers.first["epsilon"]?.value.text.toString(),
          }
        ],
      ),
    );
  }

  void _createPaymentRequest(BuildContext context) async {
    await FlutterPayOrc.instance.createPaymentWithWidget(
        context: context,
        request: createPayOrcPaymentRequest(),
        onPopResult: (String? pOrderId) async {
          // setState(() {
          //   _selectedCaptureMethod = null;
          //   _selectedClassName = null;
          //   _selectedAction = null;
          // });
          _clearAllFields();
          await _fetchTransaction(context, pOrderId);
        },
        errorResult: (message) {
          debugPrint('errorResult : $message');
          _showErrorAlert(context, message);
        });
  }

  Future<void> _fetchTransaction(BuildContext context, String? pOrderId) async {
    final transaction = await FlutterPayOrc.instance.fetchPaymentTransaction(
      orderId: pOrderId.toString(),
      onLoadingResult: (loading) {},
      errorResult: (message) {
        debugPrint('errorResult $message');
        _showErrorAlert(context, message);
      },
    );
    if (transaction != null && context.mounted) {
      debugPrint('transaction ${transaction.toJson()}');
      FlutterPayOrc.instance.clearData();
      Navigator.of(context).pop();
    }
  }

  void _showErrorAlert(BuildContext context, String? message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('$message'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void _clearAllFields() {
    _orderIdController.clear();
    _amountController.clear();
    _convenienceFeeController.clear();
    _quantityController.clear();
    _currencyController.clear();
    _descriptionController.clear();

    _customerIdController.clear();
    _nameController.clear();
    _emailController.clear();
    _mobileController.clear();
    _codeController.clear();

    _billingAddress1Controller.clear();
    _billingAddress2Controller.clear();
    _billingCityController.clear();
    _billingProvinceController.clear();
    _billingCountryController.clear();
    _billingPinController.clear();

    _shippingNameController.clear();
    _shippingEmailController.clear();
    _shippingCodeController.clear();
    _shippingMobileController.clear();
    _shippingAddress1Controller.clear();
    _shippingAddress2Controller.clear();
    _shippingCityController.clear();
    _shippingProvinceController.clear();
    _shippingCountryController.clear();
    _shippingPinController.clear();
    _locationPinController.clear();
    _shippingCurrencyController.clear();
    _shippingAmountController.clear();

    _successController.clear();
    _cancelController.clear();
    _failureController.clear();

    for (var map in _parametersControllers) {
      for (var controller in map.values) {
        controller.clear();
      }
    }

    for (var map in _customDataControllers) {
      for (var controller in map.values) {
        controller.clear();
      }
    }
  }
}

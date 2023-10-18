import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../components/alert_manager.dart';
import '../components/navigation_manager.dart';
import '../components/notification_manager.dart';
import '../components/route_manager.dart';

class PaymentItem extends StatelessWidget {
  final String amount;
  final String trxId;

  PaymentItem({required this.amount, required this.trxId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            amount,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
          subtitle: Text(
            trxId,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          onTap: () {
            // Handle notification item click
          },
        ),
        const Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}

class PaymentList {
  final List<PaymentItem> items;

  PaymentList({required this.items});

  factory PaymentList.fromJson(List<dynamic> json) {
    List<PaymentItem> items = [];

    for (var item in json) {
      items.add(PaymentItem(
        amount: item['amount'],
        trxId: item['transaction_id'],
      ));
    }

    return PaymentList(items: items);
  }
}

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController amountController = TextEditingController();
  String txRef = '';

  String userEmail = '';
  String fullName = '';
  String student = '';

  PaymentList? payments;

  var publicKey = '';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    fetchData();
    generateTransactionRef();
  }

  void generateTransactionRef() {
    const uuid = Uuid();
    txRef = uuid.v4();
  }

  Future<void> fetchData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // User not logged in, handle this case
      return;
    }

    final email = user.email;

    try {
      final response = await http.get(Uri.parse(
          'https://demosystem.pythonanywhere.com/student-details/?email=$email'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          student = data['student'];
          userEmail = data['student']['email'];
          fullName =
              '${data['student']['last_name']} ${data['student']['first_name']}';

          payments = PaymentList.fromJson(data['transactions']);
        });
      } else {
        // Handle API error
        print('Failed to load student details');
      }
    } catch (e) {
      // Handle other errors
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom Top Bar
            TopBar(context),

            // Payment Gateway Section
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 2,
                color: Colors.deepPurple[100],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CardTitle('Payment Gateway', Icons.payment),
                      const SizedBox(height: 16.0),
                      Center(
                        child: Column(
                          children: [
                            TextField(
                              controller: amountController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'Amount',
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () async {
                                infoFlushbar(context, "Please Wait",
                                    "Initializing payment...");
                                await plugin.initialize(publicKey: publicKey);
                                initiatePayment();
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.deepPurpleAccent),
                                minimumSize: MaterialStateProperty.all<Size>(
                                    const Size(200, 50)),
                              ),
                              child: const Text('Make Payment',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Payment Record
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
                elevation: 2,
                color: Colors.deepPurple[100],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CardTitle('Payment Records', Icons.money),
                      const SizedBox(height: 16.0),
                      if (payments == null || payments!.items.isEmpty)
                        const Text('No payment record available')
                      else
                        Column(
                          children: payments!.items,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
      bottomNavigationBar: BottomBar(context, 2),
    );
  }

  void initiatePayment() async {
    final amount = amountController.text;
    Charge charge = Charge()
      ..amount = int.parse(amount) * 100
      ..email = userEmail
      ..reference = txRef
      ..currency = 'NGN';

    try {
      CheckoutResponse response = await plugin.checkout(
        context,
        method: CheckoutMethod.card,
        charge: charge,
      );

      if (response.status == true) {
        // Payment successful
        savePaymentData(amount, 'Card', txRef);
        successFlushbar(context, "Success", "Payment Successful");
        Future.delayed(const Duration(seconds: 3), (){
          Navigator.of(context).push(createRoute(SuccessScreen()));
        });
      } else {
        // Payment failed
        errorFlushbar(context, "Payment Error", "${response.message}");
      }
    } catch (e) {
      // Handle payment errors or exceptions
      errorFlushbar(context, "Payment Error", "$e");
    }
  }

  void savePaymentData(
      String amount, String method, String transactionId) async {
    const apiUrl = 'https://demosystem.pythonanywhere.com/payment/';
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'email': userEmail,
      'amount': amount,
      'method': method,
      'transaction_id': transactionId,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      null;
    } else {
      errorFlushbar(context, "Error", "Error uploading payment data");
    }
  }
}

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Successful"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle,
              size: 100,
              color: Colors.green,
            ),
            Text(
              "Payment was successful!",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

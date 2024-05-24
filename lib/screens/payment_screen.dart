import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:student_portal/screens/payment_success.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import '../components/alert_manager.dart';
import '../components/drawer.dart';
import '../components/route_manager.dart';

class PaymentList {
  final String amount;
  final String trxId;
  final String time;

  PaymentList({required this.amount, required this.trxId, required this.time});

  factory PaymentList.fromJson(Map<String, dynamic> json) {
     return PaymentList(
        amount: json['amount'],
        trxId: json['transaction_id'],
       time: json['time'],
      );
  }
}

class PaymentScreen extends StatefulWidget {final String lastName;
  final String firstName;
  final String matricNumber;
  final String level;
  final String email;
  final String image;
  PaymentScreen({super.key, required this.lastName, required this.firstName, required this.email, required this.matricNumber, required this.level, required this.image});


  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  String? description;
  String txRef = '';
  String fullName = '';

  Future<List<PaymentList>?>? _transactions;

  late String lastName;
  late String firstName;
  late String matricNumber;
  late String level;
  late String email;
  late String image;

  var publicKey = '';
  final plugin = PaystackPlugin();

  @override
  void initState() {
    super.initState();
    lastName = widget.lastName;
    firstName = widget.firstName;
    email = widget.email;
    matricNumber = widget.matricNumber;
    level = widget.level;
    image = widget.image;
    plugin.initialize(publicKey: publicKey);
    generateTransactionRef();
    _transactions = fetchData();
  }

  void generateTransactionRef() {
    const uuid = Uuid();
    txRef = uuid.v4();
  }

  Future<List<PaymentList>?> fetchData() async {

    try {
      final response = await http.get(Uri.parse('https://demosystem.pythonanywhere.com/get_transactions/?email=${email}'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final List<dynamic> payments = data['transactions'];

        return payments.map((payment) => PaymentList.fromJson(payment)).toList();
      } else {
        // Handle API error
        errorFlushbar(context, 'Error', 'Unable to load data. Check your internet connection');
      }
    } catch (e) {
      // Handle other errors
      errorFlushbar(context, 'Error', 'An error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context, lastName, firstName, email, matricNumber, level, image),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
          'Payment Gateway',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.black,
            fontSize: 22,
            letterSpacing: 0,
          ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(16, 12, 16, 0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Make your payment',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          fontFamily: 'Outfit',
                          color: Colors.black,
                          letterSpacing: 0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Payment Form',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0, 0, 0, 16),
                              child: Container(
                                width: double.infinity,
                                child: DropdownButtonFormField<String>(
                                  value: description,
                                  hint: Row(
                                    children: <Widget>[
                                      Text(
                                          'Select Payment Description',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.0,
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0,
                                          )
                                      ),
                                    ],
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      description = newValue;
                                    });
                                  },
                                  items: [
                                    'School Fees',
                                    'Fine',
                                  ].map((String desc) {
                                    return DropdownMenuItem<String>(
                                      value: desc,
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                              desc,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16.0,
                                                fontFamily: 'Plus Jakarta Sans',
                                                letterSpacing: 0,
                                              )
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  dropdownColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelStyle:
                                    TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontFamily: 'Outfit',
                                      letterSpacing: 0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                        Colors.white,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                        Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                        Colors.redAccent,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder:
                                    OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                        Colors.redAccent,
                                        width: 2,
                                      ),
                                      borderRadius:
                                      BorderRadius.circular(12),
                                    ),
                                    filled: true,
                                    fillColor:
                                    Colors.grey[100],
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: 16.0,
                                    fontFamily: 'Plus Jakarta Sans',
                                    letterSpacing: 0,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 0),
                              child:
                              Column(mainAxisSize: MainAxisSize.max, children: [
                                TextFormField(
                                  controller: amountController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Amount',
                                    labelStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: 'Outfit',
                                      color: Colors.grey,
                                      letterSpacing: 0,
                                    ),
                                    hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                      fontFamily: 'Outfit',
                                      color: Colors.grey,
                                      letterSpacing: 0,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.redAccent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.redAccent,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    contentPadding: EdgeInsetsDirectional.fromSTEB(
                                        16, 12, 16, 12),
                                  ),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.0,
                                    fontFamily: 'Outfit',
                                    color: Colors.black,
                                    letterSpacing: 0,
                                  ),
                                  cursorColor: Colors.grey,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ]),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 12),
                              child: ElevatedButton(
                                onPressed: () async {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsets.only(right: 8.0),
                                          child: Icon(
                                            Icons.payment,
                                            size: 16.0,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        Text(
                                          'Processing Payment...',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    elevation: 2,
                                    width: 350.0,
                                    behavior: SnackBarBehavior.floating,
                                  ));
                                  await plugin.initialize(publicKey: publicKey);
                                  initiatePayment();
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(
                                      Colors.deepPurple),
                                  fixedSize: MaterialStateProperty.all<Size>(
                                      const Size(double.infinity, 48)),
                                  elevation: MaterialStateProperty.all<double>(4),
                                  shadowColor: MaterialStateProperty.all<Color>(
                                      Colors.white),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 0, 0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(right: 8.0),
                                            child: Icon(
                                              Icons.payments,
                                              color: Colors.white,
                                              size: 16.0,
                                            ),
                                          ),
                                          Text(
                                            'Make Payment',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontSize: 16.0,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                        child: Text(
                          'Payment Transactions',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 24.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 4),
                        child: Text(
                          'View recent transactions below',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            fontFamily: 'Outfit',
                            color: Colors.black,
                            letterSpacing: 0,
                          ),
                        ),
                      ),
                      FutureBuilder<List<PaymentList>?>(
                          future: _transactions,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const Center(
                                  child: Padding(
                                      padding: EdgeInsets.only(top: 20.0),
                                      child:
                                      CircularProgressIndicator())); // Show a loading indicator.
                            } else if (snapshot.hasError || snapshot.data == null) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    'Failed to load transactions',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              ); // Show an error message.
                            } else if (snapshot.data!.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    'No transaction available',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      fontFamily: 'Plus Jakarta Sans',
                                      letterSpacing: 0,
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              final transactions = snapshot.data!;
                              return Column(
                                children: transactions.map((transaction) {
                                  return Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                                    child: InkWell(
                                      splashColor: Colors.transparent,
                                      focusColor: Colors.transparent,
                                      hoverColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      child: Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(
                                              16, 12, 16, 0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {},
                                            child: Container(
                                              width: MediaQuery.sizeOf(context).width,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[50],
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 3,
                                                    color: Color(0x411D2429),
                                                    offset: Offset(
                                                      0.0,
                                                      1,
                                                    ),
                                                  )
                                                ],
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(8),
                                                child: Row(
                                                  mainAxisSize: MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional.fromSTEB(
                                                          0, 1, 1, 1),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius.circular(8),
                                                        child: Icon(
                                                          Icons.payments,
                                                          size: 16.0,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding: EdgeInsetsDirectional
                                                            .fromSTEB(8, 0, 4, 0),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.center,
                                                          crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              transaction.amount,
                                                              style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.bold,
                                                                fontSize: 22.0,
                                                                fontFamily: 'Outfit',
                                                                letterSpacing: 0,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  0, 4, 8, 0),
                                                              child: Text(
                                                                transaction.trxId,
                                                                textAlign:
                                                                TextAlign.start,
                                                                style: TextStyle(
                                                                  fontFamily:
                                                                  'Plus Jakarta Sans',
                                                                  fontSize: 12,
                                                                  letterSpacing: 0,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsetsDirectional
                                                              .fromSTEB(0, 0, 4, 8),
                                                          child: Text(
                                                            transaction.time,
                                                            textAlign: TextAlign.end,
                                                            style: TextStyle(
                                                              fontFamily:
                                                              'Plus Jakarta Sans',
                                                              letterSpacing: 0,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            }
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initiatePayment() async {
    final amount = amountController.text;
    Charge charge = Charge()
      ..amount = int.parse(amount) * 100
      ..email = email
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
        savePaymentData(amount, description!, 'Card', txRef);
        successFlushbar(context, "Success", 'Payment Successful!');
        Navigator.of(context).push(createRoute(PaymentSuccessScreen()));
      } else {
        // Payment failed
        errorFlushbar(context, "Error", 'Payment Failed!');
      }
    } catch (e) {
      // Handle payment errors or exceptions
      errorFlushbar(context, "Error", "An error occured!");
    }
  }

  void savePaymentData(String amount, String description, String method, String transactionId) async {
    const apiUrl = 'https://demosystem.pythonanywhere.com/payment/';
    final headers = {'Content-Type': 'application/json'};
    final data = {
      'email': email,
      'amount': amount,
      'method': method,
      'transaction_id': transactionId,
      'description': description,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: json.encode(data),
    );

    if (response.statusCode == 201) {
      null;
    } else {
      errorFlushbar(context, "Error", "Payment Failed! Check your internet connection.");
    }
  }
}

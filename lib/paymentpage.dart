import 'package:flutter/material.dart';

import 'menupage.dart';
import 'orderpage.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Payment'),
        leading: IconButton(
          onPressed: () => {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Menu()))
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Order(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(
            icon: const Icon(
              Icons.history,
              color: Colors.white,
            ),
            onPressed: () => _history(),
          )
        ],
      ),
      body: Center(
        child: Builder(
          builder: (context) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: InkWell(
                onTap: () => _pay(),
                child: Card(
                  color: Colors.red,
                  elevation: 15,
                  child: SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const <Widget>[
                          Text(
                            "Card Payment",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.payment,
                            color: Colors.white,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _history() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: const <Widget>[
                  Text(
                    'Transaction History',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _pay() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: const [
                  Text("Enter you card details"),
                  TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: 'Card Number',
                      )),
                  TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: 'Expiry Date',
                      )),
                  TextField(
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: 'CVV',
                      )),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Confirm"),
                onPressed: _show,
              ),
              TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _show() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: const [
                  Text("Your order(s) have been placed. Thank you!"),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: const Text('OK', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}

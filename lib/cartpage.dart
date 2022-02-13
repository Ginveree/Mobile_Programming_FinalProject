import 'package:flutter/material.dart';
import 'package:mhfinalproject/paymentpage.dart';
import 'motorcycle_object.dart';

class Cart extends StatefulWidget {
  final List<Motorcycle> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);

  final List<Motorcycle> _cart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index) {
            var item = _cart[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  title: Text(item.name),
                  trailing: GestureDetector(
                      child: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          _cart.remove(item);
                        });
                      }),
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () => {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Payment()))
        },
        label: const Text("PLACE ORDER"),
      ),
    );
  }
}

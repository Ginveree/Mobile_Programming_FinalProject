import 'package:flutter/material.dart';
import 'paymentpage.dart';
import 'aboutpage.dart';
import 'loginpage.dart';
import 'orderpage.dart';

void main() async {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, initialRoute: '/', routes: {
      '/': (context) => Menu(),
      '/detail': (context) => const MoveToDetails(
          image: '', model: '', price: '', stockleft: '', fuel: '', colour: ''),
    }),
  );
}

class Images {
  final String image;
  final String model;
  final String price;
  final String stockleft;
  final String fuel;
  final String colour;
  Images(this.image, this.model, this.price, this.stockleft, this.fuel,
      this.colour);
}

class Menu extends StatelessWidget {
  final List<Images> _items = [
    Images("https://flutterlab2database.000webhostapp.com/images/1_1.jpg",
        "RZM250H-10", "4937.00", "12", "Diesel", "Green, Blue, Black"),
    Images("https://flutterlab2database.000webhostapp.com/images/2_1.jpg",
        "RZM250H-9", "4937.00", "10", "Gas", "White, Maroon"),
    Images("https://flutterlab2database.000webhostapp.com/images/3_1.jpg",
        "KD 125AS-1", "2928.00", "5", "Diesel", "Red"),
    Images("https://flutterlab2database.000webhostapp.com/images/4_1.jpg",
        "D2D", "8200.00", "16", "Gas", "Black, Gray"),
    Images("https://flutterlab2database.000webhostapp.com/images/5_1.jpg",
        "JM150-49 EAGLE", "2447.00", "6", "Diesel", "Black, Yellow"),
    Images("https://flutterlab2database.000webhostapp.com/images/6_1.jpg",
        "YJ110-8B", "2004.00", "18", "Gas", "Blue Red"),
    Images("https://flutterlab2database.000webhostapp.com/images/7_1.jpg",
        "F19", "5229.00", "3", "Diesel", "Matte Black"),
    Images("https://flutterlab2database.000webhostapp.com/images/8_1.jpg",
        "EAGLE 8", "3589.00", "4", "Gas", "Orange"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products by Mh Motorcycle"),
        backgroundColor: Colors.red,
        leading: PopupMenuButton<int>(
          color: Colors.red,
          onSelected: (item) => onSelected(context, item),
          itemBuilder: (context) => [
            const PopupMenuItem<int>(
              value: 0,
              child: Text('Payment',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            const PopupMenuItem<int>(
              value: 1,
              child: Text('About Us',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            const PopupMenuItem<int>(
              value: 2,
              child: Text('Logout',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          crossAxisCount: 2,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MoveToDetails(
                          image: _items[index].image,
                          model: _items[index].model,
                          price: _items[index].price,
                          stockleft: _items[index].stockleft,
                          fuel: _items[index].fuel,
                          colour: _items[index].colour,
                        )),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(_items[index].image),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () => {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const Order()))
        },
        label: const Text("BUY NOW"),
      ),
    );
  }
}

void onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const Payment()),
      );
      break;
    case 1:
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const About()),
      );
      break;
    case 2:
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
      break;
  }
}

class MoveToDetails extends StatelessWidget {
  final String image;
  final String model;
  final String price;
  final String stockleft;
  final String fuel;
  final String colour;

  const MoveToDetails(
      {Key? key,
      required this.image,
      required this.model,
      required this.price,
      required this.stockleft,
      required this.fuel,
      required this.colour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.5,
            child: SizedBox(
              width: double.infinity,
              child: Image(
                image: NetworkImage(image),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Model: " + model,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Price: RM " + price,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Stock Left: " + stockleft,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Fuel: " + fuel,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Colour: " + colour,
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

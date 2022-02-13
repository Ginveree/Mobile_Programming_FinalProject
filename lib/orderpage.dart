import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'aboutpage.dart';
import 'menupage.dart';
import 'paymentpage.dart';
import 'cartpage.dart';
import 'motorcycle_object.dart';

void main() => runApp(const Order());

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MH MOTORCYCLE',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Order now'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Motorcycle> _motorcycle = <Motorcycle>[];

  final List<Motorcycle> _cartList = <Motorcycle>[];

  @override
  void initState() {
    super.initState();
    _allMotorcycles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          onPressed: () => {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Menu()))
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  const Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  if (_cartList.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _cartList.length.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (_cartList.isNotEmpty) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(_cartList),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "Nothing in Cart!",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 1,
                      fontSize: 14.0);
                }
              },
            ),
          )
        ],
      ),
      body: _buildGridView(),
    );
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: _motorcycle.length,
      itemBuilder: (context, index) {
        var item = _motorcycle[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 2.0,
          ),
          child: Card(
            elevation: 4.0,
            child: ListTile(
              title: Text(
                item.name,
              ),
              trailing: GestureDetector(
                child: (!_cartList.contains(item))
                    ? const Icon(
                        Icons.add_circle,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                onTap: () {
                  setState(() {
                    if (!_cartList.contains(item)) {
                      _cartList.add(item);
                    } else {
                      _cartList.remove(item);
                    }
                  });
                },
              ),
            ),
          ),
        );
      },
    );
  }

  GridView _buildGridView() {
    return GridView.builder(
        padding: const EdgeInsets.all(4.0),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _motorcycle.length,
        itemBuilder: (context, index) {
          var item = _motorcycle[index];
          return Card(
              elevation: 4.0,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(item.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: (!_cartList.contains(item))
                            ? const Icon(
                                Icons.add_circle,
                                color: Colors.green,
                              )
                            : const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                        onTap: () {
                          setState(() {
                            if (!_cartList.contains(item)) {
                              _cartList.add(item);
                              Fluttertoast.showToast(
                                  msg:
                                      "Limited to ONE item per purchase for each order",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 5,
                                  fontSize: 14.0);
                            } else {
                              _cartList.remove(item);
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  void _allMotorcycles() {
    var list = <Motorcycle>[
      Motorcycle(
        name: 'RZM250H-10',
      ),
      Motorcycle(
        name: 'RZM250H-9',
      ),
      Motorcycle(
        name: 'KD 125AS-1',
      ),
      Motorcycle(
        name: 'D2D',
      ),
      Motorcycle(
        name: 'JM150-49 EAGLE',
      ),
      Motorcycle(
        name: 'YJ110-8B',
      ),
      Motorcycle(
        name: 'F19',
      ),
      Motorcycle(
        name: 'EAGLE 8',
      ),
    ];

    setState(() {
      _motorcycle = list;
    });
  }
}

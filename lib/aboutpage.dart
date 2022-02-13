import 'package:flutter/material.dart';
import 'menupage.dart';
import 'orderpage.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
        title: const Text('About Us'),
        leading: IconButton(
          onPressed: () => {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext context) => Menu()))
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset('assets/images/mh.png'),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: const [
                  Text(
                    "MH MOTORCYCLE",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "----- Our Story -----",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "MH Motorcycle was founded by Mr Kam in year 2008. It was Mr Kam's dream to open a motorcycle shop since he was the age of 6 and with all the hardworks, he managed to open one by himself.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please feel free to contact us:",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Contact Number: 012-3456789",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Email: mh@email.com",
                    style: TextStyle(fontSize: 15),
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

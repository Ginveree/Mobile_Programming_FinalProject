import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mhfinalproject/model/config.dart';
import 'package:mhfinalproject/model/user.dart';
import 'loginpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  late double screenHeight, screenWidth, resWidth;
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth * 0.85;
    } else {
      resWidth = screenWidth * 0.75;
    }
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(child: Image.asset('assets/images/mh.png'), width: resWidth),
          const CircularProgressIndicator(),
          Text(
            "Version 0.1",
            style: TextStyle(
                fontSize: resWidth * 0.05,
                color: Colors.red,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  checkAndLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    late User user;
    if (email.length > 1 && password.length > 1) {
      http.post(Uri.parse(MyConfig.server + "/php/login.php"),
          body: {"email": email, "password": password}).then((response) {
        if (response.statusCode == 200 && response.body != "failed") {
          final jsonResponse = json.decode(response.body);
          user = User.fromJson(jsonResponse);
          Timer(
              const Duration(seconds: 5),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (content) => const LoginPage())));
        } else {
          user = User(
              id: "na",
              name: "na",
              email: "na",
              password: "na",
              phone: "na",
              address: "na",
              otp: "na",
              credit: 'na');
          Timer(
              const Duration(seconds: 3),
              () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (content) => const LoginPage())));
        }
      }).timeout(const Duration(seconds: 5));
    } else {
      user = User(
          id: "na",
          name: "na",
          email: "na",
          password: "na",
          phone: "na",
          address: "na",
          otp: "na",
          credit: '');
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (content) => const LoginPage())));
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mhfinalproject/model/config.dart';
import 'package:mhfinalproject/model/user.dart';
import 'package:mhfinalproject/registerpage.dart';
import 'menuguestpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ndialog/ndialog.dart';
import 'menupage.dart';
import 'forgotpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double screenHeight, screenWidth, resWidth;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.70;
    }

    return Scaffold(
      //backgroundColor: Colors.red,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [upperHalf(context), lowerHalf(context)],
          ),
        ),
      ),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: Theme.of(context).textTheme.headline4!.fontSize! * 1.5 + 170.0,
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/images/mh.png',
      ),
      transform: Matrix4.rotationZ(0.07),
    );
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
        width: resWidth,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Card(
                elevation: 10,
                child: Container(
                    padding: const EdgeInsets.fromLTRB(25, 25, 20, 45),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              style: const TextStyle(color: Colors.black),
                              textInputAction: TextInputAction.next,
                              validator: (val) => val!.isEmpty ||
                                      !val.contains("@") ||
                                      !val.contains(".")
                                  ? "Field cannot be blank"
                                  : null,
                              focusNode: focus,
                              onFieldSubmitted: (v) {
                                FocusScope.of(context).requestFocus(focus1);
                              },
                              controller: _emailditingController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                  labelStyle: TextStyle(),
                                  labelText: 'Email',
                                  hintText: 'abc@gmail.com',
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.grey,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(width: 2.0),
                                  ))),
                          TextFormField(
                            style: const TextStyle(),
                            textInputAction: TextInputAction.done,
                            validator: (val) =>
                                val!.isEmpty ? "Field cannot be blank" : null,
                            focusNode: focus1,
                            onFieldSubmitted: (v) {
                              FocusScope.of(context).requestFocus(focus2);
                            },
                            controller: _passEditingController,
                            decoration: InputDecoration(
                                labelStyle: const TextStyle(),
                                labelText: 'Password',
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(width: 2.0),
                                )),
                            obscureText: _passwordVisible,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _isChecked,
                                      activeColor: Colors.red,
                                      onChanged: (bool? value) {
                                        _onRememberMeChanged(value!);
                                      },
                                    ),
                                    const Text('Remember me',
                                        style: TextStyle(
                                          fontSize: 16,
                                        )),
                                  ],
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const ForgotPassword()));
                                  },
                                  child: const Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 15),
                                  ),
                                ),
                              ]),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                fixedSize: Size(screenWidth / 1, 45)),
                            child: const Text('Login',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            onPressed: _loginUser,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: Colors.red,
                                fixedSize: Size(screenWidth / 1, 45)),
                            child: const Text('Login as guest',
                                style: TextStyle(
                                  fontSize: 18,
                                )),
                            onPressed: () => {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MenuGuest()))
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text("Don't have an account? ",
                                  style: TextStyle(fontSize: 16.0)),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const RegisterPage()))
                                },
                                child: const Text(
                                  "Sign up",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.red,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ))),
          ],
        )));
  }

  void _loginUser() {
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      _isChecked = false;
      return;
    }
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Loading..."), title: const Text("Logging in"));
    progressDialog.show();

    String _email = _emailditingController.text;
    String _pass = _passEditingController.text;
    http.post(Uri.parse(MyConfig.server + "login_user.php"),
        body: {"Email": _email, "Password": _pass}).then((response) {
      if (response.statusCode == 200 && response.body != "failed") {
        final jsonResponse = json.decode(response.body);

        print(response.body);
        User user = User.fromJson(jsonResponse);
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        // progressDialog.dismiss();
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => Menu()));
      } else {
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
      }
      progressDialog.dismiss();
    });
  }

  void saveremovepref(bool value) async {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Please fill in the login credentials",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      _isChecked = false;
      return;
    }
    FocusScope.of(context).requestFocus(FocusNode());
    FocusScope.of(context).unfocus();
    String email = _emailditingController.text;
    String password = _passEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      //save preference
      await prefs.setString('email', email);
      await prefs.setString('pass', password);
      Fluttertoast.showToast(
          msg: "Preference Stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('pass', '');
      setState(() {
        _emailditingController.text = '';
        _passEditingController.text = '';
        _isChecked = false;
      });
      Fluttertoast.showToast(
          msg: "Preference Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    }
  }

  void _onRememberMeChanged(bool newValue) => setState(() {
        _isChecked = newValue;
        if (_isChecked) {
          saveremovepref(true);
        } else {
          saveremovepref(false);
        }
      });

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('pass')) ?? '';
    if (email.length > 1 && password.length > 1) {
      setState(() {
        _emailditingController.text = email;
        _passEditingController.text = password;
        _isChecked = true;
      });
    }
  }
}

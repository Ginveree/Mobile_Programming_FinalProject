import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'menupage.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  late double screenHeight, screenWidth, resWidth;
  final focus = FocusNode();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();

  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;

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
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Forgot Password'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const LoginPage()));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
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
      child: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25, 20, 20, 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        textInputAction: TextInputAction.next,
                        validator: (val) => val!.isEmpty ||
                                !val.contains("@") ||
                                !val.contains(".")
                            ? "enter a valid email"
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
                            icon: Icon(
                              Icons.email,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 2.0),
                            ))),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      validator: (val) => validatePassword(val.toString()),
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      style: const TextStyle(),
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        validatePassword(val.toString());
                        if (val != _passEditingController.text) {
                          return "password do not match";
                        } else {
                          return null;
                        }
                      },
                      focusNode: focus2,
                      onFieldSubmitted: (v) {
                        FocusScope.of(context).requestFocus(focus3);
                      },
                      controller: _pass2EditingController,
                      decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(),
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
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          fixedSize: Size(screenWidth / 1, 45)),
                      child: const Text('Confirm and Log in now'),
                      onPressed: _show,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _show() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: Column(
                children: const [
                  Text("Password has been successfully changed. Logging in..."),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: const Text('OK', style: TextStyle(color: Colors.red)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Menu()));
                  }),
            ],
          );
        });
  }
}

String? validatePassword(String value) {
  // String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$';
  RegExp regex = RegExp(pattern);
  if (value.isEmpty) {
    return 'Please enter password';
  } else {
    if (!regex.hasMatch(value)) {
      return 'Enter valid password';
    } else {
      return null;
    }
  }
}

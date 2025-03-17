import 'dart:core';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Entities/User.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Pages/Signuppage.dart';
import 'package:zaucy/Services/UserServices.dart';
import 'package:zaucy/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _otpcontroller = TextEditingController();
  bool _obscureText = true;
  String? otpcode = ""; // For password visibility

  void initState() {
    super.initState();
    otpcode = "";
  }

  Future<void> getotp2(String username) async {
    try {
      Userservices userServices = Userservices();
      String? otp = await userServices.getOtp(username);

      if (otp != null) {
        otpcode = otp;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Invalid Username')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('UnExpected Error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 218, 1),
      body: Center(
        child: SingleChildScrollView(
          // Prevents overflow on smaller screens
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Lottie Animation (replace with your Lottie file)
                Center(child: Image.asset("assets/logo.png")),

                // Email Input
                TextFormField(
                  controller: _userController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Username';
                    }
                    // You can add more email validation here
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            getotp2(_userController.text);
                          });
                          setState(() {});
                        },
                        child: Text("Generate OTP")),
                    SizedBox(width: 10),
                    Container(
                        color: Colors.white,
                        height: 20,
                        width: 80,
                        child: Text(otpcode.toString()))
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _otpcontroller,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'OTP',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your OTP';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      "First time on Application Lets ",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.w200),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Signuppage()));
                      },
                      child: Text(
                        "Register User",
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Perform login logic here (e.g., API call)
                      String username = _userController.text;
                      String otp = _otpcontroller.text;

                      String? token = await Userservices().Login(username, otp);
                      print("-----------");
                      print(token);
                      if (token != "Login Failed Try Again" &&
                          token != "Wrong Credentials" &&
                          token != "Invalid username or password") {
                        await storage.write(key: 'auth_token', value: token);
                        await storage.write(key: 'username', value: username);
                        await storage.write(key: 'OTP', value: otp);
                        User? user = await Userservices().getUser(token);
                        globaluser22 = user;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListviewPizza()));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Wrong Credentials Try Again")));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

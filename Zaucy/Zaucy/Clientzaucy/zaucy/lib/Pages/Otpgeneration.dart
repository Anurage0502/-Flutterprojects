import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:zaucy/Entities/User.dart';
import 'package:zaucy/Pages/HomePage.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Services/UserServices.dart';
import 'package:zaucy/main.dart';

class Otpgeneration extends StatefulWidget {
  late final String username;
  Otpgeneration({required this.username});

  @override
  State<Otpgeneration> createState() => _OtpgenerationState();
}

class _OtpgenerationState extends State<Otpgeneration> {
  final TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late final String username;
  void initState() {
    super.initState();
    username = widget.username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Pinput(
              length: 6,
              controller: _otpController,
              onCompleted: (otp) async {
                // Perform login logic here (e.g., API call)

                String? token = await Userservices().Login(username, otp);
                print(token);
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Homepage()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Wrong Credentials Try Again")));
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _otpController.clear(); // Clears OTP so user can enter again
              },
              child: Text("Clear OTP"),
            ),
            ElevatedButton(
              onPressed: () async {},
              child: Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}

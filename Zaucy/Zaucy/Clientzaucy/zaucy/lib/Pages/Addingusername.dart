import 'package:flutter/material.dart';
import 'package:zaucy/Entities/User.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Pages/Otpgeneration.dart';
import 'package:zaucy/Services/UserServices.dart';
import 'package:zaucy/main.dart';

class Addingusername extends StatefulWidget {
  const Addingusername({super.key});

  @override
  State<Addingusername> createState() => _AddingusernameState();
}

class _AddingusernameState extends State<Addingusername> {
  final _userController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? otpcode = "";

  Future<void> getotp2(String username) async {
    try {
      Userservices userServices = Userservices();
      String? otp = await userServices.getOtp(username);

      if (otp != null) {
        otpcode = otp;
        print(otp);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Otpgeneration(username: _userController.text)));
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        backgroundColor: Colors.white,
        flexibleSpace: Column(
          children: [
            Row(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align items to top
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15),
                  child: ImageIcon(
                    AssetImage("assets/logo.png"),
                    color: Color.fromARGB(255, 132, 21, 13),
                    size: 70,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 30),
                  child: Text(
                    "Zaucy",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 8,
                ),
                Icon(Icons.discount),
                SizedBox(
                  width: 10,
                ),
                Text("Personalized\nOffers"),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.local_pizza),
                SizedBox(
                  width: 10,
                ),
                Text("Loyalty\nRewards"),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.payments_outlined),
                SizedBox(
                  width: 10,
                ),
                Text("Easy\nPayments")
              ],
            ),
            Spacer(),
            Container(
              height: 1,
              color: Colors.black,
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          Center(
              child:
                  Opacity(opacity: 0.7, child: Image.asset("assets/logo.png"))),
          Column(
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login to unlock awesome Benifits",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
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
              ),
              Spacer(),
              Text(otpcode.toString()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      getotp2(_userController.text);
                    });
                    setState(() {});
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    shadowColor: Colors.black,
                    backgroundColor: const Color.fromARGB(205, 82, 38, 11),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: Container(
                    height: 20,
                    width: screenWidth - 30,
                    child: Center(
                      child: const Text(
                        'Sent OTP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zaucy/Entities/User.dart';
import 'package:zaucy/Pages/ListviewPizza.dart';
import 'package:zaucy/Services/UserServices.dart';
import 'package:zaucy/main.dart';

class Signuppage extends StatefulWidget {
  @override
  _SignuppageState createState() => _SignuppageState();
}

class _SignuppageState extends State<Signuppage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _Username = TextEditingController();
  bool _obscureText = true; // For password visibility

  Future<User?> NewUser(BuildContext context, String username, String password,
      String email) async {
    try {
      // You can replace this with an actual API call to add the item on the server
      User? user = await Userservices().signup(username, password, email);

      // Add the new item to the local cartItems list
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Yayy Welcome to Zaucy')),
        );
        return user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User Already Exist')),
        );
      }

      return null;
    } catch (e) {
      return null;
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

                const SizedBox(height: 20),

                // Email Input
                TextFormField(
                  controller: _Username,
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

                // Password Input
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(_obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your EmailId';
                    }
                    // You can add more email validation here
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // Login Button
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Perform login logic here (e.g., API call)
                      String username = _Username.text;
                      String password = _passwordController.text;
                      String email = _emailController.text;
                      User? user =
                          await NewUser(context, username, password, email);
                      globaluser22 = user;
                      if (globaluser22 != null) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ListviewPizza()));
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
                  child: const Text('Signup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

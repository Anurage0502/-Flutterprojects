import 'package:flutter/material.dart';
import 'package:zaucy/Pages/HomePage.dart';

class Errorpage extends StatelessWidget {
  int konta = 1;
  Errorpage({required this.konta});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Homepage()));
        }
      },
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: const Color.fromARGB(255, 220, 244, 250),
          body: konta == 1
              ? Column(
                  children: [
                    Center(
                        child: Image.network(
                            scale: 0.1,
                            "https://internetdevels.com/sites/default/files/public/blog_preview/404_page_cover.jpg")),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Homepage()));
                      },
                      child: Text("Go to Home Page"),
                    )
                  ],
                )
              : Center(child: Text("List is Empty"))),
    );
  }
}

import 'package:adminzaucy/addorupdate.dart';
import 'package:adminzaucy/addpizza.dart';
import 'package:adminzaucy/api_service.dart';
import 'package:adminzaucy/main.dart';
import 'package:adminzaucy/menu.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

late Future<List<Menu>> Futuremenu;

class ManagePizza extends StatefulWidget {
  const ManagePizza({super.key});

  @override
  State<ManagePizza> createState() => _ManagePizzaState();
}

class _ManagePizzaState extends State<ManagePizza> {
  @override
  void initState() {
    super.initState();
    Futuremenu = ApiService().fetchallmenu();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 218, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 44, 102, 46),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: FutureBuilder(
          future: Futuremenu,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Lottie.asset("assets/Animation - 1738221790666.json"));
            } else if (snapshot.hasError) {
              print(snapshot.data);
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final menuitems = snapshot.data!;
              MenuList = menuitems;
              print(menuitems);
              return Stack(
                children: [
                  Center(child: Image.asset("assets/logo.png")),
                  ListView.builder(
                      itemCount: menuitems.length,
                      itemBuilder: (context, index) {
                        final menuItem = menuitems[index];
                        return Card(
                          margin:
                              EdgeInsets.all(16), // Adds space between cards
                          elevation: 4, // Adds shadow for 3D effect
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                          ),
                          child: Container(
                            height: 200, // Increases the height of the card
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        const Color.fromARGB(255, 44, 102, 46),
                                    width: 2)), // Adds padding inside the card
                            child: Row(
                              children: [
                                Container(
                                  width: 200,
                                  height: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        20), // Set the border radius
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        10), // Apply the same border radius to the image
                                    child: Image.network(
                                      menuItem.imageUrl,
                                      fit: BoxFit
                                          .cover, // Makes sure the image covers the area without distortion
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(menuItem.name,
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold)),
                                    Text('₹${menuItem.price}',
                                        style: TextStyle(fontSize: 24)),
                                    Text('Size:${menuItem.size}',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w400)),
                                  ],
                                ),
                                Spacer(),
                                IconButton(
                                    iconSize: 40,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => addorupdate(
                                                    name: menuItem.name,
                                                    price: menuItem.price,
                                                    description:
                                                        menuItem.description,
                                                    size: menuItem.size,
                                                    imageUrl: menuItem.imageUrl,
                                                    id: menuItem.id,
                                                  )));
                                    },
                                    icon: Icon(Icons.update)),
                                IconButton(
                                    iconSize: 40,
                                    onPressed: () async {
                                      await ApiService()
                                          .deleteMenuItem(menuItem.id);

                                      menuitems.removeWhere(
                                          (item) => item.id == menuItem.id);

                                      // Step 3: Call setState to refresh the UI
                                      setState(() {});
                                    },
                                    icon: Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        );
                      })
                ],
              );
            }
          }),
      floatingActionButton: Container(
        height: 60,
        width: 100,
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 44, 102, 46), width: 2)),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Addpizza()));
          },
          child: Center(child: Text("Add")),
        ),
      ),
    );
  }
}

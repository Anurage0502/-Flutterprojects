import 'package:adminzaucy/api_service.dart';
import 'package:adminzaucy/manage_pizza.dart';
import 'package:adminzaucy/menu.dart';
import 'package:flutter/material.dart';

  class addorupdate extends StatefulWidget {
  late final String name;
  late final double price;
  late final String description;
  late final String size;
  late final String imageUrl;
  late final String? id;
  addorupdate({
    this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.size,
    required this.imageUrl,
  });

  @override
  State<addorupdate> createState() => _addorupdateState();
}

class _addorupdateState extends State<addorupdate> {
  late final String name;
  late final double price;
  late final String description;
  late final String size;
  late final String imageUrl;
  late final String? id;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _sizeController = TextEditingController();
  final _imageUrlController = TextEditingController();
  bool isLoading = false;

  void _createMenuItem() async {
    final newMenu = Menu(
      name: _nameController.text,
      description: _descriptionController.text,
      price: double.tryParse(_priceController.text) ?? 0.0,
      size: _sizeController.text,
      imageUrl: _imageUrlController.text,
    );

    setState(() {
      isLoading = true;
    });

    try {
      // Call the service to create the menu item
      await ApiService().updateMenuItem(id, newMenu);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Menu item created')));
      // Optionally, navigate back or reset the form
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed to create menu item')));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    name = widget.name;
    price = widget.price;
    description = widget.description;
    size = widget.size;
    imageUrl = widget.imageUrl;
    id = widget.id;
    _nameController.text = name;
    _priceController.text = price.toString();
    _descriptionController.text = description;
    _sizeController.text = size;
    _imageUrlController.text = imageUrl;
  }

  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _sizeController.dispose();
    _imageUrlController.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 243, 218, 1),
      appBar: AppBar(
        title: Text("Update Menu Item "),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ManagePizza()));
                setState(() {});
              },
              icon: Icon(Icons.close)),
        ],
      ),
      body: Stack(
        children: [
          Center(
              child:
                  Opacity(opacity: 0.6, child: Image.asset("assets/logo.png"))),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _nameController,
                    maxLines: null, // Allows multiline editing
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _priceController,
                    maxLines: null, // Allows multiline editing
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _descriptionController,
                    maxLines: null, // Allows multiline editing
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _sizeController,
                    maxLines: null, // Allows multiline editing
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Size",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _imageUrlController,
                    maxLines: null, // Allows multiline editing
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Image URL",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(16),
                    ),
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                  onPressed: () {
                    _createMenuItem();
                  },
                  child: Text('Update Menu Item')),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

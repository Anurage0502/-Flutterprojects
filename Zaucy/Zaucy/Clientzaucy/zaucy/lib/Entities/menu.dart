class Menu {
  final String id;
  final String name;
  final double price;
  final String description;
  final String size;
  final String imageUrl;
  bool? isVeg; // Added isVeg field

  // Constructor
  Menu({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.size,
    required this.imageUrl,
    this.isVeg, // Added isVeg to constructor
  });

  // From JSON (Deserialization)
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] ?? 0.0).toDouble(),
      description: json['description'] as String,
      size: json['size'] as String,
      imageUrl:
          json['image_url'] as String, // Matching the key with 'image_url'
      isVeg: json['isveg'] as bool, // Fetching isveg from JSON
    );
  }

  // To JSON (Serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'size': size,
      'image_url': imageUrl, // Matching the key with 'image_url'
      // Adding isVeg to JSON
    };
  }
}

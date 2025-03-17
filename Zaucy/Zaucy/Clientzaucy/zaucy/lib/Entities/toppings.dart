class Topping {
  final int id;
  final String name;
  final double price;

  Topping({
    required this.id,
    required this.name,
    required this.price,
  });

  // Override equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Topping && other.id == id;
  }

  // Override hashCode
  @override
  int get hashCode => id.hashCode;

  // Factory constructor to create a Topping from JSON
  factory Topping.fromJson(Map<String, dynamic> json) {
    return Topping(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(), // Ensure it's a double
    );
  }

  // Method to convert Topping to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}

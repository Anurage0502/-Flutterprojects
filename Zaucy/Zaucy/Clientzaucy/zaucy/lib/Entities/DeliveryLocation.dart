class DeliveryBoyLocation {
  int? deliveryBoyId;
  double latitude;
  double longitude;

  DeliveryBoyLocation({
    this.deliveryBoyId,
    required this.latitude,
    required this.longitude,
  });

  // Convert JSON to Dart Object
  factory DeliveryBoyLocation.fromJson(Map<String, dynamic> json) {
    return DeliveryBoyLocation(
      deliveryBoyId: json['deliveryBoyId'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  // Convert Dart Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'deliveryBoyId': deliveryBoyId,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

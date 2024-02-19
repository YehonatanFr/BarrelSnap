class WineModel {
  final String id;
  final String name;
  final String kindOfGrape;
  final String description;
  final int price;
  final int quantity;
  final String imageUrl; // Define the imageUrl property


  WineModel({
    required this.id,
    required this.name,
    required this.kindOfGrape,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl, // Provide a default value if needed

  });
}

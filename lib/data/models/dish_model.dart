/// Model class representing a food dish
class Dish {
  final String id;
  final String name;
  final String arabicName;
  final String imageAsset;
  final double price;
  final String category;
  final String categoryDisplayName;
  final double rating;
  final int reviewCount;
  final String? description;

  const Dish({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.imageAsset,
    required this.price,
    required this.category,
    required this.categoryDisplayName,
    this.rating = 5.0,
    this.reviewCount = 100,
    this.description,
  });
}

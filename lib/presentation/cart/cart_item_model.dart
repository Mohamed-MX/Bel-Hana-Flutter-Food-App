/// Model representing a single item in the shopping cart
class CartItemModel {
  final String dishId;
  final String arabicName;
  final String imageAsset;
  final double price;
  final int quantity;

  const CartItemModel({
    required this.dishId,
    required this.arabicName,
    required this.imageAsset,
    required this.price,
    required this.quantity,
  });

  CartItemModel copyWith({int? quantity}) {
    return CartItemModel(
      dishId: dishId,
      arabicName: arabicName,
      imageAsset: imageAsset,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': dishId,
      'arabicName': arabicName,
      'imageAsset': imageAsset,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItemModel.fromMap(Map<String, dynamic> map) {
    return CartItemModel(
      dishId: map['id'] as String,
      arabicName: map['arabicName'] as String,
      imageAsset: map['imageAsset'] as String,
      price: (map['price'] as num).toDouble(),
      quantity: map['quantity'] as int,
    );
  }
}

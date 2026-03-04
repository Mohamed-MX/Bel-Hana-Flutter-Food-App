import 'cart_item_model.dart';

/// State of the shopping cart, holding a list of real cart items
class CartState {
  final List<CartItemModel> items;

  const CartState({this.items = const []});

  /// Total number of individual units in the cart
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  /// Sum of (price × quantity) for all items
  double get subtotal =>
      items.fold(0.0, (sum, item) => sum + item.price * item.quantity);

  /// Fixed delivery fee
  double get deliveryFee => items.isEmpty ? 0.0 : 0.30;

  /// Total to pay
  double get total => subtotal + deliveryFee;

  CartState copyWith({List<CartItemModel>? items}) {
    return CartState(items: items ?? this.items);
  }
}

/// Represents the state of the shopping cart
class CartState {
  final int itemCount;

  const CartState({this.itemCount = 0});

  CartState copyWith({int? itemCount}) {
    return CartState(itemCount: itemCount ?? this.itemCount);
  }
}

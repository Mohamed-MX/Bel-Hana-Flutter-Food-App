/// Events for the Cart Bloc
sealed class CartEvent {}

/// Fired when user taps add-to-cart on a dish
class CartItemAdded extends CartEvent {}

/// Fired when an item is removed from cart
class CartItemRemoved extends CartEvent {}

/// Fired to clear the entire cart
class CartCleared extends CartEvent {}

import '../../data/models/dish_model.dart';

/// Events for the Cart Bloc
sealed class CartEvent {}

/// Load all items from DB on startup
class CartLoaded extends CartEvent {}

/// Add a dish to cart (or increment its quantity) — used from home screen
class CartItemAdded extends CartEvent {
  final Dish dish;
  CartItemAdded(this.dish);
}

/// Increment quantity of an existing cart item by 1 — used from cart screen
class CartItemIncremented extends CartEvent {
  final String dishId;
  CartItemIncremented(this.dishId);
}

/// Decrement quantity by 1 (removes item if qty reaches 0)
class CartItemDecremented extends CartEvent {
  final String dishId;
  CartItemDecremented(this.dishId);
}

/// Set exact quantity for an item
class CartItemQuantityChanged extends CartEvent {
  final String dishId;
  final int quantity;
  CartItemQuantityChanged(this.dishId, this.quantity);
}

/// Remove an item entirely
class CartItemRemoved extends CartEvent {
  final String dishId;
  CartItemRemoved(this.dishId);
}

/// Clear all cart items
class CartCleared extends CartEvent {}

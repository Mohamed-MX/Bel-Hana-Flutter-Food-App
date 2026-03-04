import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/cart_database_helper.dart';
import 'cart_item_model.dart';
import 'cart_event.dart';
import 'cart_state.dart';

/// Bloc managing the shopping cart backed by SQLite
class CartBloc extends Bloc<CartEvent, CartState> {
  final CartDatabaseHelper _db;

  CartBloc(this._db) : super(const CartState()) {
    on<CartLoaded>(_onLoaded);
    on<CartItemAdded>(_onItemAdded);
    on<CartItemIncremented>(_onItemIncremented);
    on<CartItemDecremented>(_onItemDecremented);
    on<CartItemQuantityChanged>(_onQuantityChanged);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartCleared>(_onCleared);

    // Load persisted cart on startup
    add(CartLoaded());
  }

  Future<void> _onLoaded(CartLoaded event, Emitter<CartState> emit) async {
    final items = await _db.getAllItems();
    emit(state.copyWith(items: items));
  }

  Future<void> _onItemAdded(CartItemAdded event, Emitter<CartState> emit) async {
    final dish = event.dish;
    final newItem = CartItemModel(
      dishId: dish.id,
      arabicName: dish.arabicName,
      imageAsset: dish.imageAsset,
      price: dish.price,
      quantity: 1,
    );
    await _db.insertOrIncrement(newItem);
    final items = await _db.getAllItems();
    emit(state.copyWith(items: items));
  }

  Future<void> _onItemIncremented(
      CartItemIncremented event, Emitter<CartState> emit) async {
    final existing = state.items.firstWhere(
      (i) => i.dishId == event.dishId,
      orElse: () => const CartItemModel(
        dishId: '', arabicName: '', imageAsset: '', price: 0, quantity: 0,
      ),
    );
    if (existing.dishId.isEmpty) return;
    await _db.updateQuantity(event.dishId, existing.quantity + 1);
    final items = await _db.getAllItems();
    emit(state.copyWith(items: items));
  }

  Future<void> _onItemDecremented(
      CartItemDecremented event, Emitter<CartState> emit) async {
    final existing = state.items.firstWhere(
      (i) => i.dishId == event.dishId,
      orElse: () => const CartItemModel(
        dishId: '', arabicName: '', imageAsset: '', price: 0, quantity: 0,
      ),
    );
    if (existing.dishId.isEmpty) return;
    final newQty = existing.quantity - 1;
    await _db.updateQuantity(event.dishId, newQty);
    final items = await _db.getAllItems();
    emit(state.copyWith(items: items));
  }

  Future<void> _onQuantityChanged(
      CartItemQuantityChanged event, Emitter<CartState> emit) async {
    await _db.updateQuantity(event.dishId, event.quantity);
    final items = await _db.getAllItems();
    emit(state.copyWith(items: items));
  }

  Future<void> _onItemRemoved(
      CartItemRemoved event, Emitter<CartState> emit) async {
    await _db.deleteItem(event.dishId);
    final items = await _db.getAllItems();
    emit(state.copyWith(items: items));
  }

  Future<void> _onCleared(CartCleared event, Emitter<CartState> emit) async {
    await _db.clearCart();
    emit(const CartState());
  }
}

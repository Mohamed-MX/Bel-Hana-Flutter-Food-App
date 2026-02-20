import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';

/// Bloc managing shopping cart item count
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<CartItemAdded>(_onItemAdded);
    on<CartItemRemoved>(_onItemRemoved);
    on<CartCleared>(_onCleared);
  }

  void _onItemAdded(CartItemAdded event, Emitter<CartState> emit) {
    emit(state.copyWith(itemCount: state.itemCount + 1));
  }

  void _onItemRemoved(CartItemRemoved event, Emitter<CartState> emit) {
    if (state.itemCount > 0) {
      emit(state.copyWith(itemCount: state.itemCount - 1));
    }
  }

  void _onCleared(CartCleared event, Emitter<CartState> emit) {
    emit(const CartState());
  }
}

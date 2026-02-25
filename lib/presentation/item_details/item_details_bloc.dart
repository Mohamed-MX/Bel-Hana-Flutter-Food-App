import 'package:flutter_bloc/flutter_bloc.dart';
import 'item_details_event.dart';
import 'item_details_state.dart';

/// Bloc managing item details page state
class ItemDetailsBloc extends Bloc<ItemDetailsEvent, ItemDetailsState> {
  ItemDetailsBloc({required double basePrice})
      : super(ItemDetailsState(
          basePrice: basePrice,
          sizes: const [
            ItemOption(name: 'سنجل', price: 0.50),
            ItemOption(name: 'دبل', price: 0.50),
          ],
          extras: const [
            ItemOption(name: 'سلطة', price: 0.00),
            ItemOption(name: 'حار', price: 0.00),
            ItemOption(name: 'عادي', price: 0.00),
          ],
          types: const [
            ItemOption(name: 'عادي', price: 0.00),
            ItemOption(name: 'سبايسي', price: 5.00),
            ItemOption(name: 'بالجبنة', price: 10.00),
          ],
        )) {
    on<ItemQuantityChanged>(_onQuantityChanged);
    on<ItemSizeSelected>(_onSizeSelected);
    on<ItemExtraToggled>(_onExtraToggled);
    on<ItemTypeSelected>(_onTypeSelected);
  }

  void _onQuantityChanged(
      ItemQuantityChanged event, Emitter<ItemDetailsState> emit) {
    if (event.quantity >= 1) {
      emit(state.copyWith(quantity: event.quantity));
    }
  }

  void _onSizeSelected(
      ItemSizeSelected event, Emitter<ItemDetailsState> emit) {
    emit(state.copyWith(selectedSizeIndex: event.sizeIndex));
  }

  void _onExtraToggled(
      ItemExtraToggled event, Emitter<ItemDetailsState> emit) {
    final newExtras = Set<int>.from(state.selectedExtras);
    if (newExtras.contains(event.extraIndex)) {
      newExtras.remove(event.extraIndex);
    } else {
      newExtras.add(event.extraIndex);
    }
    emit(state.copyWith(selectedExtras: newExtras));
  }

  void _onTypeSelected(
      ItemTypeSelected event, Emitter<ItemDetailsState> emit) {
    emit(state.copyWith(selectedTypeIndex: event.typeIndex));
  }
}

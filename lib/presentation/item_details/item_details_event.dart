/// Events for the Item Details Bloc
sealed class ItemDetailsEvent {}

/// Update quantity of items
class ItemQuantityChanged extends ItemDetailsEvent {
  final int quantity;
  ItemQuantityChanged(this.quantity);
}

/// Select a size option
class ItemSizeSelected extends ItemDetailsEvent {
  final int sizeIndex;
  ItemSizeSelected(this.sizeIndex);
}

/// Toggle an extra option
class ItemExtraToggled extends ItemDetailsEvent {
  final int extraIndex;
  ItemExtraToggled(this.extraIndex);
}

/// Select a type option
class ItemTypeSelected extends ItemDetailsEvent {
  final int typeIndex;
  ItemTypeSelected(this.typeIndex);
}

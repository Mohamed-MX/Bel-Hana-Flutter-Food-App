/// Option model for size/extra/type selections
class ItemOption {
  final String name;
  final double price;

  const ItemOption({required this.name, this.price = 0.0});
}

/// State for the Item Details Bloc
class ItemDetailsState {
  final int quantity;
  final int? selectedSizeIndex;
  final Set<int> selectedExtras;
  final int? selectedTypeIndex;
  final double basePrice;

  // Available options
  final List<ItemOption> sizes;
  final List<ItemOption> extras;
  final List<ItemOption> types;

  const ItemDetailsState({
    this.quantity = 1,
    this.selectedSizeIndex,
    this.selectedExtras = const {},
    this.selectedTypeIndex,
    this.basePrice = 0.0,
    this.sizes = const [],
    this.extras = const [],
    this.types = const [],
  });

  /// Calculate total price: (base + size + extras) * quantity
  double get totalPrice {
    double price = basePrice;

    if (selectedSizeIndex != null && selectedSizeIndex! < sizes.length) {
      price += sizes[selectedSizeIndex!].price;
    }

    for (final idx in selectedExtras) {
      if (idx < extras.length) {
        price += extras[idx].price;
      }
    }

    return price * quantity;
  }

  ItemDetailsState copyWith({
    int? quantity,
    int? selectedSizeIndex,
    Set<int>? selectedExtras,
    int? selectedTypeIndex,
    double? basePrice,
    List<ItemOption>? sizes,
    List<ItemOption>? extras,
    List<ItemOption>? types,
  }) {
    return ItemDetailsState(
      quantity: quantity ?? this.quantity,
      selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
      selectedExtras: selectedExtras ?? this.selectedExtras,
      selectedTypeIndex: selectedTypeIndex ?? this.selectedTypeIndex,
      basePrice: basePrice ?? this.basePrice,
      sizes: sizes ?? this.sizes,
      extras: extras ?? this.extras,
      types: types ?? this.types,
    );
  }
}

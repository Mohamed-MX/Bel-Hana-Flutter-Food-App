import '../../data/models/dish_model.dart';

/// State for Favourites Bloc
class FavoritesState {
  final List<Dish> favorites;
  final Set<String> favoriteIds;

  const FavoritesState({
    this.favorites = const [],
    this.favoriteIds = const {},
  });

  bool isFavorite(String id) => favoriteIds.contains(id);

  FavoritesState copyWith({
    List<Dish>? favorites,
    Set<String>? favoriteIds,
  }) {
    return FavoritesState(
      favorites: favorites ?? this.favorites,
      favoriteIds: favoriteIds ?? this.favoriteIds,
    );
  }
}

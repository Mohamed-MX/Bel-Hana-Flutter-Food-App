import '../../data/models/dish_model.dart';

/// Events for the Favourites Bloc
sealed class FavoritesEvent {}

/// Trigger initial load from SQLite
class FavoritesLoaded extends FavoritesEvent {}

/// Add a dish to favourites
class FavoriteAdded extends FavoritesEvent {
  final Dish dish;
  FavoriteAdded(this.dish);
}

/// Remove a dish from favourites by ID
class FavoriteRemoved extends FavoritesEvent {
  final String dishId;
  FavoriteRemoved(this.dishId);
}

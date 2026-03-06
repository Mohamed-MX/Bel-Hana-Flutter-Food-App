import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/favorites_database_helper.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

/// BLoC managing the favourites list backed by SQLite
class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final FavoritesDatabaseHelper _db;

  FavoritesBloc(this._db) : super(const FavoritesState()) {
    on<FavoritesLoaded>(_onLoaded);
    on<FavoriteAdded>(_onAdded);
    on<FavoriteRemoved>(_onRemoved);

    // Load persisted favourites on startup
    add(FavoritesLoaded());
  }

  Future<void> _onLoaded(
      FavoritesLoaded event, Emitter<FavoritesState> emit) async {
    final favorites = await _db.getAllFavorites();
    final ids = favorites.map((d) => d.id).toSet();
    emit(state.copyWith(favorites: favorites, favoriteIds: ids));
  }

  Future<void> _onAdded(
      FavoriteAdded event, Emitter<FavoritesState> emit) async {
    await _db.addFavorite(event.dish);
    final favorites = await _db.getAllFavorites();
    final ids = favorites.map((d) => d.id).toSet();
    emit(state.copyWith(favorites: favorites, favoriteIds: ids));
  }

  Future<void> _onRemoved(
      FavoriteRemoved event, Emitter<FavoritesState> emit) async {
    await _db.removeFavorite(event.dishId);
    final favorites = await _db.getAllFavorites();
    final ids = favorites.map((d) => d.id).toSet();
    emit(state.copyWith(favorites: favorites, favoriteIds: ids));
  }
}

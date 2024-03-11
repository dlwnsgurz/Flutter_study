import 'package:favorite_places/models/favorite_place.dart';
import 'package:riverpod/riverpod.dart';

class PlaceNotifier extends StateNotifier<List<FavoritePlace>> {
  PlaceNotifier() : super([]);

  void addFavoritePlace(FavoritePlace place) {
    state = [...state, place];
  }

  void removeFavoritePlace(FavoritePlace place) {
    state = [
      for (final item in state)
        if (item.id != place.id) item,
    ];
  }
}

final placeProvider = StateNotifierProvider((ref) => PlaceNotifier());

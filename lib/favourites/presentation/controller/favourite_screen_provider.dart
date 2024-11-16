import 'package:flutter/cupertino.dart';

import '../../../core/sqfliteServices/sqflite_services.dart';
class FavoriteMovieProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _favoriteMovie = [];
  List<Map<String, dynamic>> _filteredMovies = [];

  List<Map<String, dynamic>> get favoriteMovie => _filteredMovies.isEmpty ? _favoriteMovie : _filteredMovies;

  // Fetch favorite movies initially
  Future<void> fetchFavoriteMovie() async {
    _favoriteMovie = await SqfliteServices().getData();
    _filteredMovies.clear(); // Clear filtered list when fetching all data
    notifyListeners();
  }

  // Add movie to favorites
  Future<void> addFavoriteMovie(String id, String title, String image) async {
    await SqfliteServices().insertData(id: id, title: title, image: image);
    await fetchFavoriteMovie(); // Fetch updated list
  }

  // Remove movie from favorites
  Future<void> removeFavoriteMovie(String id) async {
    await SqfliteServices().deleteData(id: id);
    await fetchFavoriteMovie(); // Fetch updated list
  }

  // Check if movie is a favorite
  bool isFavoriteMovie(String id) {
    return _favoriteMovie.any((element) => element['id'] == id);
  }

  // Filter movies based on query
  void filterMovies(String query) {
    if (query.isEmpty) {
      _filteredMovies.clear();
    } else {
      _filteredMovies = _favoriteMovie.where((movie) {
        return movie['title'].toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}

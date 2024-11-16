import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String baseImageUrl = "https://image.tmdb.org/t/p/w500";
  static const String movie = "movie";

  static String imageUrl(String path) => '$baseImageUrl$path';
  static String apiKey = dotenv.env['API_KEY'] ?? '';
  static String nowPlayingMoviePath =
      "$baseUrl/movie/now_playing?api_key=$apiKey";
  static String popularMoviePath = "$baseUrl/movie/popular?api_key=$apiKey";
  static String topRatedMoviePath = "$baseUrl/movie/top_rated?api_key=$apiKey";

  static String detailsMoviePath(int movieId) =>
      "$baseUrl/movie/$movieId?api_key=$apiKey";

  static String recommendationsMoviePath(int movieId) =>
      "$baseUrl/movie/$movieId/recommendations?api_key=$apiKey";

  static String searchMoviesBaseUrl(String query, String language) =>
      "$baseUrl/search/movie?api_key=$apiKey&query=$query&language=$language";
}

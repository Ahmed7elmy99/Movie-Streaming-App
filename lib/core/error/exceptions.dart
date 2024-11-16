import 'package:movie_app/core/network/error_movie_model.dart';

class ServerException implements Exception {
  final ErrorMovieModel errorMovieModel;

  ServerException({required this.errorMovieModel});
}

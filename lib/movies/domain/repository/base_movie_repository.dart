import 'package:dartz/dartz.dart';
import 'package:movie_app/movies/domain/entities/details_movies.dart';
import 'package:movie_app/movies/domain/entities/movies.dart';
import 'package:movie_app/movies/domain/entities/recommendation.dart';
import 'package:movie_app/movies/domain/use_case/get_movie_details_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_recommendation_movies_use_case.dart';

import '../../../core/error/failures.dart';

abstract class BaseMovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies();

  Future<Either<Failure, List<Movie>>> getPopularMovies();

  Future<Either<Failure, List<Movie>>> getTopRatedMovies();

  Future<Either<Failure, DetailsMovies>> getMovieDetails(
      MovieDetailsParameter parameter);

  Future<Either<Failure, List<Recommendation>>> getRecommendationMovies(
      RecommendationParameter parameter);
}

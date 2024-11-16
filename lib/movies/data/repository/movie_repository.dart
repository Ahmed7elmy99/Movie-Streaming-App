import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/exceptions.dart';
import 'package:movie_app/movies/domain/entities/details_movies.dart';
import 'package:movie_app/movies/domain/entities/movies.dart';
import 'package:movie_app/movies/domain/entities/recommendation.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repository.dart';
import 'package:movie_app/movies/domain/use_case/get_movie_details_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_recommendation_movies_use_case.dart';

import '../../../core/error/failures.dart';
import '../datasource/movie_remote_data_source.dart';

class MovieRepository extends BaseMovieRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MovieRepository({required this.baseMovieRemoteDataSource});

  @override
  Future<Either<Failure, List<Movie>>> getNowPlayingMovies() async {
    try {
      final result = await baseMovieRemoteDataSource.getNowPlayingMovies();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMovieModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getPopularMovies() async {
    try {
      final result = await baseMovieRemoteDataSource.getPopularMovies();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMovieModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Movie>>> getTopRatedMovies() async {
    try {
      final result = await baseMovieRemoteDataSource.getTopRatedMovies();
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMovieModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, DetailsMovies>> getMovieDetails(
      MovieDetailsParameter parameter) async {
    try {
      final result =
          await baseMovieRemoteDataSource.getMoviesDetails(parameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMovieModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendationMovies(
      RecommendationParameter parameter) async {
    try {
      final result =
          await baseMovieRemoteDataSource.getRecommendationMovies(parameter);
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMovieModel.statusMessage));
    }
  }
}

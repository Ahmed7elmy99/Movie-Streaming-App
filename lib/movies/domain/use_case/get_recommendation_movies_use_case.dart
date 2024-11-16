import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart%20';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/core/useCases/base_use_cases.dart';
import 'package:movie_app/movies/domain/entities/recommendation.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repository.dart';

class GetRecommendationMoviesUseCase
    extends BaseUseCases<List<Recommendation>, RecommendationParameter> {
  final BaseMovieRepository baseMovieRepository;

  GetRecommendationMoviesUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Recommendation>>> call(parameter) async {
    return await baseMovieRepository.getRecommendationMovies(parameter);
  }
}

class RecommendationParameter extends Equatable {
  final int id;

  const RecommendationParameter({required this.id});

  @override
  List<Object?> get props => [id];
}

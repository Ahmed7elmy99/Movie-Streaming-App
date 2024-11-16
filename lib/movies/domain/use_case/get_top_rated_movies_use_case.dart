import 'package:dartz/dartz.dart';
import 'package:movie_app/core/useCases/base_use_cases.dart';
import 'package:movie_app/movies/domain/entities/movies.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repository.dart';

import '../../../core/error/failures.dart';

class GetTopRatedMoviesUseCase extends BaseUseCases<List<Movie>,NoParameter> {
  final BaseMovieRepository baseMovieRepository;

  GetTopRatedMoviesUseCase(this.baseMovieRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(NoParameter parameter) async {
    return await baseMovieRepository.getTopRatedMovies();
  }
}

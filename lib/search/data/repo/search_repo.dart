import 'package:dartz/dartz.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/error/failures.dart';
import '../../../movies/domain/entities/movies.dart';
import '../../domain/repo/base_search_repo.dart';
import '../../domain/use_case/get_movie_search_use_case.dart';
import '../data_source/base_search_remote_data_source.dart';

class SearchRepo extends BaseSearchRepo {
  final BaseSearchRemoteDataSource remoteDataSource;

  SearchRepo(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Movie>>> getMoviesSearch(
    SearchMoviesParams params,
  ) async {
    final result = await remoteDataSource.getMoviesSearch(params);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      ///TO DO
      return Left(ServerFailure(failure.errorMovieModel.statusMessage));
    }
  }
}

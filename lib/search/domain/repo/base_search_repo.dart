import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../movies/domain/entities/movies.dart';
import '../use_case/get_movie_search_use_case.dart';


abstract class BaseSearchRepo {
  Future<Either<Failure, List<Movie>>> getMoviesSearch(
      SearchMoviesParams params,
      );

// Future<Either<Failure, List<MovieEntity>>> getPeopleSearch();
// Future<Either<Failure, SearchDetailsEntity>> getSearchDetails(
//   SearchDetailsParams params,
// );
// Future<Either<Failure, List<SimilarSearchEntity>>> getSimilarSearch(
//   SimilarSearchParams params,
// );
}
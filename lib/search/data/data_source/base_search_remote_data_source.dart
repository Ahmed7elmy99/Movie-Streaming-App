import '../../../movies/data/model/movie_model.dart';
import '../../domain/use_case/get_movie_search_use_case.dart';

abstract class BaseSearchRemoteDataSource {
  Future<List<MovieModel>> getMoviesSearch(SearchMoviesParams params);
}

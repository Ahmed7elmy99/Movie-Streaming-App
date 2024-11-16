import 'package:get_it/get_it.dart';
import 'package:movie_app/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movie_app/movies/data/repository/movie_repository.dart';
import 'package:movie_app/movies/domain/repository/base_movie_repository.dart';
import 'package:movie_app/movies/domain/use_case/get_recommendation_movies_use_case.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_bloc.dart';
import 'package:movie_app/search/data/data_source/base_search_remote_data_source.dart';
import 'package:movie_app/search/data/data_source/search_remote_data_source.dart';
import 'package:movie_app/search/data/repo/history_repo.dart';
import 'package:movie_app/search/data/repo/search_repo.dart';
import 'package:movie_app/search/domain/repo/base_history_repo.dart';
import 'package:movie_app/search/domain/repo/base_search_repo.dart';
import 'package:movie_app/search/domain/use_case/get_movie_search_use_case.dart';
import 'package:movie_app/search/presentation/controller/history_bloc.dart';
import 'package:movie_app/search/presentation/controller/search_bloc.dart';

import '../../movies/domain/use_case/get_movie_details_use_case.dart';
import '../../movies/domain/use_case/get_now_playing_movies_use_case.dart';
import '../../movies/domain/use_case/get_popular_movies_use_case.dart';
import '../../movies/domain/use_case/get_top_rated_movies_use_case.dart';
import '../../movies/presentation/controllers/movies_bloc.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    // Remote Data Sources
    getIt.registerLazySingleton<BaseMovieRemoteDataSource>(() => MovieRemoteDataSource());
    getIt.registerLazySingleton<BaseSearchRemoteDataSource>(() => SearchRemoteDataSource());
    getIt.registerLazySingleton<BaseHistoryRepository>(() => HistoryRepository());

    // Repositories
    getIt.registerLazySingleton<BaseMovieRepository>(() => MovieRepository(baseMovieRemoteDataSource: getIt()));
    getIt.registerLazySingleton<BaseSearchRepo>(() => SearchRepo(getIt()));

    // Use Cases
    getIt.registerLazySingleton(() => GetNowPlayingMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetPopularMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetTopRatedMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetMovieDetailsUseCase(getIt()));
    getIt.registerLazySingleton(() => GetRecommendationMoviesUseCase(getIt()));
    getIt.registerLazySingleton(() => GetSearchMoviesUseCase(getIt()));

    // Blocs
    getIt.registerFactory<MoviesBloc>(() => MoviesBloc(getIt(), getIt(), getIt()));
    getIt.registerFactory<MovieDetailsBloc>(() => MovieDetailsBloc(getIt(), getIt()));
    getIt.registerFactory(() => SearchBloc(getIt()));
    getIt.registerFactory<HistoryBloc>(() => HistoryBloc(getIt()));
  }
}

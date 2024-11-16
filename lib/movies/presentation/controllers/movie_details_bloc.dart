import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:movie_app/movies/domain/use_case/get_movie_details_use_case.dart';
import 'package:movie_app/movies/domain/use_case/get_recommendation_movies_use_case.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_event.dart';
import 'package:movie_app/movies/presentation/controllers/movie_details_state.dart';

import '../../../core/utils/enums.dart';

class MovieDetailsBloc extends Bloc<MoviesDetailsEvents, MovieDetailsState> {
  MovieDetailsBloc(
      this.getMovieDetailsUseCase, this.getRecommendationMoviesUseCase)
      : super(const MovieDetailsState()) {
    on<GetDetailsMovieEvent>(_getDetailsMovieEvent);
    on<GetRecommendedMoviesEvent>(_getRecommendationMovieEvent);
  }

  final GetMovieDetailsUseCase getMovieDetailsUseCase;
  final GetRecommendationMoviesUseCase getRecommendationMoviesUseCase;

  FutureOr<void> _getDetailsMovieEvent(
      GetDetailsMovieEvent event, Emitter<MovieDetailsState> emit) async {
    final result =
        await getMovieDetailsUseCase(MovieDetailsParameter(movieId: event.id));

    result.fold(
      (l) => emit(state.copyWith(
          moviesDetailsState: RequestState.error,
          moviesDetailsMessage: l.errMessage)),
      (r) => emit(
        state.copyWith(
            moviesDetails: r, moviesDetailsState: RequestState.loaded),
      ),
    );
  }

  FutureOr<void> _getRecommendationMovieEvent(
      GetRecommendedMoviesEvent event, Emitter<MovieDetailsState> emit) async {
    final result = await getRecommendationMoviesUseCase(
      RecommendationParameter(id: event.id),
    );

    result.fold(
      (l) => emit(state.copyWith(
          moviesRecommendationState: RequestState.error,
          moviesRecommendationMessage: l.errMessage)),
      (r) => emit(
        state.copyWith(
            moviesRecommendation: r, moviesDetailsState: RequestState.loaded),
      ),
    );
  }
}

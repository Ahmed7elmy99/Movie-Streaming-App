import 'package:equatable/equatable.dart%20';
import 'package:movie_app/core/utils/enums.dart';
import 'package:movie_app/movies/domain/entities/details_movies.dart';

import '../../domain/entities/recommendation.dart';

class MovieDetailsState extends Equatable {
  final DetailsMovies? moviesDetails;
  final RequestState moviesDetailsState;
  final String moviesDetailsMessage;
  final List<Recommendation> moviesRecommendation;
  final RequestState moviesRecommendationState;
  final String moviesRecommendationMessage;

  const MovieDetailsState({
    this.moviesDetails,
    this.moviesDetailsState = RequestState.loading,
    this.moviesDetailsMessage = '',
    this.moviesRecommendation = const [],
    this.moviesRecommendationState = RequestState.loading,
    this.moviesRecommendationMessage = '',
  });

  MovieDetailsState copyWith({
    DetailsMovies? moviesDetails,
    RequestState? moviesDetailsState,
    String? moviesDetailsMessage,
    List<Recommendation>? moviesRecommendation,
    RequestState? moviesRecommendationState,
    String? moviesRecommendationMessage,
  }) {
    return MovieDetailsState(
      moviesDetails: moviesDetails ?? this.moviesDetails,
      moviesDetailsState: moviesDetailsState ?? this.moviesDetailsState,
      moviesDetailsMessage: moviesDetailsMessage ?? this.moviesDetailsMessage,
      moviesRecommendation: moviesRecommendation ?? this.moviesRecommendation,
      moviesRecommendationState:
          moviesRecommendationState ?? this.moviesRecommendationState,
      moviesRecommendationMessage:
          moviesRecommendationMessage ?? this.moviesRecommendationMessage,
    );
  }

  @override
  List<Object?> get props => [
        moviesDetailsState,
        moviesDetails,
        moviesDetailsMessage,
        moviesRecommendation,
        moviesRecommendationState,
        moviesRecommendationMessage,
      ];
}

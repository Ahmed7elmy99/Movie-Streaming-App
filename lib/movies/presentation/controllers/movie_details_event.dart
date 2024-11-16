import 'package:equatable/equatable.dart%20';

abstract class MoviesDetailsEvents extends Equatable {
  final int id;

  const MoviesDetailsEvents(this.id);

  @override
  List<Object?> get props => [id];
}

class GetDetailsMovieEvent extends MoviesDetailsEvents {
  const GetDetailsMovieEvent(super.id);
}

class GetRecommendedMoviesEvent extends MoviesDetailsEvents {
  const GetRecommendedMoviesEvent(super.id);
}

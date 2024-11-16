import 'package:equatable/equatable.dart%20';

abstract class MoviesEvents extends Equatable {
  const MoviesEvents();

  @override
  List<Object?> get props => [];
}

class GetNowPlayingMoviesEvent extends MoviesEvents {}

class GetPopularMoviesEvent extends MoviesEvents {}

class GetTopRatedMoviesEvent extends MoviesEvents {}

class FetchAllMoviesEvent extends MoviesEvents {}


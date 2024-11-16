import 'package:equatable/equatable.dart%20';

import '../../../movies/domain/entities/movies.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

// Movies Search States
class SearchMoviesSuccess extends SearchState {
  final List<Movie> results;

  const SearchMoviesSuccess(this.results);

  @override
  List<Object> get props => [results];
}

class SearchMoviesError extends SearchState {
  final String message;

  const SearchMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

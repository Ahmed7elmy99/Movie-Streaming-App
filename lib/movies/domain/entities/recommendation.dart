import 'package:equatable/equatable.dart%20';

class Recommendation extends Equatable {
  final String? backdropPath;
  final int id;
  final String? posterPath;

  const Recommendation({this.posterPath, this.backdropPath, required this.id});

  @override
  List<Object?> get props => [backdropPath, id, posterPath];
}

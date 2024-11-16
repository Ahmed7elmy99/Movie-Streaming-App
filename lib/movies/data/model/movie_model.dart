import 'package:movie_app/movies/domain/entities/movies.dart';

class MovieModel extends Movie {
  const MovieModel(
      {required super.title,
      required super.backdropPath,
      required super.id,
      required super.voteAverage,
      required super.genreIds,
      required super.overview,
      required super.releaseDate,
      required super.posterPath});

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
      title: json["title"],
      backdropPath: json["backdrop_path"] ?? "",
      id: json["id"],
      voteAverage: json["vote_average"].toDouble() ?? 0.0,
      genreIds: List<int>.from(json["genre_ids"].map((e) => e)),
      overview: json["overview"] ?? "",
      releaseDate: json["release_date"] ?? '',
      posterPath: json["poster_path"] ?? "");
}

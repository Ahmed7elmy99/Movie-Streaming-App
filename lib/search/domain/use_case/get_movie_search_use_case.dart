import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/useCases/base_use_cases.dart';
import '../../../../movies/domain/entities/movies.dart';
import '../repo/base_search_repo.dart';

class GetSearchMoviesUseCase
    extends BaseUseCases<List<Movie>, SearchMoviesParams> {
  final BaseSearchRepo baseSearchRepo;

  GetSearchMoviesUseCase(this.baseSearchRepo);

  @override
  Future<Either<Failure, List<Movie>>> call(
    SearchMoviesParams parameter,
  ) async {
    return await baseSearchRepo.getMoviesSearch(parameter);
  }
}

class SearchMoviesParams extends Equatable {
  final String query;

  const SearchMoviesParams({required this.query});

  @override
  List<Object> get props => [query];
}
